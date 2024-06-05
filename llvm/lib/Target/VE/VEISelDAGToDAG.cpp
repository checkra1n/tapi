//===-- VEISelDAGToDAG.cpp - A dag to dag inst selector for VE ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the VE target.
//
//===----------------------------------------------------------------------===//

#include "VE.h"
#include "VETargetMachine.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

//===----------------------------------------------------------------------===//
// Instruction Selector Implementation
//===----------------------------------------------------------------------===//

/// Convert a DAG integer condition code to a VE ICC condition.
inline static VECC::CondCode intCondCode2Icc(ISD::CondCode CC) {
  switch (CC) {
  default:
    llvm_unreachable("Unknown integer condition code!");
  case ISD::SETEQ:
    return VECC::CC_IEQ;
  case ISD::SETNE:
    return VECC::CC_INE;
  case ISD::SETLT:
    return VECC::CC_IL;
  case ISD::SETGT:
    return VECC::CC_IG;
  case ISD::SETLE:
    return VECC::CC_ILE;
  case ISD::SETGE:
    return VECC::CC_IGE;
  case ISD::SETULT:
    return VECC::CC_IL;
  case ISD::SETULE:
    return VECC::CC_ILE;
  case ISD::SETUGT:
    return VECC::CC_IG;
  case ISD::SETUGE:
    return VECC::CC_IGE;
  }
}

/// Convert a DAG floating point condition code to a VE FCC condition.
inline static VECC::CondCode fpCondCode2Fcc(ISD::CondCode CC) {
  switch (CC) {
  default:
    llvm_unreachable("Unknown fp condition code!");
  case ISD::SETFALSE:
    return VECC::CC_AF;
  case ISD::SETEQ:
  case ISD::SETOEQ:
    return VECC::CC_EQ;
  case ISD::SETNE:
  case ISD::SETONE:
    return VECC::CC_NE;
  case ISD::SETLT:
  case ISD::SETOLT:
    return VECC::CC_L;
  case ISD::SETGT:
  case ISD::SETOGT:
    return VECC::CC_G;
  case ISD::SETLE:
  case ISD::SETOLE:
    return VECC::CC_LE;
  case ISD::SETGE:
  case ISD::SETOGE:
    return VECC::CC_GE;
  case ISD::SETO:
    return VECC::CC_NUM;
  case ISD::SETUO:
    return VECC::CC_NAN;
  case ISD::SETUEQ:
    return VECC::CC_EQNAN;
  case ISD::SETUNE:
    return VECC::CC_NENAN;
  case ISD::SETULT:
    return VECC::CC_LNAN;
  case ISD::SETUGT:
    return VECC::CC_GNAN;
  case ISD::SETULE:
    return VECC::CC_LENAN;
  case ISD::SETUGE:
    return VECC::CC_GENAN;
  case ISD::SETTRUE:
    return VECC::CC_AT;
  }
}

/// getImmVal - get immediate representation of integer value
inline static uint64_t getImmVal(const ConstantSDNode *N) {
  return N->getSExtValue();
}

/// getFpImmVal - get immediate representation of floating point value
inline static uint64_t getFpImmVal(const ConstantFPSDNode *N) {
  const APInt &Imm = N->getValueAPF().bitcastToAPInt();
  uint64_t Val = Imm.getZExtValue();
  if (Imm.getBitWidth() == 32) {
    // Immediate value of float place places at higher bits on VE.
    Val <<= 32;
  }
  return Val;
}

//===--------------------------------------------------------------------===//
/// VEDAGToDAGISel - VE specific code to select VE machine
/// instructions for SelectionDAG operations.
///
namespace {
class VEDAGToDAGISel : public SelectionDAGISel {
  /// Subtarget - Keep a pointer to the VE Subtarget around so that we can
  /// make the right decision when generating code for different targets.
  const VESubtarget *Subtarget;

public:
  explicit VEDAGToDAGISel(VETargetMachine &tm) : SelectionDAGISel(tm) {}

  bool runOnMachineFunction(MachineFunction &MF) override {
    Subtarget = &MF.getSubtarget<VESubtarget>();
    return SelectionDAGISel::runOnMachineFunction(MF);
  }

  void Select(SDNode *N) override;

  // Complex Pattern Selectors.
  bool selectADDRrri(SDValue N, SDValue &Base, SDValue &Index, SDValue &Offset);
  bool selectADDRrii(SDValue N, SDValue &Base, SDValue &Index, SDValue &Offset);
  bool selectADDRzri(SDValue N, SDValue &Base, SDValue &Index, SDValue &Offset);
  bool selectADDRzii(SDValue N, SDValue &Base, SDValue &Index, SDValue &Offset);
  bool selectADDRri(SDValue N, SDValue &Base, SDValue &Offset);
  bool selectADDRzi(SDValue N, SDValue &Base, SDValue &Offset);

  /// SelectInlineAsmMemoryOperand - Implement addressing mode selection for
  /// inline asm expressions.
  bool SelectInlineAsmMemoryOperand(const SDValue &Op,
                                    unsigned ConstraintID,
                                    std::vector<SDValue> &OutOps) override;

  StringRef getPassName() const override {
    return "VE DAG->DAG Pattern Instruction Selection";
  }

  // Include the pieces autogenerated from the target description.
#include "VEGenDAGISel.inc"

private:
  SDNode *getGlobalBaseReg();

  bool matchADDRrr(SDValue N, SDValue &Base, SDValue &Index);
  bool matchADDRri(SDValue N, SDValue &Base, SDValue &Offset);
};
} // end anonymous namespace

bool VEDAGToDAGISel::selectADDRrri(SDValue Addr, SDValue &Base, SDValue &Index,
                                   SDValue &Offset) {
  if (Addr.getOpcode() == ISD::FrameIndex)
    return false;
  if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
      Addr.getOpcode() == ISD::TargetGlobalAddress ||
      Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
    return false; // direct calls.

  SDValue LHS, RHS;
  if (matchADDRri(Addr, LHS, RHS)) {
    if (matchADDRrr(LHS, Base, Index)) {
      Offset = RHS;
      return true;
    }
    // Return false to try selectADDRrii.
    return false;
  }
  if (matchADDRrr(Addr, LHS, RHS)) {
    // If the input is a pair of a frame-index and a register, move a
    // frame-index to LHS.  This generates MI with following operands.
    //    %dest, #FI, %reg, offset
    // In the eliminateFrameIndex, above MI is converted to the following.
    //    %dest, %fp, %reg, fi_offset + offset
    if (isa<FrameIndexSDNode>(RHS))
      std::swap(LHS, RHS);

    if (matchADDRri(RHS, Index, Offset)) {
      Base = LHS;
      return true;
    }
    if (matchADDRri(LHS, Base, Offset)) {
      Index = RHS;
      return true;
    }
    Base = LHS;
    Index = RHS;
    Offset = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
    return true;
  }
  return false; // Let the reg+imm(=0) pattern catch this!
}

bool VEDAGToDAGISel::selectADDRrii(SDValue Addr, SDValue &Base, SDValue &Index,
                                   SDValue &Offset) {
  if (matchADDRri(Addr, Base, Offset)) {
    Index = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
    return true;
  }

  Base = Addr;
  Index = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
  Offset = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
  return true;
}

bool VEDAGToDAGISel::selectADDRzri(SDValue Addr, SDValue &Base, SDValue &Index,
                                   SDValue &Offset) {
  // Prefer ADDRrii.
  return false;
}

bool VEDAGToDAGISel::selectADDRzii(SDValue Addr, SDValue &Base, SDValue &Index,
                                   SDValue &Offset) {
  if (isa<FrameIndexSDNode>(Addr))
    return false;
  if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
      Addr.getOpcode() == ISD::TargetGlobalAddress ||
      Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
    return false; // direct calls.

  if (auto *CN = dyn_cast<ConstantSDNode>(Addr)) {
    if (isInt<32>(CN->getSExtValue())) {
      Base = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
      Index = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
      Offset =
          CurDAG->getTargetConstant(CN->getZExtValue(), SDLoc(Addr), MVT::i32);
      return true;
    }
  }
  return false;
}

bool VEDAGToDAGISel::selectADDRri(SDValue Addr, SDValue &Base,
                                  SDValue &Offset) {
  if (matchADDRri(Addr, Base, Offset))
    return true;

  Base = Addr;
  Offset = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
  return true;
}

bool VEDAGToDAGISel::selectADDRzi(SDValue Addr, SDValue &Base,
                                  SDValue &Offset) {
  if (isa<FrameIndexSDNode>(Addr))
    return false;
  if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
      Addr.getOpcode() == ISD::TargetGlobalAddress ||
      Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
    return false; // direct calls.

  if (auto *CN = dyn_cast<ConstantSDNode>(Addr)) {
    if (isInt<32>(CN->getSExtValue())) {
      Base = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
      Offset =
          CurDAG->getTargetConstant(CN->getZExtValue(), SDLoc(Addr), MVT::i32);
      return true;
    }
  }
  return false;
}

bool VEDAGToDAGISel::matchADDRrr(SDValue Addr, SDValue &Base, SDValue &Index) {
  if (isa<FrameIndexSDNode>(Addr))
    return false;
  if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
      Addr.getOpcode() == ISD::TargetGlobalAddress ||
      Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
    return false; // direct calls.

  if (Addr.getOpcode() == ISD::ADD) {
    ; // Nothing to do here.
  } else if (Addr.getOpcode() == ISD::OR) {
    // We want to look through a transform in InstCombine and DAGCombiner that
    // turns 'add' into 'or', so we can treat this 'or' exactly like an 'add'.
    if (!CurDAG->haveNoCommonBitsSet(Addr.getOperand(0), Addr.getOperand(1)))
      return false;
  } else {
    return false;
  }

  if (Addr.getOperand(0).getOpcode() == VEISD::Lo ||
      Addr.getOperand(1).getOpcode() == VEISD::Lo)
    return false; // Let the LEASL patterns catch this!

  Base = Addr.getOperand(0);
  Index = Addr.getOperand(1);
  return true;
}

bool VEDAGToDAGISel::matchADDRri(SDValue Addr, SDValue &Base, SDValue &Offset) {
  auto AddrTy = Addr->getValueType(0);
  if (FrameIndexSDNode *FIN = dyn_cast<FrameIndexSDNode>(Addr)) {
    Base = CurDAG->getTargetFrameIndex(FIN->getIndex(), AddrTy);
    Offset = CurDAG->getTargetConstant(0, SDLoc(Addr), MVT::i32);
    return true;
  }
  if (Addr.getOpcode() == ISD::TargetExternalSymbol ||
      Addr.getOpcode() == ISD::TargetGlobalAddress ||
      Addr.getOpcode() == ISD::TargetGlobalTLSAddress)
    return false; // direct calls.

  if (CurDAG->isBaseWithConstantOffset(Addr)) {
    ConstantSDNode *CN = cast<ConstantSDNode>(Addr.getOperand(1));
    if (isInt<32>(CN->getSExtValue())) {
      if (FrameIndexSDNode *FIN =
              dyn_cast<FrameIndexSDNode>(Addr.getOperand(0))) {
        // Constant offset from frame ref.
        Base = CurDAG->getTargetFrameIndex(FIN->getIndex(), AddrTy);
      } else {
        Base = Addr.getOperand(0);
      }
      Offset =
          CurDAG->getTargetConstant(CN->getZExtValue(), SDLoc(Addr), MVT::i32);
      return true;
    }
  }
  return false;
}

void VEDAGToDAGISel::Select(SDNode *N) {
  SDLoc dl(N);
  if (N->isMachineOpcode()) {
    N->setNodeId(-1);
    return; // Already selected.
  }

  switch (N->getOpcode()) {

  // Late eliminate the LEGALAVL wrapper
  case VEISD::LEGALAVL:
    ReplaceNode(N, N->getOperand(0).getNode());
    return;

  // Lower (broadcast 1) and (broadcast 0) to VM[P]0
  case VEISD::VEC_BROADCAST: {
    MVT SplatResTy = N->getSimpleValueType(0);
    if (SplatResTy.getVectorElementType() != MVT::i1)
      break;

    // Constant non-zero broadcast.
    auto BConst = dyn_cast<ConstantSDNode>(N->getOperand(0));
    if (!BConst)
      break;
    bool BCTrueMask = (BConst->getSExtValue() != 0);
    if (!BCTrueMask)
      break;

    // Packed or non-packed.
    SDValue New;
    if (SplatResTy.getVectorNumElements() == StandardVectorWidth) {
      New = CurDAG->getCopyFromReg(CurDAG->getEntryNode(), SDLoc(N), VE::VM0,
                                   MVT::v256i1);
    } else if (SplatResTy.getVectorNumElements() == PackedVectorWidth) {
      New = CurDAG->getCopyFromReg(CurDAG->getEntryNode(), SDLoc(N), VE::VMP0,
                                   MVT::v512i1);
    } else
      break;

    // Replace.
    ReplaceNode(N, New.getNode());
    return;
  }

  case VEISD::GLOBAL_BASE_REG:
    ReplaceNode(N, getGlobalBaseReg());
    return;
  }

  SelectCode(N);
}

/// SelectInlineAsmMemoryOperand - Implement addressing mode selection for
/// inline asm expressions.
bool
VEDAGToDAGISel::SelectInlineAsmMemoryOperand(const SDValue &Op,
                                             unsigned ConstraintID,
                                             std::vector<SDValue> &OutOps) {
  SDValue Op0, Op1;
  switch (ConstraintID) {
  default:
    llvm_unreachable("Unexpected asm memory constraint");
  case InlineAsm::Constraint_o:
  case InlineAsm::Constraint_m: // memory
    // Try to match ADDRri since reg+imm style is safe for all VE instructions
    // with a memory operand.
    if (selectADDRri(Op, Op0, Op1)) {
      OutOps.push_back(Op0);
      OutOps.push_back(Op1);
      return false;
    }
    // Otherwise, require the address to be in a register and immediate 0.
    OutOps.push_back(Op);
    OutOps.push_back(CurDAG->getTargetConstant(0, SDLoc(Op), MVT::i32));
    return false;
  }
  return true;
}

SDNode *VEDAGToDAGISel::getGlobalBaseReg() {
  Register GlobalBaseReg = Subtarget->getInstrInfo()->getGlobalBaseReg(MF);
  return CurDAG
      ->getRegister(GlobalBaseReg, TLI->getPointerTy(CurDAG->getDataLayout()))
      .getNode();
}

/// createVEISelDag - This pass converts a legalized DAG into a
/// VE-specific DAG, ready for instruction scheduling.
///
FunctionPass *llvm::createVEISelDag(VETargetMachine &TM) {
  return new VEDAGToDAGISel(TM);
}