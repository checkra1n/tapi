; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; https://bugs.llvm.org/show_bug.cgi?id=38708

; Pattern:
;   (1 << bits) u<= val
; Should be transformed into:
;   (val l>> bits) != 0

; ============================================================================ ;
; Basic positive tests
; ============================================================================ ;

define i1 @p0(i8 %val, i8 %bits) {
; CHECK-LABEL: @p0(
; CHECK-NEXT:    [[VAL_HIGHBITS:%.*]] = lshr i8 [[VAL:%.*]], [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[VAL_HIGHBITS]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits
  %r = icmp ule i8 %t0, %val
  ret i1 %r
}

; ============================================================================ ;
; Vector tests
; ============================================================================ ;

define <2 x i1> @p1_vec(<2 x i8> %val, <2 x i8> %bits) {
; CHECK-LABEL: @p1_vec(
; CHECK-NEXT:    [[VAL_HIGHBITS:%.*]] = lshr <2 x i8> [[VAL:%.*]], [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne <2 x i8> [[VAL_HIGHBITS]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = shl <2 x i8> <i8 1, i8 1>, %bits
  %r = icmp ule <2 x i8> %t0, %val
  ret <2 x i1> %r
}

define <3 x i1> @p2_vec_undef(<3 x i8> %val, <3 x i8> %bits) {
; CHECK-LABEL: @p2_vec_undef(
; CHECK-NEXT:    [[VAL_HIGHBITS:%.*]] = lshr <3 x i8> [[VAL:%.*]], [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne <3 x i8> [[VAL_HIGHBITS]], zeroinitializer
; CHECK-NEXT:    ret <3 x i1> [[R]]
;
  %t0 = shl <3 x i8> <i8 1, i8 undef, i8 1>, %bits
  %r = icmp ule <3 x i8> %t0, %val
  ret <3 x i1> %r
}

; ============================================================================ ;
; Commutativity tests.
; ============================================================================ ;

declare i8 @gen8()

define i1 @c0(i8 %bits) {
; CHECK-LABEL: @c0(
; CHECK-NEXT:    [[VAL:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[VAL_HIGHBITS:%.*]] = lshr i8 [[VAL]], [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[VAL_HIGHBITS]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits
  %val = call i8 @gen8()
  %r = icmp uge i8 %val, %t0 ; swapped order and predicate
  ret i1 %r
}

; What if we have the same pattern on both sides?
define i1 @both(i8 %bits0, i8 %bits1) {
; CHECK-LABEL: @both(
; CHECK-NEXT:    [[T1:%.*]] = shl i8 1, [[BITS1:%.*]]
; CHECK-NEXT:    [[T1_HIGHBITS:%.*]] = lshr i8 [[T1]], [[BITS0:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[T1_HIGHBITS]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits0
  %t1 = shl i8 1, %bits1
  %r = icmp ule i8 %t0, %t1
  ret i1 %r
}

; ============================================================================ ;
; One-use tests.
; ============================================================================ ;

declare void @use8(i8)

define i1 @oneuse0(i8 %val, i8 %bits) {
; CHECK-LABEL: @oneuse0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 1, [[BITS:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[T0]])
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[T0]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits
  call void @use8(i8 %t0)
  %r = icmp ule i8 %t0, %val
  ret i1 %r
}

; ============================================================================ ;
; Negative tests
; ============================================================================ ;

define i1 @n0(i8 %val, i8 %bits) {
; CHECK-LABEL: @n0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 2, [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[T0]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 2, %bits ; constant is not 1
  %r = icmp ule i8 %t0, %val
  ret i1 %r
}

define <2 x i1> @n1_vec_nonsplat(<2 x i8> %val, <2 x i8> %bits) {
; CHECK-LABEL: @n1_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = shl <2 x i8> <i8 1, i8 2>, [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ule <2 x i8> [[T0]], [[VAL:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = shl <2 x i8> <i8 1, i8 2>, %bits ; again, wrong constant
  %r = icmp ule <2 x i8> %t0, %val
  ret <2 x i1> %r
}

define i1 @n2(i8 %val, i8 %bits) {
; CHECK-LABEL: @n2(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 1, [[BITS:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T0]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits
  %r = icmp ult i8 %t0, %val ; wrong predicate
  ret i1 %r
}

define i1 @n3(i8 %bits) {
; CHECK-LABEL: @n3(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 1, [[BITS:%.*]]
; CHECK-NEXT:    [[VAL:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[VAL]], [[T0]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits
  %val = call i8 @gen8()
  %r = icmp ugt i8 %val, %t0 ; swapped order and [wrong] predicate
  ret i1 %r
}
