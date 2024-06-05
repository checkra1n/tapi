; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-openbsd < %s | FileCheck %s

@.str = private constant [32 x i8] c"i = %g, j = %g, k = %g, l = %g\0A\00", align 1

define void @callee(float  %a, float  %b, float  %c, float  %d, float  %e, float  %f, float  %g, float  %h, float  %i, float  %j, float  %k, float  %l)  nounwind {
; CHECK-LABEL: callee:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    stw 0, 4(1)
; CHECK-NEXT:    stwu 1, -16(1)
; CHECK-NEXT:    lfs 1, 24(1)
; CHECK-NEXT:    lis 3, .L.str@ha
; CHECK-NEXT:    lfs 2, 28(1)
; CHECK-NEXT:    la 3, .L.str@l(3)
; CHECK-NEXT:    lfs 3, 32(1)
; CHECK-NEXT:    creqv 6, 6, 6
; CHECK-NEXT:    lfs 4, 36(1)
; CHECK-NEXT:    bl printf
; CHECK-NEXT:    lwz 0, 20(1)
; CHECK-NEXT:    addi 1, 1, 16
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
entry:
  %conv = fpext float %i to double
  %conv1 = fpext float %j to double
  %conv2 = fpext float %k to double
  %conv3 = fpext float %l to double
  %call = tail call signext i32 (ptr, ...) @printf(ptr  nonnull dereferenceable(1) @.str, double  %conv, double  %conv1, double  %conv2, double  %conv3)
  ret void
}

declare  signext i32 @printf(ptr nocapture  readonly, ...)

