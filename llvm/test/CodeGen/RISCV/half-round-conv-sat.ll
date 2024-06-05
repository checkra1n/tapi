; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zfh -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32f | FileCheck -check-prefixes=CHECKIZFH,RV32IZFH %s
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64f | FileCheck -check-prefixes=CHECKIZFH,RV64IZFH %s

define signext i32 @test_floor_si32(half %x) {
; CHECKIZFH-LABEL: test_floor_si32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.w.h a0, fa0, rdn
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.floor.f16(half %x)
  %b = call i32 @llvm.fptosi.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_floor_si64(half %x) nounwind {
; RV32IZFH-LABEL: test_floor_si64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call floorf@plt
; RV32IZFH-NEXT:    lui a0, %hi(.LCPI1_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI1_0)(a0)
; RV32IZFH-NEXT:    fcvt.h.s ft1, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft1
; RV32IZFH-NEXT:    fle.s s0, ft0, fs0
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixsfdi@plt
; RV32IZFH-NEXT:    lui a3, 524288
; RV32IZFH-NEXT:    bnez s0, .LBB1_2
; RV32IZFH-NEXT:  # %bb.1:
; RV32IZFH-NEXT:    lui a1, 524288
; RV32IZFH-NEXT:  .LBB1_2:
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI1_1)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI1_1)(a2)
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    beqz a2, .LBB1_4
; RV32IZFH-NEXT:  # %bb.3:
; RV32IZFH-NEXT:    addi a1, a3, -1
; RV32IZFH-NEXT:  .LBB1_4:
; RV32IZFH-NEXT:    feq.s a3, fs0, fs0
; RV32IZFH-NEXT:    seqz a3, a3
; RV32IZFH-NEXT:    addi a3, a3, -1
; RV32IZFH-NEXT:    and a1, a3, a1
; RV32IZFH-NEXT:    seqz a4, s0
; RV32IZFH-NEXT:    addi a4, a4, -1
; RV32IZFH-NEXT:    and a0, a4, a0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a0, a3, a0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_floor_si64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rdn
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.floor.f16(half %x)
  %b = call i64 @llvm.fptosi.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_floor_ui32(half %x) {
; CHECKIZFH-LABEL: test_floor_ui32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.wu.h a0, fa0, rdn
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.floor.f16(half %x)
  %b = call i32 @llvm.fptoui.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_floor_ui64(half %x) nounwind {
; RV32IZFH-LABEL: test_floor_ui64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call floorf@plt
; RV32IZFH-NEXT:    fcvt.h.s ft0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft0
; RV32IZFH-NEXT:    fmv.w.x ft0, zero
; RV32IZFH-NEXT:    fle.s a0, ft0, fs0
; RV32IZFH-NEXT:    seqz a0, a0
; RV32IZFH-NEXT:    addi s0, a0, -1
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixunssfdi@plt
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI3_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI3_0)(a2)
; RV32IZFH-NEXT:    and a0, s0, a0
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a1, s0, a1
; RV32IZFH-NEXT:    or a1, a2, a1
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_floor_ui64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rdn
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.floor.f16(half %x)
  %b = call i64 @llvm.fptoui.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_ceil_si32(half %x) {
; CHECKIZFH-LABEL: test_ceil_si32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.w.h a0, fa0, rup
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.ceil.f16(half %x)
  %b = call i32 @llvm.fptosi.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_ceil_si64(half %x) nounwind {
; RV32IZFH-LABEL: test_ceil_si64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call ceilf@plt
; RV32IZFH-NEXT:    lui a0, %hi(.LCPI5_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI5_0)(a0)
; RV32IZFH-NEXT:    fcvt.h.s ft1, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft1
; RV32IZFH-NEXT:    fle.s s0, ft0, fs0
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixsfdi@plt
; RV32IZFH-NEXT:    lui a3, 524288
; RV32IZFH-NEXT:    bnez s0, .LBB5_2
; RV32IZFH-NEXT:  # %bb.1:
; RV32IZFH-NEXT:    lui a1, 524288
; RV32IZFH-NEXT:  .LBB5_2:
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI5_1)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI5_1)(a2)
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    beqz a2, .LBB5_4
; RV32IZFH-NEXT:  # %bb.3:
; RV32IZFH-NEXT:    addi a1, a3, -1
; RV32IZFH-NEXT:  .LBB5_4:
; RV32IZFH-NEXT:    feq.s a3, fs0, fs0
; RV32IZFH-NEXT:    seqz a3, a3
; RV32IZFH-NEXT:    addi a3, a3, -1
; RV32IZFH-NEXT:    and a1, a3, a1
; RV32IZFH-NEXT:    seqz a4, s0
; RV32IZFH-NEXT:    addi a4, a4, -1
; RV32IZFH-NEXT:    and a0, a4, a0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a0, a3, a0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_ceil_si64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rup
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.ceil.f16(half %x)
  %b = call i64 @llvm.fptosi.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_ceil_ui32(half %x) {
; CHECKIZFH-LABEL: test_ceil_ui32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.wu.h a0, fa0, rup
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.ceil.f16(half %x)
  %b = call i32 @llvm.fptoui.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_ceil_ui64(half %x) nounwind {
; RV32IZFH-LABEL: test_ceil_ui64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call ceilf@plt
; RV32IZFH-NEXT:    fcvt.h.s ft0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft0
; RV32IZFH-NEXT:    fmv.w.x ft0, zero
; RV32IZFH-NEXT:    fle.s a0, ft0, fs0
; RV32IZFH-NEXT:    seqz a0, a0
; RV32IZFH-NEXT:    addi s0, a0, -1
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixunssfdi@plt
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI7_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI7_0)(a2)
; RV32IZFH-NEXT:    and a0, s0, a0
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a1, s0, a1
; RV32IZFH-NEXT:    or a1, a2, a1
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_ceil_ui64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rup
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.ceil.f16(half %x)
  %b = call i64 @llvm.fptoui.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_trunc_si32(half %x) {
; CHECKIZFH-LABEL: test_trunc_si32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.trunc.f16(half %x)
  %b = call i32 @llvm.fptosi.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_trunc_si64(half %x) nounwind {
; RV32IZFH-LABEL: test_trunc_si64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call truncf@plt
; RV32IZFH-NEXT:    lui a0, %hi(.LCPI9_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI9_0)(a0)
; RV32IZFH-NEXT:    fcvt.h.s ft1, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft1
; RV32IZFH-NEXT:    fle.s s0, ft0, fs0
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixsfdi@plt
; RV32IZFH-NEXT:    lui a3, 524288
; RV32IZFH-NEXT:    bnez s0, .LBB9_2
; RV32IZFH-NEXT:  # %bb.1:
; RV32IZFH-NEXT:    lui a1, 524288
; RV32IZFH-NEXT:  .LBB9_2:
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI9_1)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI9_1)(a2)
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    beqz a2, .LBB9_4
; RV32IZFH-NEXT:  # %bb.3:
; RV32IZFH-NEXT:    addi a1, a3, -1
; RV32IZFH-NEXT:  .LBB9_4:
; RV32IZFH-NEXT:    feq.s a3, fs0, fs0
; RV32IZFH-NEXT:    seqz a3, a3
; RV32IZFH-NEXT:    addi a3, a3, -1
; RV32IZFH-NEXT:    and a1, a3, a1
; RV32IZFH-NEXT:    seqz a4, s0
; RV32IZFH-NEXT:    addi a4, a4, -1
; RV32IZFH-NEXT:    and a0, a4, a0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a0, a3, a0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_trunc_si64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.trunc.f16(half %x)
  %b = call i64 @llvm.fptosi.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_trunc_ui32(half %x) {
; CHECKIZFH-LABEL: test_trunc_ui32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.trunc.f16(half %x)
  %b = call i32 @llvm.fptoui.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_trunc_ui64(half %x) nounwind {
; RV32IZFH-LABEL: test_trunc_ui64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call truncf@plt
; RV32IZFH-NEXT:    fcvt.h.s ft0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft0
; RV32IZFH-NEXT:    fmv.w.x ft0, zero
; RV32IZFH-NEXT:    fle.s a0, ft0, fs0
; RV32IZFH-NEXT:    seqz a0, a0
; RV32IZFH-NEXT:    addi s0, a0, -1
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixunssfdi@plt
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI11_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI11_0)(a2)
; RV32IZFH-NEXT:    and a0, s0, a0
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a1, s0, a1
; RV32IZFH-NEXT:    or a1, a2, a1
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_trunc_ui64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.trunc.f16(half %x)
  %b = call i64 @llvm.fptoui.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_round_si32(half %x) {
; CHECKIZFH-LABEL: test_round_si32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.w.h a0, fa0, rmm
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.round.f16(half %x)
  %b = call i32 @llvm.fptosi.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_round_si64(half %x) nounwind {
; RV32IZFH-LABEL: test_round_si64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundf@plt
; RV32IZFH-NEXT:    lui a0, %hi(.LCPI13_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI13_0)(a0)
; RV32IZFH-NEXT:    fcvt.h.s ft1, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft1
; RV32IZFH-NEXT:    fle.s s0, ft0, fs0
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixsfdi@plt
; RV32IZFH-NEXT:    lui a3, 524288
; RV32IZFH-NEXT:    bnez s0, .LBB13_2
; RV32IZFH-NEXT:  # %bb.1:
; RV32IZFH-NEXT:    lui a1, 524288
; RV32IZFH-NEXT:  .LBB13_2:
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI13_1)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI13_1)(a2)
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    beqz a2, .LBB13_4
; RV32IZFH-NEXT:  # %bb.3:
; RV32IZFH-NEXT:    addi a1, a3, -1
; RV32IZFH-NEXT:  .LBB13_4:
; RV32IZFH-NEXT:    feq.s a3, fs0, fs0
; RV32IZFH-NEXT:    seqz a3, a3
; RV32IZFH-NEXT:    addi a3, a3, -1
; RV32IZFH-NEXT:    and a1, a3, a1
; RV32IZFH-NEXT:    seqz a4, s0
; RV32IZFH-NEXT:    addi a4, a4, -1
; RV32IZFH-NEXT:    and a0, a4, a0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a0, a3, a0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_round_si64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rmm
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.round.f16(half %x)
  %b = call i64 @llvm.fptosi.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_round_ui32(half %x) {
; CHECKIZFH-LABEL: test_round_ui32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.wu.h a0, fa0, rmm
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.round.f16(half %x)
  %b = call i32 @llvm.fptoui.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_round_ui64(half %x) nounwind {
; RV32IZFH-LABEL: test_round_ui64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundf@plt
; RV32IZFH-NEXT:    fcvt.h.s ft0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft0
; RV32IZFH-NEXT:    fmv.w.x ft0, zero
; RV32IZFH-NEXT:    fle.s a0, ft0, fs0
; RV32IZFH-NEXT:    seqz a0, a0
; RV32IZFH-NEXT:    addi s0, a0, -1
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixunssfdi@plt
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI15_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI15_0)(a2)
; RV32IZFH-NEXT:    and a0, s0, a0
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a1, s0, a1
; RV32IZFH-NEXT:    or a1, a2, a1
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_round_ui64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rmm
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.round.f16(half %x)
  %b = call i64 @llvm.fptoui.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_roundeven_si32(half %x) {
; CHECKIZFH-LABEL: test_roundeven_si32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.w.h a0, fa0, rne
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.roundeven.f16(half %x)
  %b = call i32 @llvm.fptosi.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_roundeven_si64(half %x) nounwind {
; RV32IZFH-LABEL: test_roundeven_si64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundevenf@plt
; RV32IZFH-NEXT:    lui a0, %hi(.LCPI17_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI17_0)(a0)
; RV32IZFH-NEXT:    fcvt.h.s ft1, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft1
; RV32IZFH-NEXT:    fle.s s0, ft0, fs0
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixsfdi@plt
; RV32IZFH-NEXT:    lui a3, 524288
; RV32IZFH-NEXT:    bnez s0, .LBB17_2
; RV32IZFH-NEXT:  # %bb.1:
; RV32IZFH-NEXT:    lui a1, 524288
; RV32IZFH-NEXT:  .LBB17_2:
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI17_1)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI17_1)(a2)
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    beqz a2, .LBB17_4
; RV32IZFH-NEXT:  # %bb.3:
; RV32IZFH-NEXT:    addi a1, a3, -1
; RV32IZFH-NEXT:  .LBB17_4:
; RV32IZFH-NEXT:    feq.s a3, fs0, fs0
; RV32IZFH-NEXT:    seqz a3, a3
; RV32IZFH-NEXT:    addi a3, a3, -1
; RV32IZFH-NEXT:    and a1, a3, a1
; RV32IZFH-NEXT:    seqz a4, s0
; RV32IZFH-NEXT:    addi a4, a4, -1
; RV32IZFH-NEXT:    and a0, a4, a0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a0, a3, a0
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_roundeven_si64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rne
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.roundeven.f16(half %x)
  %b = call i64 @llvm.fptosi.sat.i64.f16(half %a)
  ret i64 %b
}

define signext i32 @test_roundeven_ui32(half %x) {
; CHECKIZFH-LABEL: test_roundeven_ui32:
; CHECKIZFH:       # %bb.0:
; CHECKIZFH-NEXT:    fcvt.wu.h a0, fa0, rne
; CHECKIZFH-NEXT:    feq.h a1, fa0, fa0
; CHECKIZFH-NEXT:    seqz a1, a1
; CHECKIZFH-NEXT:    addi a1, a1, -1
; CHECKIZFH-NEXT:    and a0, a1, a0
; CHECKIZFH-NEXT:    ret
  %a = call half @llvm.roundeven.f16(half %x)
  %b = call i32 @llvm.fptoui.sat.i32.f16(half %a)
  ret i32 %b
}

define i64 @test_roundeven_ui64(half %x) nounwind {
; RV32IZFH-LABEL: test_roundeven_ui64:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fsw fs0, 4(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call roundevenf@plt
; RV32IZFH-NEXT:    fcvt.h.s ft0, fa0
; RV32IZFH-NEXT:    fcvt.s.h fs0, ft0
; RV32IZFH-NEXT:    fmv.w.x ft0, zero
; RV32IZFH-NEXT:    fle.s a0, ft0, fs0
; RV32IZFH-NEXT:    seqz a0, a0
; RV32IZFH-NEXT:    addi s0, a0, -1
; RV32IZFH-NEXT:    fmv.s fa0, fs0
; RV32IZFH-NEXT:    call __fixunssfdi@plt
; RV32IZFH-NEXT:    lui a2, %hi(.LCPI19_0)
; RV32IZFH-NEXT:    flw ft0, %lo(.LCPI19_0)(a2)
; RV32IZFH-NEXT:    and a0, s0, a0
; RV32IZFH-NEXT:    flt.s a2, ft0, fs0
; RV32IZFH-NEXT:    seqz a2, a2
; RV32IZFH-NEXT:    addi a2, a2, -1
; RV32IZFH-NEXT:    or a0, a2, a0
; RV32IZFH-NEXT:    and a1, s0, a1
; RV32IZFH-NEXT:    or a1, a2, a1
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    flw fs0, 4(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: test_roundeven_ui64:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rne
; RV64IZFH-NEXT:    feq.h a1, fa0, fa0
; RV64IZFH-NEXT:    seqz a1, a1
; RV64IZFH-NEXT:    addi a1, a1, -1
; RV64IZFH-NEXT:    and a0, a1, a0
; RV64IZFH-NEXT:    ret
  %a = call half @llvm.roundeven.f16(half %x)
  %b = call i64 @llvm.fptoui.sat.i64.f16(half %a)
  ret i64 %b
}

declare half @llvm.floor.f16(half)
declare half @llvm.ceil.f16(half)
declare half @llvm.trunc.f16(half)
declare half @llvm.round.f16(half)
declare half @llvm.roundeven.f16(half)
declare i32 @llvm.fptosi.sat.i32.f16(half)
declare i64 @llvm.fptosi.sat.i64.f16(half)
declare i32 @llvm.fptoui.sat.i32.f16(half)
declare i64 @llvm.fptoui.sat.i64.f16(half)