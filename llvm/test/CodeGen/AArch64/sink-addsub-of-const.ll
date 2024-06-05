; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s

; Scalar tests.

; add (add %x, C), %y
; Outer 'add' is commutative - 2 variants.

define i32 @sink_add_of_const_to_add0(i32 %a, i32 %b) {
; CHECK-LABEL: sink_add_of_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = add i32 %a, 32 ; constant always on RHS
  %r = add i32 %t0, %b
  ret i32 %r
}
define i32 @sink_add_of_const_to_add1(i32 %a, i32 %b) {
; CHECK-LABEL: sink_add_of_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = add i32 %a, 32 ; constant always on RHS
  %r = add i32 %b, %t0
  ret i32 %r
}

; add (sub %x, C), %y
; Outer 'add' is commutative - 2 variants.

define i32 @sink_sub_of_const_to_add0(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_of_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    sub w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 %a, 32
  %r = add i32 %t0, %b
  ret i32 %r
}
define i32 @sink_sub_of_const_to_add1(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_of_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    sub w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 %a, 32
  %r = add i32 %b, %t0
  ret i32 %r
}

; add (sub C, %x), %y
; Outer 'add' is commutative - 2 variants.

define i32 @sink_sub_from_const_to_add0(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_from_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 32, %a
  %r = add i32 %t0, %b
  ret i32 %r
}
define i32 @sink_sub_from_const_to_add1(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_from_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 32, %a
  %r = add i32 %b, %t0
  ret i32 %r
}

; sub (add %x, C), %y
; sub %y, (add %x, C)

define i32 @sink_add_of_const_to_sub(i32 %a, i32 %b) {
; CHECK-LABEL: sink_add_of_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w0, w1
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = add i32 %a, 32 ; constant always on RHS
  %r = sub i32 %t0, %b
  ret i32 %r
}
define i32 @sink_add_of_const_to_sub2(i32 %a, i32 %b) {
; CHECK-LABEL: sink_add_of_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    sub w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = add i32 %a, 32 ; constant always on RHS
  %r = sub i32 %b, %t0
  ret i32 %r
}

; sub (sub %x, C), %y
; sub %y, (sub %x, C)

define i32 @sink_sub_of_const_to_sub(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_of_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w0, w1
; CHECK-NEXT:    sub w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 %a, 32
  %r = sub i32 %t0, %b
  ret i32 %r
}
define i32 @sink_sub_of_const_to_sub2(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_of_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w1, w0
; CHECK-NEXT:    add w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 %a, 32
  %r = sub i32 %b, %t0
  ret i32 %r
}

; sub (sub C, %x), %y
; sub %y, (sub C, %x)

define i32 @sink_sub_from_const_to_sub(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_from_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    mov w9, #32
; CHECK-NEXT:    sub w0, w9, w8
; CHECK-NEXT:    ret
  %t0 = sub i32 32, %a
  %r = sub i32 %t0, %b
  ret i32 %r
}
define i32 @sink_sub_from_const_to_sub2(i32 %a, i32 %b) {
; CHECK-LABEL: sink_sub_from_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    sub w0, w8, #32
; CHECK-NEXT:    ret
  %t0 = sub i32 32, %a
  %r = sub i32 %b, %t0
  ret i32 %r
}

;------------------------------------------------------------------------------;
; Basic vector tests. Here it is easier to see where the constant operand is.
;------------------------------------------------------------------------------;

; add (add %x, C), %y
; Outer 'add' is commutative - 2 variants.

define <4 x i32> @vec_sink_add_of_const_to_add0(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_add_of_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI12_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI12_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = add <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46> ; constant always on RHS
  %r = add <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_add_of_const_to_add1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_add_of_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI13_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI13_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = add <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46> ; constant always on RHS
  %r = add <4 x i32> %b, %t0
  ret <4 x i32> %r
}

; add (sub %x, C), %y
; Outer 'add' is commutative - 2 variants.

define <4 x i32> @vec_sink_sub_of_const_to_add0(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_of_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI14_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI14_0]
; CHECK-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46>
  %r = add <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_sub_of_const_to_add1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_of_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI15_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI15_0]
; CHECK-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46>
  %r = add <4 x i32> %b, %t0
  ret <4 x i32> %r
}

; add (sub C, %x), %y
; Outer 'add' is commutative - 2 variants.

define <4 x i32> @vec_sink_sub_from_const_to_add0(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_from_const_to_add0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI16_0
; CHECK-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI16_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> <i32 42, i32 24, i32 undef, i32 46>, %a
  %r = add <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_sub_from_const_to_add1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_from_const_to_add1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI17_0
; CHECK-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI17_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> <i32 42, i32 24, i32 undef, i32 46>, %a
  %r = add <4 x i32> %b, %t0
  ret <4 x i32> %r
}

; sub (add %x, C), %y
; sub %y, (add %x, C)

define <4 x i32> @vec_sink_add_of_const_to_sub(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_add_of_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI18_0
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI18_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = add <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46> ; constant always on RHS
  %r = sub <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_add_of_const_to_sub2(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_add_of_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI19_0
; CHECK-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI19_0]
; CHECK-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = add <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46> ; constant always on RHS
  %r = sub <4 x i32> %b, %t0
  ret <4 x i32> %r
}

; sub (sub %x, C), %y
; sub %y, (sub %x, C)

define <4 x i32> @vec_sink_sub_of_const_to_sub(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_of_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI20_0
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI20_0]
; CHECK-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46>
  %r = sub <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_sub_of_const_to_sub2(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_of_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI21_0
; CHECK-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI21_0]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %a, <i32 42, i32 24, i32 undef, i32 46>
  %r = sub <4 x i32> %b, %t0
  ret <4 x i32> %r
}

; sub (sub C, %x), %y
; sub %y, (sub C, %x)

define <4 x i32> @vec_sink_sub_from_const_to_sub(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_from_const_to_sub:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI22_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI22_0]
; CHECK-NEXT:    sub v0.4s, v2.4s, v0.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> <i32 42, i32 24, i32 undef, i32 46>, %a
  %r = sub <4 x i32> %t0, %b
  ret <4 x i32> %r
}
define <4 x i32> @vec_sink_sub_from_const_to_sub2(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vec_sink_sub_from_const_to_sub2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI23_0
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI23_0]
; CHECK-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> <i32 42, i32 24, i32 undef, i32 46>, %a
  %r = sub <4 x i32> %b, %t0
  ret <4 x i32> %r
}
