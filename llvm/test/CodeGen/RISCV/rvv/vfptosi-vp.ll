; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+experimental-zvfh < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+experimental-zvfh < %s | FileCheck %s

declare <vscale x 2 x i7> @llvm.vp.fptosi.v4i7.v4f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i7> @vfptosi_v4i7_v4f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_v4i7_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i7> @llvm.vp.fptosi.v4i7.v4f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i7> %v
}

declare <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i8> %v
}

declare <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v10, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i64> %v
}

declare <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i8> %v
}

declare <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v10, v8, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i64> %v
}

declare <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @vfptosi_nxv2i8_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i8_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.fptosi.nxv2i8.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i8> %v
}

declare <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @vfptosi_nxv2i16_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i16_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v10, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.fptosi.nxv2i16.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @vfptosi_nxv2i32_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i32_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.fptosi.nxv2i32.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @vfptosi_nxv2i64_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv2i64_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.fptosi.nxv2i64.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x i64> %v
}

declare <vscale x 32 x i16> @llvm.vp.fptosi.nxv32i16.nxv32f32(<vscale x 32 x float>, <vscale x 32 x i1>, i32)

define <vscale x 32 x i16> @vfptosi_nxv32i16_nxv32f32(<vscale x 32 x float> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv32i16_nxv32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 2
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v12, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB25_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB25_2:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8re8.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfncvt.rtz.x.f.w v8, v16, v0.t
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.vp.fptosi.nxv32i16.nxv32f32(<vscale x 32 x float> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i16> %v
}

declare <vscale x 32 x i32> @llvm.vp.fptosi.nxv32i32.nxv32f32(<vscale x 32 x float>, <vscale x 32 x i1>, i32)

define <vscale x 32 x i32> @vfptosi_nxv32i32_nxv32f32(<vscale x 32 x float> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv32i32_nxv32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 2
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v16, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB26_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB26_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i32> @llvm.vp.fptosi.nxv32i32.nxv32f32(<vscale x 32 x float> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i32> %v
}

define <vscale x 32 x i32> @vfptosi_nxv32i32_nxv32f32_unmasked(<vscale x 32 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptosi_nxv32i32_nxv32f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v16, v16
; CHECK-NEXT:    bltu a0, a1, .LBB27_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB27_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i32> @llvm.vp.fptosi.nxv32i32.nxv32f32(<vscale x 32 x float> %va, <vscale x 32 x i1> shufflevector (<vscale x 32 x i1> insertelement (<vscale x 32 x i1> undef, i1 true, i32 0), <vscale x 32 x i1> undef, <vscale x 32 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 32 x i32> %v
}
