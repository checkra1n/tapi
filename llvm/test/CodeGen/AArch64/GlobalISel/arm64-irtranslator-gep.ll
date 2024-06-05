; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -stop-after=irtranslator -global-isel -verify-machineinstrs %s -o - 2>&1 | FileCheck %s --check-prefix=O0
; RUN: llc -O3 -stop-after=irtranslator -global-isel -verify-machineinstrs %s -o - 2>&1 | FileCheck %s --check-prefix=O3
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--"

define i32 @cse_gep([4 x i32]* %ptr, i32 %idx) {
  ; O0-LABEL: name: cse_gep
  ; O0: bb.1 (%ir-block.0):
  ; O0-NEXT:   liveins: $w1, $x0
  ; O0-NEXT: {{  $}}
  ; O0-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; O0-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; O0-NEXT:   [[SEXT:%[0-9]+]]:_(s64) = G_SEXT [[COPY1]](s32)
  ; O0-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 16
  ; O0-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[SEXT]], [[C]]
  ; O0-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL]](s64)
  ; O0-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY [[PTR_ADD]](p0)
  ; O0-NEXT:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY2]](p0) :: (load (s32) from %ir.gep1)
  ; O0-NEXT:   [[MUL1:%[0-9]+]]:_(s64) = G_MUL [[SEXT]], [[C]]
  ; O0-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL1]](s64)
  ; O0-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; O0-NEXT:   [[PTR_ADD2:%[0-9]+]]:_(p0) = G_PTR_ADD [[PTR_ADD1]], [[C1]](s64)
  ; O0-NEXT:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[PTR_ADD2]](p0) :: (load (s32) from %ir.gep2)
  ; O0-NEXT:   [[ADD:%[0-9]+]]:_(s32) = G_ADD [[LOAD]], [[LOAD1]]
  ; O0-NEXT:   $w0 = COPY [[ADD]](s32)
  ; O0-NEXT:   RET_ReallyLR implicit $w0
  ; O3-LABEL: name: cse_gep
  ; O3: bb.1 (%ir-block.0):
  ; O3-NEXT:   liveins: $w1, $x0
  ; O3-NEXT: {{  $}}
  ; O3-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; O3-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; O3-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; O3-NEXT:   [[SEXT:%[0-9]+]]:_(s64) = G_SEXT [[COPY1]](s32)
  ; O3-NEXT:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 16
  ; O3-NEXT:   [[MUL:%[0-9]+]]:_(s64) = G_MUL [[SEXT]], [[C1]]
  ; O3-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[MUL]](s64)
  ; O3-NEXT:   [[COPY2:%[0-9]+]]:_(p0) = COPY [[PTR_ADD]](p0)
  ; O3-NEXT:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY2]](p0) :: (load (s32) from %ir.gep1)
  ; O3-NEXT:   [[SHL:%[0-9]+]]:_(s64) = G_SHL [[SEXT]], [[C]](s64)
  ; O3-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY]], [[SHL]](s64)
  ; O3-NEXT:   [[COPY3:%[0-9]+]]:_(p0) = COPY [[PTR_ADD1]](p0)
  ; O3-NEXT:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; O3-NEXT:   [[PTR_ADD2:%[0-9]+]]:_(p0) = G_PTR_ADD [[COPY3]], [[C2]](s64)
  ; O3-NEXT:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[PTR_ADD2]](p0) :: (load (s32) from %ir.3)
  ; O3-NEXT:   [[ADD:%[0-9]+]]:_(s32) = G_ADD [[LOAD]], [[LOAD1]]
  ; O3-NEXT:   $w0 = COPY [[ADD]](s32)
  ; O3-NEXT:   RET_ReallyLR implicit $w0
  %sidx = sext i32 %idx to i64
  %gep1 = getelementptr inbounds [4 x i32], [4 x i32]* %ptr, i64 %sidx, i64 0
  %v1 = load i32, i32* %gep1
  %gep2 = getelementptr inbounds [4 x i32], [4 x i32]* %ptr, i64 %sidx, i64 1
  %v2 = load i32, i32* %gep2
  %res = add i32 %v1, %v2
  ret i32 %res
}
