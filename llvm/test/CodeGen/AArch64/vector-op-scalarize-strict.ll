; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-apple-darwin | FileCheck %s

; Check that the legalizer doesn't crash when scalarizing FP instructions'
; operands or results. In each test either the result or the operand are
; illegal on AArch64, though not both.

define <1 x double> @test_sitofp(<1 x i1> %in) #0 {
; CHECK-LABEL: test_sitofp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sbfx w8, w0, #0, #1
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    ret
entry:
  %0 = call <1 x double> @llvm.experimental.constrained.sitofp.v1f64.v1i1(<1 x i1> %in, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <1 x double> %0
}

define <1 x double> @test_uitofp(<1 x i1> %in) #0 {
; CHECK-LABEL: test_uitofp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    ucvtf d0, w8
; CHECK-NEXT:    ret
entry:
  %0 = call <1 x double> @llvm.experimental.constrained.uitofp.v1f64.v1i1(<1 x i1> %in, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <1 x double> %0
}

define <1 x i1> @test_fcmp(<1 x double> %x, <1 x double> %y) #0 {
; CHECK-LABEL: test_fcmp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    fcmp d0, d1
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    csinc w0, w8, wzr, vc
; CHECK-NEXT:    ret
entry:
  %conv = tail call <1 x i1> @llvm.experimental.constrained.fcmp.v1f64(<1 x double> %x, <1 x double> %y, metadata !"ueq", metadata !"fpexcept.strict")
  ret <1 x i1> %conv
}

define <1 x i1> @test_fcmps(<1 x double> %x, <1 x double> %y) #0 {
; CHECK-LABEL: test_fcmps:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    fcmpe d0, d1
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    csinc w0, w8, wzr, vc
; CHECK-NEXT:    ret
entry:
  %conv = tail call <1 x i1> @llvm.experimental.constrained.fcmps.v1f64(<1 x double> %x, <1 x double> %y, metadata !"ueq", metadata !"fpexcept.strict")
  ret <1 x i1> %conv
}

attributes #0 = { strictfp }

declare <1 x double> @llvm.experimental.constrained.sitofp.v1f64.v1i1(<1 x i1>, metadata, metadata)
declare <1 x double> @llvm.experimental.constrained.uitofp.v1f64.v1i1(<1 x i1>, metadata, metadata)
declare <1 x i1> @llvm.experimental.constrained.fcmp.v1f64(<1 x double>, <1 x double>, metadata, metadata) #0
declare <1 x i1> @llvm.experimental.constrained.fcmps.v1f64(<1 x double>, <1 x double>, metadata, metadata) #0
