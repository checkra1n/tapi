; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x half> @vfmerge_vv_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %vb, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x half> %va, <vscale x 1 x half> %vb
  ret <vscale x 1 x half> %vc
}

define <vscale x 1 x half> @vfmerge_fv_nxv1f16(<vscale x 1 x half> %va, half %b, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 1 x half> %head, <vscale x 1 x half> poison, <vscale x 1 x i32> zeroinitializer
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x half> %splat, <vscale x 1 x half> %va
  ret <vscale x 1 x half> %vc
}

define <vscale x 2 x half> @vfmerge_vv_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x half> %vb, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x half> %va, <vscale x 2 x half> %vb
  ret <vscale x 2 x half> %vc
}

define <vscale x 2 x half> @vfmerge_fv_nxv2f16(<vscale x 2 x half> %va, half %b, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 2 x half> %head, <vscale x 2 x half> poison, <vscale x 2 x i32> zeroinitializer
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x half> %splat, <vscale x 2 x half> %va
  ret <vscale x 2 x half> %vc
}

define <vscale x 4 x half> @vfmerge_vv_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x half> %vb, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x half> %va, <vscale x 4 x half> %vb
  ret <vscale x 4 x half> %vc
}

define <vscale x 4 x half> @vfmerge_fv_nxv4f16(<vscale x 4 x half> %va, half %b, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 4 x half> %head, <vscale x 4 x half> poison, <vscale x 4 x i32> zeroinitializer
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x half> %splat, <vscale x 4 x half> %va
  ret <vscale x 4 x half> %vc
}

define <vscale x 8 x half> @vfmerge_vv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x half> %vb, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x half> %va, <vscale x 8 x half> %vb
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vfmerge_fv_nxv8f16(<vscale x 8 x half> %va, half %b, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x half> %splat, <vscale x 8 x half> %va
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vfmerge_zv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_zv_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half zeroinitializer, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x half> %splat, <vscale x 8 x half> %va
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vmerge_truelhs_nxv8f16_0(<vscale x 8 x half> %va, <vscale x 8 x half> %vb) {
; CHECK-LABEL: vmerge_truelhs_nxv8f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %mhead = insertelement <vscale x 8 x i1> poison, i1 1, i32 0
  %mtrue = shufflevector <vscale x 8 x i1> %mhead, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %mtrue, <vscale x 8 x half> %va, <vscale x 8 x half> %vb
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vmerge_falselhs_nxv8f16_0(<vscale x 8 x half> %va, <vscale x 8 x half> %vb) {
; CHECK-LABEL: vmerge_falselhs_nxv8f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %vc = select <vscale x 8 x i1> zeroinitializer, <vscale x 8 x half> %va, <vscale x 8 x half> %vb
  ret <vscale x 8 x half> %vc
}

define <vscale x 16 x half> @vfmerge_vv_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x half> %vb, <vscale x 16 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 16 x i1> %cond, <vscale x 16 x half> %va, <vscale x 16 x half> %vb
  ret <vscale x 16 x half> %vc
}

define <vscale x 16 x half> @vfmerge_fv_nxv16f16(<vscale x 16 x half> %va, half %b, <vscale x 16 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 16 x half> %head, <vscale x 16 x half> poison, <vscale x 16 x i32> zeroinitializer
  %vc = select <vscale x 16 x i1> %cond, <vscale x 16 x half> %splat, <vscale x 16 x half> %va
  ret <vscale x 16 x half> %vc
}

define <vscale x 32 x half> @vfmerge_vv_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x half> %vb, <vscale x 32 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 32 x i1> %cond, <vscale x 32 x half> %va, <vscale x 32 x half> %vb
  ret <vscale x 32 x half> %vc
}

define <vscale x 32 x half> @vfmerge_fv_nxv32f16(<vscale x 32 x half> %va, half %b, <vscale x 32 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 32 x half> %head, <vscale x 32 x half> poison, <vscale x 32 x i32> zeroinitializer
  %vc = select <vscale x 32 x i1> %cond, <vscale x 32 x half> %splat, <vscale x 32 x half> %va
  ret <vscale x 32 x half> %vc
}

define <vscale x 1 x float> @vfmerge_vv_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %vb, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x float> %va, <vscale x 1 x float> %vb
  ret <vscale x 1 x float> %vc
}

define <vscale x 1 x float> @vfmerge_fv_nxv1f32(<vscale x 1 x float> %va, float %b, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 1 x float> %head, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x float> %splat, <vscale x 1 x float> %va
  ret <vscale x 1 x float> %vc
}

define <vscale x 2 x float> @vfmerge_vv_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x float> %vb, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x float> %va, <vscale x 2 x float> %vb
  ret <vscale x 2 x float> %vc
}

define <vscale x 2 x float> @vfmerge_fv_nxv2f32(<vscale x 2 x float> %va, float %b, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 2 x float> %head, <vscale x 2 x float> poison, <vscale x 2 x i32> zeroinitializer
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x float> %splat, <vscale x 2 x float> %va
  ret <vscale x 2 x float> %vc
}

define <vscale x 4 x float> @vfmerge_vv_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x float> %vb, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x float> %va, <vscale x 4 x float> %vb
  ret <vscale x 4 x float> %vc
}

define <vscale x 4 x float> @vfmerge_fv_nxv4f32(<vscale x 4 x float> %va, float %b, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 4 x float> %head, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x float> %splat, <vscale x 4 x float> %va
  ret <vscale x 4 x float> %vc
}

define <vscale x 8 x float> @vfmerge_vv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x float> %vb, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x float> %va, <vscale x 8 x float> %vb
  ret <vscale x 8 x float> %vc
}

define <vscale x 8 x float> @vfmerge_fv_nxv8f32(<vscale x 8 x float> %va, float %b, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x float> %splat, <vscale x 8 x float> %va
  ret <vscale x 8 x float> %vc
}

define <vscale x 8 x float> @vfmerge_zv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_zv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float zeroinitializer, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x float> %splat, <vscale x 8 x float> %va
  ret <vscale x 8 x float> %vc
}

define <vscale x 16 x float> @vfmerge_vv_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x float> %vb, <vscale x 16 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 16 x i1> %cond, <vscale x 16 x float> %va, <vscale x 16 x float> %vb
  ret <vscale x 16 x float> %vc
}

define <vscale x 16 x float> @vfmerge_fv_nxv16f32(<vscale x 16 x float> %va, float %b, <vscale x 16 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 16 x float> %head, <vscale x 16 x float> poison, <vscale x 16 x i32> zeroinitializer
  %vc = select <vscale x 16 x i1> %cond, <vscale x 16 x float> %splat, <vscale x 16 x float> %va
  ret <vscale x 16 x float> %vc
}

define <vscale x 1 x double> @vfmerge_vv_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %vb, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x double> %va, <vscale x 1 x double> %vb
  ret <vscale x 1 x double> %vc
}

define <vscale x 1 x double> @vfmerge_fv_nxv1f64(<vscale x 1 x double> %va, double %b, <vscale x 1 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 1 x double> %head, <vscale x 1 x double> poison, <vscale x 1 x i32> zeroinitializer
  %vc = select <vscale x 1 x i1> %cond, <vscale x 1 x double> %splat, <vscale x 1 x double> %va
  ret <vscale x 1 x double> %vc
}

define <vscale x 2 x double> @vfmerge_vv_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x double> %vb, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x double> %va, <vscale x 2 x double> %vb
  ret <vscale x 2 x double> %vc
}

define <vscale x 2 x double> @vfmerge_fv_nxv2f64(<vscale x 2 x double> %va, double %b, <vscale x 2 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 2 x double> %head, <vscale x 2 x double> poison, <vscale x 2 x i32> zeroinitializer
  %vc = select <vscale x 2 x i1> %cond, <vscale x 2 x double> %splat, <vscale x 2 x double> %va
  ret <vscale x 2 x double> %vc
}

define <vscale x 4 x double> @vfmerge_vv_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x double> %vb, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x double> %va, <vscale x 4 x double> %vb
  ret <vscale x 4 x double> %vc
}

define <vscale x 4 x double> @vfmerge_fv_nxv4f64(<vscale x 4 x double> %va, double %b, <vscale x 4 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 4 x double> %head, <vscale x 4 x double> poison, <vscale x 4 x i32> zeroinitializer
  %vc = select <vscale x 4 x i1> %cond, <vscale x 4 x double> %splat, <vscale x 4 x double> %va
  ret <vscale x 4 x double> %vc
}

define <vscale x 8 x double> @vfmerge_vv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x double> %vb, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_vv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x double> %va, <vscale x 8 x double> %vb
  ret <vscale x 8 x double> %vc
}

define <vscale x 8 x double> @vfmerge_fv_nxv8f64(<vscale x 8 x double> %va, double %b, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_fv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfmerge.vfm v8, v8, fa0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x double> %splat, <vscale x 8 x double> %va
  ret <vscale x 8 x double> %vc
}

define <vscale x 8 x double> @vfmerge_zv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %cond) {
; CHECK-LABEL: vfmerge_zv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double zeroinitializer, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %vc = select <vscale x 8 x i1> %cond, <vscale x 8 x double> %splat, <vscale x 8 x double> %va
  ret <vscale x 8 x double> %vc
}

define <vscale x 16 x double> @vselect_combine_regression(<vscale x 16 x i64> %va, <vscale x 16 x double> %vb) {
; CHECK-LABEL: vselect_combine_regression:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vl8re64.v v8, (a1)
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vl8re64.v v8, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmseq.vi v24, v16, 0
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmseq.vi v0, v16, 0
; CHECK-NEXT:    vmv.v.i v16, 0
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v16, v16, v24, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %cond = icmp eq <vscale x 16 x i64> %va, zeroinitializer
  %sel = select <vscale x 16 x i1> %cond, <vscale x 16 x double> %vb, <vscale x 16 x double> zeroinitializer
  ret <vscale x 16 x double> %sel
}

define void @vselect_legalize_regression(<vscale x 16 x double> %a, <vscale x 16 x i1> %ma, <vscale x 16 x i1> %mb, <vscale x 16 x double>* %out) {
; CHECK-LABEL: vselect_legalize_regression:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, m2, ta, ma
; CHECK-NEXT:    vlm.v v24, (a0)
; CHECK-NEXT:    vmand.mm v1, v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a2, a0, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v1, a2
; CHECK-NEXT:    vsetvli a2, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v24, 0
; CHECK-NEXT:    vmerge.vvm v16, v24, v16, v0
; CHECK-NEXT:    vmv1r.v v0, v1
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    vs8r.v v8, (a1)
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    vs8r.v v16, (a0)
; CHECK-NEXT:    ret
  %cond = and <vscale x 16 x i1> %ma, %mb
  %sel = select <vscale x 16 x i1> %cond, <vscale x 16 x double> %a, <vscale x 16 x double> zeroinitializer
  store <vscale x 16 x double> %sel, <vscale x 16 x double>* %out
  ret void
}
