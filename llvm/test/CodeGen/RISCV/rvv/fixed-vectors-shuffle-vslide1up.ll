; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+f,+d,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+f,+d,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define <2 x i8> @vslide1up_2xi8(<2 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_2xi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vslide1up.vx v9, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <2 x i8> poison, i8 %b, i64 0
  %v1 = shufflevector <2 x i8> %v, <2 x i8> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x i8> %v1
}

define <4 x i8> @vslide1up_4xi8(<4 x i8> %v, i8 %b) {
; RV32-LABEL: vslide1up_4xi8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v9, a0
; RV32-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_4xi8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; RV64-NEXT:    vslide1up.vx v9, v8, a0
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <4 x i8> poison, i8 %b, i64 0
  %v1 = shufflevector <4 x i8> %v, <4 x i8> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x i8> %v1
}

define <4 x i8> @vslide1up_4xi8_swapped(<4 x i8> %v, i8 %b) {
; RV32-LABEL: vslide1up_4xi8_swapped:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v9, a0
; RV32-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_4xi8_swapped:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; RV64-NEXT:    vslide1up.vx v9, v8, a0
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <4 x i8> poison, i8 %b, i64 0
  %v1 = shufflevector <4 x i8> %vb, <4 x i8> %v, <4 x i32> <i32 0, i32 4, i32 5, i32 6>
  ret <4 x i8> %v1
}

define <2 x i16> @vslide1up_2xi16(<2 x i16> %v, i16 %b) {
; RV32-LABEL: vslide1up_2xi16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v9, a0
; RV32-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_2xi16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV64-NEXT:    vslide1up.vx v9, v8, a0
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <2 x i16> poison, i16 %b, i64 0
  %v1 = shufflevector <2 x i16> %v, <2 x i16> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x i16> %v1
}

define <4 x i16> @vslide1up_4xi16(<4 x i16> %v, i16 %b) {
; RV32-LABEL: vslide1up_4xi16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV32-NEXT:    vslide1up.vx v9, v8, a0
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_4xi16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vmv.s.x v9, a0
; RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV64-NEXT:    vslideup.vi v9, v8, 1
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <4 x i16> poison, i16 %b, i64 0
  %v1 = shufflevector <4 x i16> %v, <4 x i16> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x i16> %v1
}

define <2 x i32> @vslide1up_2xi32(<2 x i32> %v, i32 %b) {
; RV32-LABEL: vslide1up_2xi32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vslide1up.vx v9, v8, a0
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_2xi32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vmv.s.x v9, a0
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vslideup.vi v9, v8, 1
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <2 x i32> poison, i32 %b, i64 0
  %v1 = shufflevector <2 x i32> %v, <2 x i32> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x i32> %v1
}

define <4 x i32> @vslide1up_4xi32(<4 x i32> %v, i32 %b) {
; CHECK-LABEL: vslide1up_4xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vslide1up.vx v9, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <4 x i32> poison, i32 %b, i64 0
  %v1 = shufflevector <4 x i32> %v, <4 x i32> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x i32> %v1
}

define <2 x i64> @vslide1up_2xi64(<2 x i64> %v, i64 %b) {
; RV32-LABEL: vslide1up_2xi64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v9, (a0), zero
; RV32-NEXT:    vslideup.vi v9, v8, 1
; RV32-NEXT:    vmv.v.v v8, v9
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_2xi64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vslide1up.vx v9, v8, a0
; RV64-NEXT:    vmv.v.v v8, v9
; RV64-NEXT:    ret
  %vb = insertelement <2 x i64> poison, i64 %b, i64 0
  %v1 = shufflevector <2 x i64> %v, <2 x i64> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x i64> %v1
}

define <4 x i64> @vslide1up_4xi64(<4 x i64> %v, i64 %b) {
; RV32-LABEL: vslide1up_4xi64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v10, (a0), zero
; RV32-NEXT:    vslideup.vi v10, v8, 1
; RV32-NEXT:    vmv.v.v v8, v10
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vslide1up_4xi64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vslide1up.vx v10, v8, a0
; RV64-NEXT:    vmv.v.v v8, v10
; RV64-NEXT:    ret
  %vb = insertelement <4 x i64> poison, i64 %b, i64 0
  %v1 = shufflevector <4 x i64> %v, <4 x i64> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x i64> %v1
}

define <2 x half> @vslide1up_2xf16(<2 x half> %v, half %b) {
; CHECK-LABEL: vslide1up_2xf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <2 x half> poison, half %b, i64 0
  %v1 = shufflevector <2 x half> %v, <2 x half> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x half> %v1
}

define <4 x half> @vslide1up_4xf16(<4 x half> %v, half %b) {
; CHECK-LABEL: vslide1up_4xf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <4 x half> poison, half %b, i64 0
  %v1 = shufflevector <4 x half> %v, <4 x half> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x half> %v1
}

define <2 x float> @vslide1up_2xf32(<2 x float> %v, float %b) {
; CHECK-LABEL: vslide1up_2xf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <2 x float> poison, float %b, i64 0
  %v1 = shufflevector <2 x float> %v, <2 x float> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x float> %v1
}

define <4 x float> @vslide1up_4xf32(<4 x float> %v, float %b) {
; CHECK-LABEL: vslide1up_4xf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <4 x float> poison, float %b, i64 0
  %v1 = shufflevector <4 x float> %v, <4 x float> %vb, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x float> %v1
}

define <2 x double> @vslide1up_2xf64(<2 x double> %v, double %b) {
; CHECK-LABEL: vslide1up_2xf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <2 x double> poison, double %b, i64 0
  %v1 = shufflevector <2 x double> %v, <2 x double> %vb, <2 x i32> <i32 2, i32 0>
  ret <2 x double> %v1
}

define <4 x double> @vslide1up_4xf64(<4 x double> %v, double %b) {
; CHECK-LABEL: vslide1up_4xf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfmv.v.f v10, fa0
; CHECK-NEXT:    vslideup.vi v10, v8, 3
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %vb = insertelement <4 x double> poison, double %b, i64 0
  %v1 = shufflevector <4 x double> %v, <4 x double> %vb, <4 x i32> <i32 4, i32 5, i32 6, i32 0>
  ret <4 x double> %v1
}

define <4 x i8> @vslide1up_4xi8_with_splat(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_with_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslide1up.vx v9, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <4 x i8> poison, i8 %b, i64 0
  %v1 = shufflevector <4 x i8> %vb, <4 x i8> poison, <4 x i32> zeroinitializer
  %v2 = shufflevector <4 x i8> %v1, <4 x i8> %v, <4 x i32> <i32 1, i32 4, i32 5, i32 6>
  ret <4 x i8> %v2
}

define <2 x double> @vslide1up_v2f64_inverted(<2 x double> %v, double %b) {
; CHECK-LABEL: vslide1up_v2f64_inverted:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v1 = shufflevector <2 x double> %v, <2 x double> poison, <2 x i32> <i32 0, i32 0>
  %v2 = insertelement <2 x double> %v1, double %b, i64 0
  ret <2 x double> %v2
}

define <4 x i8> @vslide1up_4xi8_inverted(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_inverted:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, tu, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v1 = shufflevector <4 x i8> %v, <4 x i8> poison, <4 x i32> <i32 undef, i32 0, i32 1, i32 2>
  %v2 = insertelement <4 x i8> %v1, i8 %b, i64 0
  ret <4 x i8> %v2
}

define <2 x double> @vslide1up_2xf64_as_rotate(<2 x double> %v, double %b) {
; CHECK-LABEL: vslide1up_2xf64_as_rotate:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v1 = insertelement <2 x double> %v, double %b, i64 1
  %v2 = shufflevector <2 x double> %v1, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x double> %v2
}

define <4 x i8> @vslide1up_4xi8_as_rotate(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_as_rotate:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    vslidedown.vi v9, v8, 3
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v1 = insertelement <4 x i8> %v, i8 %b, i64 3
  %v2 = shufflevector <4 x i8> %v1, <4 x i8> poison, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  ret <4 x i8> %v2
}

; The length of the shift is less than the suffix, since we'd have to
; materailize the splat, using the vslide1up doesn't help us.
define <4 x i32> @vslide1up_4xi32_neg1(<4 x i32> %v, i32 %b) {
; CHECK-LABEL: vslide1up_4xi32_neg1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %vb = insertelement <4 x i32> poison, i32 %b, i64 0
  %vb2 = insertelement <4 x i32> %vb, i32 %b, i64 3
  %v1 = shufflevector <4 x i32> %v, <4 x i32> %vb2, <4 x i32> <i32 4, i32 0, i32 1, i32 7>
  ret <4 x i32> %v1
}

; We don't know the scalar to do the vslide1up
define <4 x i32> @vslide1up_4xi32_neg2(<4 x i32> %v1, <4 x i32> %v2) {
; CHECK-LABEL: vslide1up_4xi32_neg2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i32> %v1, <4 x i32> %v2, <4 x i32> <i32 4, i32 0, i32 1, i32 2>
  ret <4 x i32> %res
}

; Not profitable - can just use a slideup instead
define <4 x i8> @vslide1up_4xi8_neg_undef_insert(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_neg_undef_insert:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2 = shufflevector <4 x i8> poison, <4 x i8> %v, <4 x i32> <i32 0, i32 4, i32 5, i32 6>
  ret <4 x i8> %v2
}

define <4 x i8> @vslide1up_4xi8_neg_incorrect_insert(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_neg_incorrect_insert:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI23_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI23_0)
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2 = shufflevector <4 x i8> poison, <4 x i8> %v, <4 x i32> <i32 4, i32 4, i32 5, i32 6>
  ret <4 x i8> %v2
}

define <4 x i8> @vslide1up_4xi8_neg_incorrect_insert2(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_neg_incorrect_insert2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 3
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2 = shufflevector <4 x i8> poison, <4 x i8> %v, <4 x i32> <i32 7, i32 4, i32 5, i32 6>
  ret <4 x i8> %v2
}

define <4 x i8> @vslide1up_4xi8_neg_incorrect_insert3(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_neg_incorrect_insert3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI25_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI25_0)
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v10, (a0)
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2 = shufflevector <4 x i8> poison, <4 x i8> %v, <4 x i32> <i32 5, i32 4, i32 5, i32 6>
  ret <4 x i8> %v2
}

define <2 x i8> @vslide1up_4xi8_neg_length_changing(<4 x i8> %v, i8 %b) {
; CHECK-LABEL: vslide1up_4xi8_neg_length_changing:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, tu, ma
; CHECK-NEXT:    vmv1r.v v9, v8
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v1 = insertelement <4 x i8> %v, i8 %b, i64 0
  %v2 = shufflevector <4 x i8> %v1, <4 x i8> %v, <2 x i32> <i32 0, i32 4>
  ret <2 x i8> %v2
}
