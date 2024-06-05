; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-eabi -aarch64-neon-syntax=apple | FileCheck %s

; DAGCombine to transform a conversion of an extract_vector_elt to an
; extract_vector_elt of a conversion, which saves a round trip of copies
; of the value to a GPR and back to and FPR.
; rdar://11855286
define double @foo0(<2 x i64> %a) nounwind {
; CHECK-LABEL: foo0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf.2d v0, v0, #9
; CHECK-NEXT:    mov d0, v0[1]
; CHECK-NEXT:    ret
  %vecext = extractelement <2 x i64> %a, i32 1
  %fcvt_n = tail call double @llvm.aarch64.neon.vcvtfxs2fp.f64.i64(i64 %vecext, i32 9)
  ret double %fcvt_n
}

define double @bar(ptr %iVals, ptr %fVals, ptr %dVals) {
; CHECK-LABEL: bar:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x2, #128]
; CHECK-NEXT:    frinti d0, d0
; CHECK-NEXT:    fcvtzs x8, d0
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    sri d0, d0, #1
; CHECK-NEXT:    scvtf.2d v0, v0, #1
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
entry:
  %arrayidx = getelementptr inbounds double, ptr %dVals, i64 16
  %0 = load <1 x double>, ptr %arrayidx, align 8
  %vrndi_v1.i = call <1 x double> @llvm.nearbyint.v1f64(<1 x double> %0)
  %vget_lane = extractelement <1 x double> %vrndi_v1.i, i64 0
  %vcvtd_s64_f64.i = call i64 @llvm.aarch64.neon.fcvtzs.i64.f64(double %vget_lane)
  %1 = insertelement <1 x i64> poison, i64 %vcvtd_s64_f64.i, i64 0
  %vsrid_n_s647 = call <1 x i64> @llvm.aarch64.neon.vsri.v1i64(<1 x i64> %1, <1 x i64> %1, i32 1)
  %2 = extractelement <1 x i64> %vsrid_n_s647, i64 0
  %vcvtd_n_f64_s64 = call double @llvm.aarch64.neon.vcvtfxs2fp.f64.i64(i64 %2, i32 1)
  ret double %vcvtd_n_f64_s64
}

define float @do_stuff(<8 x i16> noundef %var_135) {
; CHECK-LABEL: do_stuff:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    umaxv.8h h0, v0
; CHECK-NEXT:    ucvtf s0, s0, #1
; CHECK-NEXT:    ret
entry:
  %vmaxv.i = call i32 @llvm.aarch64.neon.umaxv.i32.v8i16(<8 x i16> %var_135) #2
  %vcvts_n_f32_u32 = call float @llvm.aarch64.neon.vcvtfxu2fp.f32.i32(i32 %vmaxv.i, i32 1)
  ret float %vcvts_n_f32_u32
}

declare <1 x i64> @llvm.aarch64.neon.vsri.v1i64(<1 x i64>, <1 x i64>, i32)
declare double @llvm.aarch64.neon.vcvtfxs2fp.f64.i64(i64, i32)
declare <1 x double> @llvm.nearbyint.v1f64(<1 x double>)
declare i64 @llvm.aarch64.neon.fcvtzs.i64.f64(double)
declare i32 @llvm.aarch64.neon.umaxv.i32.v8i16(<8 x i16>) #1
declare float @llvm.aarch64.neon.vcvtfxu2fp.f32.i32(i32, i32) #1
