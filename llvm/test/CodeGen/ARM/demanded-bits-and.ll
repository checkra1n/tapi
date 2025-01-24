; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi < %s | FileCheck %s

; Make sure this doesn't hang, and there are no unnecessary
; "and" instructions.

define dso_local void @f(ptr %p) {
; CHECK-LABEL: f:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:  .LBB0_1: @ %bb
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh r1, [r0]
; CHECK-NEXT:    and r2, r1, #255
; CHECK-NEXT:    add r3, r2, r1, lsr #8
; CHECK-NEXT:    add r2, r3, r2
; CHECK-NEXT:    add r1, r2, r1, lsr #8
; CHECK-NEXT:    add r1, r1, #2
; CHECK-NEXT:    lsr r1, r1, #2
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    b .LBB0_1
entry:
  br label %bb

bb:
  %_p_scalar_ = load i16, ptr %p, align 2
  %p_and = and i16 %_p_scalar_, 255
  %p_ = lshr i16 %_p_scalar_, 8
  %p_add = add nuw nsw i16 %p_, 2
  %p_add14 = add nuw nsw i16 %p_add, %p_and
  %p_add18 = add nuw nsw i16 %p_add14, %p_and
  %p_add19 = add nuw nsw i16 %p_add18, %p_
  %p_200 = lshr i16 %p_add19, 2
  store i16 %p_200, ptr %p, align 2
  br label %bb
}
