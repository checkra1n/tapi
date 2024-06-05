//===- MipsInstructionSelector.cpp ------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file implements the targeting of the InstructionSelector class for
/// Mips.
/// \todo This should be generated by TableGen.
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/MipsInstPrinter.h"
#include "MipsMachineFunction.h"
#include "MipsRegisterBankInfo.h"
#include "MipsTargetMachine.h"
#include "llvm/CodeGen/GlobalISel/InstructionSelectorImpl.h"
#include "llvm/CodeGen/GlobalISel/MachineIRBuilder.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/IR/IntrinsicsMips.h"

#define DEBUG_TYPE "mips-isel"

using namespace llvm;

namespace {

#define GET_GLOBALISEL_PREDICATE_BITSET
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_PREDICATE_BITSET

class MipsInstructionSelector : public InstructionSelector {
public:
  MipsInstructionSelector(const MipsTargetMachine &TM, const MipsSubtarget &STI,
                          const MipsRegisterBankInfo &RBI);

  bool select(MachineInstr &I) override;
  static const char *getName() { return DEBUG_TYPE; }

private:
  bool selectImpl(MachineInstr &I, CodeGenCoverage &CoverageInfo) const;
  bool isRegInGprb(Register Reg, MachineRegisterInfo &MRI) const;
  bool isRegInFprb(Register Reg, MachineRegisterInfo &MRI) const;
  bool materialize32BitImm(Register DestReg, APInt Imm,
                           MachineIRBuilder &B) const;
  bool selectCopy(MachineInstr &I, MachineRegisterInfo &MRI) const;
  const TargetRegisterClass *
  getRegClassForTypeOnBank(Register Reg, MachineRegisterInfo &MRI) const;
  unsigned selectLoadStoreOpCode(MachineInstr &I,
                                 MachineRegisterInfo &MRI) const;
  bool buildUnalignedStore(MachineInstr &I, unsigned Opc,
                           MachineOperand &BaseAddr, unsigned Offset,
                           MachineMemOperand *MMO) const;
  bool buildUnalignedLoad(MachineInstr &I, unsigned Opc, Register Dest,
                          MachineOperand &BaseAddr, unsigned Offset,
                          Register TiedDest, MachineMemOperand *MMO) const;

  const MipsTargetMachine &TM;
  const MipsSubtarget &STI;
  const MipsInstrInfo &TII;
  const MipsRegisterInfo &TRI;
  const MipsRegisterBankInfo &RBI;

#define GET_GLOBALISEL_PREDICATES_DECL
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_PREDICATES_DECL

#define GET_GLOBALISEL_TEMPORARIES_DECL
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_TEMPORARIES_DECL
};

} // end anonymous namespace

#define GET_GLOBALISEL_IMPL
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_IMPL

MipsInstructionSelector::MipsInstructionSelector(
    const MipsTargetMachine &TM, const MipsSubtarget &STI,
    const MipsRegisterBankInfo &RBI)
    : TM(TM), STI(STI), TII(*STI.getInstrInfo()), TRI(*STI.getRegisterInfo()),
      RBI(RBI),

#define GET_GLOBALISEL_PREDICATES_INIT
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_PREDICATES_INIT
#define GET_GLOBALISEL_TEMPORARIES_INIT
#include "MipsGenGlobalISel.inc"
#undef GET_GLOBALISEL_TEMPORARIES_INIT
{
}

bool MipsInstructionSelector::isRegInGprb(Register Reg,
                                          MachineRegisterInfo &MRI) const {
  return RBI.getRegBank(Reg, MRI, TRI)->getID() == Mips::GPRBRegBankID;
}

bool MipsInstructionSelector::isRegInFprb(Register Reg,
                                          MachineRegisterInfo &MRI) const {
  return RBI.getRegBank(Reg, MRI, TRI)->getID() == Mips::FPRBRegBankID;
}

bool MipsInstructionSelector::selectCopy(MachineInstr &I,
                                         MachineRegisterInfo &MRI) const {
  Register DstReg = I.getOperand(0).getReg();
  if (Register::isPhysicalRegister(DstReg))
    return true;

  const TargetRegisterClass *RC = getRegClassForTypeOnBank(DstReg, MRI);
  if (!RBI.constrainGenericRegister(DstReg, *RC, MRI)) {
    LLVM_DEBUG(dbgs() << "Failed to constrain " << TII.getName(I.getOpcode())
                      << " operand\n");
    return false;
  }
  return true;
}

const TargetRegisterClass *MipsInstructionSelector::getRegClassForTypeOnBank(
    Register Reg, MachineRegisterInfo &MRI) const {
  const LLT Ty = MRI.getType(Reg);
  const unsigned TySize = Ty.getSizeInBits();

  if (isRegInGprb(Reg, MRI)) {
    assert((Ty.isScalar() || Ty.isPointer()) && TySize == 32 &&
           "Register class not available for LLT, register bank combination");
    return &Mips::GPR32RegClass;
  }

  if (isRegInFprb(Reg, MRI)) {
    if (Ty.isScalar()) {
      assert((TySize == 32 || TySize == 64) &&
             "Register class not available for LLT, register bank combination");
      if (TySize == 32)
        return &Mips::FGR32RegClass;
      return STI.isFP64bit() ? &Mips::FGR64RegClass : &Mips::AFGR64RegClass;
    }
  }

  llvm_unreachable("Unsupported register bank.");
}

bool MipsInstructionSelector::materialize32BitImm(Register DestReg, APInt Imm,
                                                  MachineIRBuilder &B) const {
  assert(Imm.getBitWidth() == 32 && "Unsupported immediate size.");
  // Ori zero extends immediate. Used for values with zeros in high 16 bits.
  if (Imm.getHiBits(16).isZero()) {
    MachineInstr *Inst =
        B.buildInstr(Mips::ORi, {DestReg}, {Register(Mips::ZERO)})
            .addImm(Imm.getLoBits(16).getLimitedValue());
    return constrainSelectedInstRegOperands(*Inst, TII, TRI, RBI);
  }
  // Lui places immediate in high 16 bits and sets low 16 bits to zero.
  if (Imm.getLoBits(16).isZero()) {
    MachineInstr *Inst = B.buildInstr(Mips::LUi, {DestReg}, {})
                             .addImm(Imm.getHiBits(16).getLimitedValue());
    return constrainSelectedInstRegOperands(*Inst, TII, TRI, RBI);
  }
  // ADDiu sign extends immediate. Used for values with 1s in high 17 bits.
  if (Imm.isSignedIntN(16)) {
    MachineInstr *Inst =
        B.buildInstr(Mips::ADDiu, {DestReg}, {Register(Mips::ZERO)})
            .addImm(Imm.getLoBits(16).getLimitedValue());
    return constrainSelectedInstRegOperands(*Inst, TII, TRI, RBI);
  }
  // Values that cannot be materialized with single immediate instruction.
  Register LUiReg = B.getMRI()->createVirtualRegister(&Mips::GPR32RegClass);
  MachineInstr *LUi = B.buildInstr(Mips::LUi, {LUiReg}, {})
                          .addImm(Imm.getHiBits(16).getLimitedValue());
  MachineInstr *ORi = B.buildInstr(Mips::ORi, {DestReg}, {LUiReg})
                          .addImm(Imm.getLoBits(16).getLimitedValue());
  if (!constrainSelectedInstRegOperands(*LUi, TII, TRI, RBI))
    return false;
  if (!constrainSelectedInstRegOperands(*ORi, TII, TRI, RBI))
    return false;
  return true;
}

/// When I.getOpcode() is returned, we failed to select MIPS instruction opcode.
unsigned
MipsInstructionSelector::selectLoadStoreOpCode(MachineInstr &I,
                                               MachineRegisterInfo &MRI) const {
  const Register ValueReg = I.getOperand(0).getReg();
  const LLT Ty = MRI.getType(ValueReg);
  const unsigned TySize = Ty.getSizeInBits();
  const unsigned MemSizeInBytes = (*I.memoperands_begin())->getSize();
  unsigned Opc = I.getOpcode();
  const bool isStore = Opc == TargetOpcode::G_STORE;

  if (isRegInGprb(ValueReg, MRI)) {
    assert(((Ty.isScalar() && TySize == 32) ||
            (Ty.isPointer() && TySize == 32 && MemSizeInBytes == 4)) &&
           "Unsupported register bank, LLT, MemSizeInBytes combination");
    (void)TySize;
    if (isStore)
      switch (MemSizeInBytes) {
      case 4:
        return Mips::SW;
      case 2:
        return Mips::SH;
      case 1:
        return Mips::SB;
      default:
        return Opc;
      }
    else
      // Unspecified extending load is selected into zeroExtending load.
      switch (MemSizeInBytes) {
      case 4:
        return Mips::LW;
      case 2:
        return Opc == TargetOpcode::G_SEXTLOAD ? Mips::LH : Mips::LHu;
      case 1:
        return Opc == TargetOpcode::G_SEXTLOAD ? Mips::LB : Mips::LBu;
      default:
        return Opc;
      }
  }

  if (isRegInFprb(ValueReg, MRI)) {
    if (Ty.isScalar()) {
      assert(((TySize == 32 && MemSizeInBytes == 4) ||
              (TySize == 64 && MemSizeInBytes == 8)) &&
             "Unsupported register bank, LLT, MemSizeInBytes combination");

      if (MemSizeInBytes == 4)
        return isStore ? Mips::SWC1 : Mips::LWC1;

      if (STI.isFP64bit())
        return isStore ? Mips::SDC164 : Mips::LDC164;
      return isStore ? Mips::SDC1 : Mips::LDC1;
    }

    if (Ty.isVector()) {
      assert(STI.hasMSA() && "Vector instructions require target with MSA.");
      assert((TySize == 128 && MemSizeInBytes == 16) &&
             "Unsupported register bank, LLT, MemSizeInBytes combination");
      switch (Ty.getElementType().getSizeInBits()) {
      case 8:
        return isStore ? Mips::ST_B : Mips::LD_B;
      case 16:
        return isStore ? Mips::ST_H : Mips::LD_H;
      case 32:
        return isStore ? Mips::ST_W : Mips::LD_W;
      case 64:
        return isStore ? Mips::ST_D : Mips::LD_D;
      default:
        return Opc;
      }
    }
  }

  return Opc;
}

bool MipsInstructionSelector::buildUnalignedStore(
    MachineInstr &I, unsigned Opc, MachineOperand &BaseAddr, unsigned Offset,
    MachineMemOperand *MMO) const {
  MachineInstr *NewInst =
      BuildMI(*I.getParent(), I, I.getDebugLoc(), TII.get(Opc))
          .add(I.getOperand(0))
          .add(BaseAddr)
          .addImm(Offset)
          .addMemOperand(MMO);
  if (!constrainSelectedInstRegOperands(*NewInst, TII, TRI, RBI))
    return false;
  return true;
}

bool MipsInstructionSelector::buildUnalignedLoad(
    MachineInstr &I, unsigned Opc, Register Dest, MachineOperand &BaseAddr,
    unsigned Offset, Register TiedDest, MachineMemOperand *MMO) const {
  MachineInstr *NewInst =
      BuildMI(*I.getParent(), I, I.getDebugLoc(), TII.get(Opc))
          .addDef(Dest)
          .add(BaseAddr)
          .addImm(Offset)
          .addUse(TiedDest)
          .addMemOperand(*I.memoperands_begin());
  if (!constrainSelectedInstRegOperands(*NewInst, TII, TRI, RBI))
    return false;
  return true;
}

bool MipsInstructionSelector::select(MachineInstr &I) {

  MachineBasicBlock &MBB = *I.getParent();
  MachineFunction &MF = *MBB.getParent();
  MachineRegisterInfo &MRI = MF.getRegInfo();

  if (!isPreISelGenericOpcode(I.getOpcode())) {
    if (I.isCopy())
      return selectCopy(I, MRI);

    return true;
  }

  if (I.getOpcode() == Mips::G_MUL &&
      isRegInGprb(I.getOperand(0).getReg(), MRI)) {
    MachineInstr *Mul = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::MUL))
                            .add(I.getOperand(0))
                            .add(I.getOperand(1))
                            .add(I.getOperand(2));
    if (!constrainSelectedInstRegOperands(*Mul, TII, TRI, RBI))
      return false;
    Mul->getOperand(3).setIsDead(true);
    Mul->getOperand(4).setIsDead(true);

    I.eraseFromParent();
    return true;
  }

  if (selectImpl(I, *CoverageInfo))
    return true;

  MachineInstr *MI = nullptr;
  using namespace TargetOpcode;

  switch (I.getOpcode()) {
  case G_UMULH: {
    Register PseudoMULTuReg = MRI.createVirtualRegister(&Mips::ACC64RegClass);
    MachineInstr *PseudoMULTu, *PseudoMove;

    PseudoMULTu = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::PseudoMULTu))
                      .addDef(PseudoMULTuReg)
                      .add(I.getOperand(1))
                      .add(I.getOperand(2));
    if (!constrainSelectedInstRegOperands(*PseudoMULTu, TII, TRI, RBI))
      return false;

    PseudoMove = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::PseudoMFHI))
                     .addDef(I.getOperand(0).getReg())
                     .addUse(PseudoMULTuReg);
    if (!constrainSelectedInstRegOperands(*PseudoMove, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_PTR_ADD: {
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDu))
             .add(I.getOperand(0))
             .add(I.getOperand(1))
             .add(I.getOperand(2));
    break;
  }
  case G_INTTOPTR:
  case G_PTRTOINT: {
    I.setDesc(TII.get(COPY));
    return selectCopy(I, MRI);
  }
  case G_FRAME_INDEX: {
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDiu))
             .add(I.getOperand(0))
             .add(I.getOperand(1))
             .addImm(0);
    break;
  }
  case G_BRCOND: {
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::BNE))
             .add(I.getOperand(0))
             .addUse(Mips::ZERO)
             .add(I.getOperand(1));
    break;
  }
  case G_BRJT: {
    unsigned EntrySize =
        MF.getJumpTableInfo()->getEntrySize(MF.getDataLayout());
    assert(isPowerOf2_32(EntrySize) &&
           "Non-power-of-two jump-table entry size not supported.");

    Register JTIndex = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    MachineInstr *SLL = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::SLL))
                            .addDef(JTIndex)
                            .addUse(I.getOperand(2).getReg())
                            .addImm(Log2_32(EntrySize));
    if (!constrainSelectedInstRegOperands(*SLL, TII, TRI, RBI))
      return false;

    Register DestAddress = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    MachineInstr *ADDu = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDu))
                             .addDef(DestAddress)
                             .addUse(I.getOperand(0).getReg())
                             .addUse(JTIndex);
    if (!constrainSelectedInstRegOperands(*ADDu, TII, TRI, RBI))
      return false;

    Register Dest = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    MachineInstr *LW =
        BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LW))
            .addDef(Dest)
            .addUse(DestAddress)
            .addJumpTableIndex(I.getOperand(1).getIndex(), MipsII::MO_ABS_LO)
            .addMemOperand(MF.getMachineMemOperand(
                MachinePointerInfo(), MachineMemOperand::MOLoad, 4, Align(4)));
    if (!constrainSelectedInstRegOperands(*LW, TII, TRI, RBI))
      return false;

    if (MF.getTarget().isPositionIndependent()) {
      Register DestTmp = MRI.createVirtualRegister(&Mips::GPR32RegClass);
      LW->getOperand(0).setReg(DestTmp);
      MachineInstr *ADDu = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDu))
                               .addDef(Dest)
                               .addUse(DestTmp)
                               .addUse(MF.getInfo<MipsFunctionInfo>()
                                           ->getGlobalBaseRegForGlobalISel(MF));
      if (!constrainSelectedInstRegOperands(*ADDu, TII, TRI, RBI))
        return false;
    }

    MachineInstr *Branch =
        BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::PseudoIndirectBranch))
            .addUse(Dest);
    if (!constrainSelectedInstRegOperands(*Branch, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_BRINDIRECT: {
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::PseudoIndirectBranch))
             .add(I.getOperand(0));
    break;
  }
  case G_PHI: {
    const Register DestReg = I.getOperand(0).getReg();

    const TargetRegisterClass *DefRC = nullptr;
    if (Register::isPhysicalRegister(DestReg))
      DefRC = TRI.getRegClass(DestReg);
    else
      DefRC = getRegClassForTypeOnBank(DestReg, MRI);

    I.setDesc(TII.get(TargetOpcode::PHI));
    return RBI.constrainGenericRegister(DestReg, *DefRC, MRI);
  }
  case G_STORE:
  case G_LOAD:
  case G_ZEXTLOAD:
  case G_SEXTLOAD: {
    auto MMO = *I.memoperands_begin();
    MachineOperand BaseAddr = I.getOperand(1);
    int64_t SignedOffset = 0;
    // Try to fold load/store + G_PTR_ADD + G_CONSTANT
    // %SignedOffset:(s32) = G_CONSTANT i32 16_bit_signed_immediate
    // %Addr:(p0) = G_PTR_ADD %BaseAddr, %SignedOffset
    // %LoadResult/%StoreSrc = load/store %Addr(p0)
    // into:
    // %LoadResult/%StoreSrc = NewOpc %BaseAddr(p0), 16_bit_signed_immediate

    MachineInstr *Addr = MRI.getVRegDef(I.getOperand(1).getReg());
    if (Addr->getOpcode() == G_PTR_ADD) {
      MachineInstr *Offset = MRI.getVRegDef(Addr->getOperand(2).getReg());
      if (Offset->getOpcode() == G_CONSTANT) {
        APInt OffsetValue = Offset->getOperand(1).getCImm()->getValue();
        if (OffsetValue.isSignedIntN(16)) {
          BaseAddr = Addr->getOperand(1);
          SignedOffset = OffsetValue.getSExtValue();
        }
      }
    }

    // Unaligned memory access
    if (MMO->getAlign() < MMO->getSize() &&
        !STI.systemSupportsUnalignedAccess()) {
      if (MMO->getSize() != 4 || !isRegInGprb(I.getOperand(0).getReg(), MRI))
        return false;

      if (I.getOpcode() == G_STORE) {
        if (!buildUnalignedStore(I, Mips::SWL, BaseAddr, SignedOffset + 3, MMO))
          return false;
        if (!buildUnalignedStore(I, Mips::SWR, BaseAddr, SignedOffset, MMO))
          return false;
        I.eraseFromParent();
        return true;
      }

      if (I.getOpcode() == G_LOAD) {
        Register ImplDef = MRI.createVirtualRegister(&Mips::GPR32RegClass);
        BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::IMPLICIT_DEF))
            .addDef(ImplDef);
        Register Tmp = MRI.createVirtualRegister(&Mips::GPR32RegClass);
        if (!buildUnalignedLoad(I, Mips::LWL, Tmp, BaseAddr, SignedOffset + 3,
                                ImplDef, MMO))
          return false;
        if (!buildUnalignedLoad(I, Mips::LWR, I.getOperand(0).getReg(),
                                BaseAddr, SignedOffset, Tmp, MMO))
          return false;
        I.eraseFromParent();
        return true;
      }

      return false;
    }

    const unsigned NewOpc = selectLoadStoreOpCode(I, MRI);
    if (NewOpc == I.getOpcode())
      return false;

    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(NewOpc))
             .add(I.getOperand(0))
             .add(BaseAddr)
             .addImm(SignedOffset)
             .addMemOperand(MMO);
    break;
  }
  case G_UDIV:
  case G_UREM:
  case G_SDIV:
  case G_SREM: {
    Register HILOReg = MRI.createVirtualRegister(&Mips::ACC64RegClass);
    bool IsSigned = I.getOpcode() == G_SREM || I.getOpcode() == G_SDIV;
    bool IsDiv = I.getOpcode() == G_UDIV || I.getOpcode() == G_SDIV;

    MachineInstr *PseudoDIV, *PseudoMove;
    PseudoDIV = BuildMI(MBB, I, I.getDebugLoc(),
                        TII.get(IsSigned ? Mips::PseudoSDIV : Mips::PseudoUDIV))
                    .addDef(HILOReg)
                    .add(I.getOperand(1))
                    .add(I.getOperand(2));
    if (!constrainSelectedInstRegOperands(*PseudoDIV, TII, TRI, RBI))
      return false;

    PseudoMove = BuildMI(MBB, I, I.getDebugLoc(),
                         TII.get(IsDiv ? Mips::PseudoMFLO : Mips::PseudoMFHI))
                     .addDef(I.getOperand(0).getReg())
                     .addUse(HILOReg);
    if (!constrainSelectedInstRegOperands(*PseudoMove, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_SELECT: {
    // Handle operands with pointer type.
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::MOVN_I_I))
             .add(I.getOperand(0))
             .add(I.getOperand(2))
             .add(I.getOperand(1))
             .add(I.getOperand(3));
    break;
  }
  case G_UNMERGE_VALUES: {
    if (I.getNumOperands() != 3)
      return false;
    Register Src = I.getOperand(2).getReg();
    Register Lo = I.getOperand(0).getReg();
    Register Hi = I.getOperand(1).getReg();
    if (!isRegInFprb(Src, MRI) ||
        !(isRegInGprb(Lo, MRI) && isRegInGprb(Hi, MRI)))
      return false;

    unsigned Opcode =
        STI.isFP64bit() ? Mips::ExtractElementF64_64 : Mips::ExtractElementF64;

    MachineInstr *ExtractLo = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Opcode))
                                  .addDef(Lo)
                                  .addUse(Src)
                                  .addImm(0);
    if (!constrainSelectedInstRegOperands(*ExtractLo, TII, TRI, RBI))
      return false;

    MachineInstr *ExtractHi = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Opcode))
                                  .addDef(Hi)
                                  .addUse(Src)
                                  .addImm(1);
    if (!constrainSelectedInstRegOperands(*ExtractHi, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_IMPLICIT_DEF: {
    Register Dst = I.getOperand(0).getReg();
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::IMPLICIT_DEF))
             .addDef(Dst);

    // Set class based on register bank, there can be fpr and gpr implicit def.
    MRI.setRegClass(Dst, getRegClassForTypeOnBank(Dst, MRI));
    break;
  }
  case G_CONSTANT: {
    MachineIRBuilder B(I);
    if (!materialize32BitImm(I.getOperand(0).getReg(),
                             I.getOperand(1).getCImm()->getValue(), B))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_FCONSTANT: {
    const APFloat &FPimm = I.getOperand(1).getFPImm()->getValueAPF();
    APInt APImm = FPimm.bitcastToAPInt();
    unsigned Size = MRI.getType(I.getOperand(0).getReg()).getSizeInBits();

    if (Size == 32) {
      Register GPRReg = MRI.createVirtualRegister(&Mips::GPR32RegClass);
      MachineIRBuilder B(I);
      if (!materialize32BitImm(GPRReg, APImm, B))
        return false;

      MachineInstrBuilder MTC1 =
          B.buildInstr(Mips::MTC1, {I.getOperand(0).getReg()}, {GPRReg});
      if (!MTC1.constrainAllUses(TII, TRI, RBI))
        return false;
    }
    if (Size == 64) {
      Register GPRRegHigh = MRI.createVirtualRegister(&Mips::GPR32RegClass);
      Register GPRRegLow = MRI.createVirtualRegister(&Mips::GPR32RegClass);
      MachineIRBuilder B(I);
      if (!materialize32BitImm(GPRRegHigh, APImm.getHiBits(32).trunc(32), B))
        return false;
      if (!materialize32BitImm(GPRRegLow, APImm.getLoBits(32).trunc(32), B))
        return false;

      MachineInstrBuilder PairF64 = B.buildInstr(
          STI.isFP64bit() ? Mips::BuildPairF64_64 : Mips::BuildPairF64,
          {I.getOperand(0).getReg()}, {GPRRegLow, GPRRegHigh});
      if (!PairF64.constrainAllUses(TII, TRI, RBI))
        return false;
    }

    I.eraseFromParent();
    return true;
  }
  case G_FABS: {
    unsigned Size = MRI.getType(I.getOperand(0).getReg()).getSizeInBits();
    unsigned FABSOpcode =
        Size == 32 ? Mips::FABS_S
                   : STI.isFP64bit() ? Mips::FABS_D64 : Mips::FABS_D32;
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(FABSOpcode))
             .add(I.getOperand(0))
             .add(I.getOperand(1));
    break;
  }
  case G_FPTOSI: {
    unsigned FromSize = MRI.getType(I.getOperand(1).getReg()).getSizeInBits();
    unsigned ToSize = MRI.getType(I.getOperand(0).getReg()).getSizeInBits();
    (void)ToSize;
    assert((ToSize == 32) && "Unsupported integer size for G_FPTOSI");
    assert((FromSize == 32 || FromSize == 64) &&
           "Unsupported floating point size for G_FPTOSI");

    unsigned Opcode;
    if (FromSize == 32)
      Opcode = Mips::TRUNC_W_S;
    else
      Opcode = STI.isFP64bit() ? Mips::TRUNC_W_D64 : Mips::TRUNC_W_D32;
    Register ResultInFPR = MRI.createVirtualRegister(&Mips::FGR32RegClass);
    MachineInstr *Trunc = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Opcode))
                .addDef(ResultInFPR)
                .addUse(I.getOperand(1).getReg());
    if (!constrainSelectedInstRegOperands(*Trunc, TII, TRI, RBI))
      return false;

    MachineInstr *Move = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::MFC1))
                             .addDef(I.getOperand(0).getReg())
                             .addUse(ResultInFPR);
    if (!constrainSelectedInstRegOperands(*Move, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_GLOBAL_VALUE: {
    const llvm::GlobalValue *GVal = I.getOperand(1).getGlobal();
    if (MF.getTarget().isPositionIndependent()) {
      MachineInstr *LWGOT = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LW))
                                .addDef(I.getOperand(0).getReg())
                                .addReg(MF.getInfo<MipsFunctionInfo>()
                                            ->getGlobalBaseRegForGlobalISel(MF))
                                .addGlobalAddress(GVal);
      // Global Values that don't have local linkage are handled differently
      // when they are part of call sequence. MipsCallLowering::lowerCall
      // creates G_GLOBAL_VALUE instruction as part of call sequence and adds
      // MO_GOT_CALL flag when Callee doesn't have local linkage.
      if (I.getOperand(1).getTargetFlags() == MipsII::MO_GOT_CALL)
        LWGOT->getOperand(2).setTargetFlags(MipsII::MO_GOT_CALL);
      else
        LWGOT->getOperand(2).setTargetFlags(MipsII::MO_GOT);
      LWGOT->addMemOperand(
          MF, MF.getMachineMemOperand(MachinePointerInfo::getGOT(MF),
                                      MachineMemOperand::MOLoad, 4, Align(4)));
      if (!constrainSelectedInstRegOperands(*LWGOT, TII, TRI, RBI))
        return false;

      if (GVal->hasLocalLinkage()) {
        Register LWGOTDef = MRI.createVirtualRegister(&Mips::GPR32RegClass);
        LWGOT->getOperand(0).setReg(LWGOTDef);

        MachineInstr *ADDiu =
            BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDiu))
                .addDef(I.getOperand(0).getReg())
                .addReg(LWGOTDef)
                .addGlobalAddress(GVal);
        ADDiu->getOperand(2).setTargetFlags(MipsII::MO_ABS_LO);
        if (!constrainSelectedInstRegOperands(*ADDiu, TII, TRI, RBI))
          return false;
      }
    } else {
      Register LUiReg = MRI.createVirtualRegister(&Mips::GPR32RegClass);

      MachineInstr *LUi = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LUi))
                              .addDef(LUiReg)
                              .addGlobalAddress(GVal);
      LUi->getOperand(1).setTargetFlags(MipsII::MO_ABS_HI);
      if (!constrainSelectedInstRegOperands(*LUi, TII, TRI, RBI))
        return false;

      MachineInstr *ADDiu =
          BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDiu))
              .addDef(I.getOperand(0).getReg())
              .addUse(LUiReg)
              .addGlobalAddress(GVal);
      ADDiu->getOperand(2).setTargetFlags(MipsII::MO_ABS_LO);
      if (!constrainSelectedInstRegOperands(*ADDiu, TII, TRI, RBI))
        return false;
    }
    I.eraseFromParent();
    return true;
  }
  case G_JUMP_TABLE: {
    if (MF.getTarget().isPositionIndependent()) {
      MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LW))
               .addDef(I.getOperand(0).getReg())
               .addReg(MF.getInfo<MipsFunctionInfo>()
                           ->getGlobalBaseRegForGlobalISel(MF))
               .addJumpTableIndex(I.getOperand(1).getIndex(), MipsII::MO_GOT)
               .addMemOperand(MF.getMachineMemOperand(
                   MachinePointerInfo::getGOT(MF), MachineMemOperand::MOLoad, 4,
                   Align(4)));
    } else {
      MI =
          BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LUi))
              .addDef(I.getOperand(0).getReg())
              .addJumpTableIndex(I.getOperand(1).getIndex(), MipsII::MO_ABS_HI);
    }
    break;
  }
  case G_ICMP: {
    struct Instr {
      unsigned Opcode;
      Register Def, LHS, RHS;
      Instr(unsigned Opcode, Register Def, Register LHS, Register RHS)
          : Opcode(Opcode), Def(Def), LHS(LHS), RHS(RHS){};

      bool hasImm() const {
        if (Opcode == Mips::SLTiu || Opcode == Mips::XORi)
          return true;
        return false;
      }
    };

    SmallVector<struct Instr, 2> Instructions;
    Register ICMPReg = I.getOperand(0).getReg();
    Register Temp = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    Register LHS = I.getOperand(2).getReg();
    Register RHS = I.getOperand(3).getReg();
    CmpInst::Predicate Cond =
        static_cast<CmpInst::Predicate>(I.getOperand(1).getPredicate());

    switch (Cond) {
    case CmpInst::ICMP_EQ: // LHS == RHS -> (LHS ^ RHS) < 1
      Instructions.emplace_back(Mips::XOR, Temp, LHS, RHS);
      Instructions.emplace_back(Mips::SLTiu, ICMPReg, Temp, 1);
      break;
    case CmpInst::ICMP_NE: // LHS != RHS -> 0 < (LHS ^ RHS)
      Instructions.emplace_back(Mips::XOR, Temp, LHS, RHS);
      Instructions.emplace_back(Mips::SLTu, ICMPReg, Mips::ZERO, Temp);
      break;
    case CmpInst::ICMP_UGT: // LHS >  RHS -> RHS < LHS
      Instructions.emplace_back(Mips::SLTu, ICMPReg, RHS, LHS);
      break;
    case CmpInst::ICMP_UGE: // LHS >= RHS -> !(LHS < RHS)
      Instructions.emplace_back(Mips::SLTu, Temp, LHS, RHS);
      Instructions.emplace_back(Mips::XORi, ICMPReg, Temp, 1);
      break;
    case CmpInst::ICMP_ULT: // LHS <  RHS -> LHS < RHS
      Instructions.emplace_back(Mips::SLTu, ICMPReg, LHS, RHS);
      break;
    case CmpInst::ICMP_ULE: // LHS <= RHS -> !(RHS < LHS)
      Instructions.emplace_back(Mips::SLTu, Temp, RHS, LHS);
      Instructions.emplace_back(Mips::XORi, ICMPReg, Temp, 1);
      break;
    case CmpInst::ICMP_SGT: // LHS >  RHS -> RHS < LHS
      Instructions.emplace_back(Mips::SLT, ICMPReg, RHS, LHS);
      break;
    case CmpInst::ICMP_SGE: // LHS >= RHS -> !(LHS < RHS)
      Instructions.emplace_back(Mips::SLT, Temp, LHS, RHS);
      Instructions.emplace_back(Mips::XORi, ICMPReg, Temp, 1);
      break;
    case CmpInst::ICMP_SLT: // LHS <  RHS -> LHS < RHS
      Instructions.emplace_back(Mips::SLT, ICMPReg, LHS, RHS);
      break;
    case CmpInst::ICMP_SLE: // LHS <= RHS -> !(RHS < LHS)
      Instructions.emplace_back(Mips::SLT, Temp, RHS, LHS);
      Instructions.emplace_back(Mips::XORi, ICMPReg, Temp, 1);
      break;
    default:
      return false;
    }

    MachineIRBuilder B(I);
    for (const struct Instr &Instruction : Instructions) {
      MachineInstrBuilder MIB = B.buildInstr(
          Instruction.Opcode, {Instruction.Def}, {Instruction.LHS});

      if (Instruction.hasImm())
        MIB.addImm(Instruction.RHS);
      else
        MIB.addUse(Instruction.RHS);

      if (!MIB.constrainAllUses(TII, TRI, RBI))
        return false;
    }

    I.eraseFromParent();
    return true;
  }
  case G_FCMP: {
    unsigned MipsFCMPCondCode;
    bool isLogicallyNegated;
    switch (CmpInst::Predicate Cond = static_cast<CmpInst::Predicate>(
                I.getOperand(1).getPredicate())) {
    case CmpInst::FCMP_UNO: // Unordered
    case CmpInst::FCMP_ORD: // Ordered (OR)
      MipsFCMPCondCode = Mips::FCOND_UN;
      isLogicallyNegated = Cond != CmpInst::FCMP_UNO;
      break;
    case CmpInst::FCMP_OEQ: // Equal
    case CmpInst::FCMP_UNE: // Not Equal (NEQ)
      MipsFCMPCondCode = Mips::FCOND_OEQ;
      isLogicallyNegated = Cond != CmpInst::FCMP_OEQ;
      break;
    case CmpInst::FCMP_UEQ: // Unordered or Equal
    case CmpInst::FCMP_ONE: // Ordered or Greater Than or Less Than (OGL)
      MipsFCMPCondCode = Mips::FCOND_UEQ;
      isLogicallyNegated = Cond != CmpInst::FCMP_UEQ;
      break;
    case CmpInst::FCMP_OLT: // Ordered or Less Than
    case CmpInst::FCMP_UGE: // Unordered or Greater Than or Equal (UGE)
      MipsFCMPCondCode = Mips::FCOND_OLT;
      isLogicallyNegated = Cond != CmpInst::FCMP_OLT;
      break;
    case CmpInst::FCMP_ULT: // Unordered or Less Than
    case CmpInst::FCMP_OGE: // Ordered or Greater Than or Equal (OGE)
      MipsFCMPCondCode = Mips::FCOND_ULT;
      isLogicallyNegated = Cond != CmpInst::FCMP_ULT;
      break;
    case CmpInst::FCMP_OLE: // Ordered or Less Than or Equal
    case CmpInst::FCMP_UGT: // Unordered or Greater Than (UGT)
      MipsFCMPCondCode = Mips::FCOND_OLE;
      isLogicallyNegated = Cond != CmpInst::FCMP_OLE;
      break;
    case CmpInst::FCMP_ULE: // Unordered or Less Than or Equal
    case CmpInst::FCMP_OGT: // Ordered or Greater Than (OGT)
      MipsFCMPCondCode = Mips::FCOND_ULE;
      isLogicallyNegated = Cond != CmpInst::FCMP_ULE;
      break;
    default:
      return false;
    }

    // Default compare result in gpr register will be `true`.
    // We will move `false` (MIPS::Zero) to gpr result when fcmp gives false
    // using MOVF_I. When orignal predicate (Cond) is logically negated
    // MipsFCMPCondCode, result is inverted i.e. MOVT_I is used.
    unsigned MoveOpcode = isLogicallyNegated ? Mips::MOVT_I : Mips::MOVF_I;

    Register TrueInReg = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::ADDiu))
        .addDef(TrueInReg)
        .addUse(Mips::ZERO)
        .addImm(1);

    unsigned Size = MRI.getType(I.getOperand(2).getReg()).getSizeInBits();
    unsigned FCMPOpcode =
        Size == 32 ? Mips::FCMP_S32
                   : STI.isFP64bit() ? Mips::FCMP_D64 : Mips::FCMP_D32;
    MachineInstr *FCMP = BuildMI(MBB, I, I.getDebugLoc(), TII.get(FCMPOpcode))
                             .addUse(I.getOperand(2).getReg())
                             .addUse(I.getOperand(3).getReg())
                             .addImm(MipsFCMPCondCode);
    if (!constrainSelectedInstRegOperands(*FCMP, TII, TRI, RBI))
      return false;

    MachineInstr *Move = BuildMI(MBB, I, I.getDebugLoc(), TII.get(MoveOpcode))
                             .addDef(I.getOperand(0).getReg())
                             .addUse(Mips::ZERO)
                             .addUse(Mips::FCC0)
                             .addUse(TrueInReg);
    if (!constrainSelectedInstRegOperands(*Move, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  case G_FENCE: {
    MI = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::SYNC)).addImm(0);
    break;
  }
  case G_VASTART: {
    MipsFunctionInfo *FuncInfo = MF.getInfo<MipsFunctionInfo>();
    int FI = FuncInfo->getVarArgsFrameIndex();

    Register LeaReg = MRI.createVirtualRegister(&Mips::GPR32RegClass);
    MachineInstr *LEA_ADDiu =
        BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::LEA_ADDiu))
            .addDef(LeaReg)
            .addFrameIndex(FI)
            .addImm(0);
    if (!constrainSelectedInstRegOperands(*LEA_ADDiu, TII, TRI, RBI))
      return false;

    MachineInstr *Store = BuildMI(MBB, I, I.getDebugLoc(), TII.get(Mips::SW))
                              .addUse(LeaReg)
                              .addUse(I.getOperand(0).getReg())
                              .addImm(0);
    if (!constrainSelectedInstRegOperands(*Store, TII, TRI, RBI))
      return false;

    I.eraseFromParent();
    return true;
  }
  default:
    return false;
  }

  I.eraseFromParent();
  return constrainSelectedInstRegOperands(*MI, TII, TRI, RBI);
}

namespace llvm {
InstructionSelector *createMipsInstructionSelector(const MipsTargetMachine &TM,
                                                   MipsSubtarget &Subtarget,
                                                   MipsRegisterBankInfo &RBI) {
  return new MipsInstructionSelector(TM, Subtarget, RBI);
}
} // end namespace llvm
