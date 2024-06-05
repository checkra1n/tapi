; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -enable-no-nans-fp-math -passes="print<cost-model>" 2>&1 -disable-output -mtriple=aarch64 -mattr=+fullfp16 -mattr=+sve | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define void @fadd() {
; CHECK-LABEL: 'fadd'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F16 = fadd <vscale x 4 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F16 = fadd <vscale x 8 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F16 = fadd <vscale x 16 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = fadd <vscale x 2 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = fadd <vscale x 4 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8F32 = fadd <vscale x 8 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = fadd <vscale x 2 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = fadd <vscale x 4 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V4F16 = fadd <vscale x 4 x half> undef, undef
  %V8F16 = fadd <vscale x 8 x half> undef, undef
  %V16F16 = fadd <vscale x 16 x half> undef, undef

  %V2F32 = fadd <vscale x 2 x float> undef, undef
  %V4F32 = fadd <vscale x 4 x float> undef, undef
  %V8F32 = fadd <vscale x 8 x float> undef, undef

  %V2F64 = fadd <vscale x 2 x double> undef, undef
  %V4F64 = fadd <vscale x 4 x double> undef, undef

  ret void
}

define void @fsub() {
; CHECK-LABEL: 'fsub'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F16 = fsub <vscale x 4 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F16 = fsub <vscale x 8 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F16 = fsub <vscale x 16 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = fsub <vscale x 2 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = fsub <vscale x 4 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8F32 = fsub <vscale x 8 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = fsub <vscale x 2 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = fsub <vscale x 4 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V4F16 = fsub <vscale x 4 x half> undef, undef
  %V8F16 = fsub <vscale x 8 x half> undef, undef
  %V16F16 = fsub <vscale x 16 x half> undef, undef

  %V2F32 = fsub <vscale x 2 x float> undef, undef
  %V4F32 = fsub <vscale x 4 x float> undef, undef
  %V8F32 = fsub <vscale x 8 x float> undef, undef

  %V2F64 = fsub <vscale x 2 x double> undef, undef
  %V4F64 = fsub <vscale x 4 x double> undef, undef

  ret void
}

define void @fneg() {
; CHECK-LABEL: 'fneg'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F16 = fneg <vscale x 2 x half> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F16 = fneg <vscale x 4 x half> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F16 = fneg <vscale x 8 x half> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F16 = fneg <vscale x 16 x half> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = fneg <vscale x 2 x float> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = fneg <vscale x 4 x float> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8F32 = fneg <vscale x 8 x float> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = fneg <vscale x 2 x double> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = fneg <vscale x 4 x double> undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V2F16 = fneg <vscale x 2 x half> undef
  %V4F16 = fneg <vscale x 4 x half> undef
  %V8F16 = fneg <vscale x 8 x half> undef
  %V16F16 = fneg <vscale x 16 x half> undef

  %V2F32 = fneg <vscale x 2 x float> undef
  %V4F32 = fneg <vscale x 4 x float> undef
  %V8F32 = fneg <vscale x 8 x float> undef

  %V2F64 = fneg <vscale x 2 x double> undef
  %V4F64 = fneg <vscale x 4 x double> undef

  ret void
}

define void @fmul() {
; CHECK-LABEL: 'fmul'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F16 = fmul <vscale x 4 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F16 = fmul <vscale x 8 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F16 = fmul <vscale x 16 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = fmul <vscale x 2 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = fmul <vscale x 4 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8F32 = fmul <vscale x 8 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = fmul <vscale x 2 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = fmul <vscale x 4 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V4F16 = fmul <vscale x 4 x half> undef, undef
  %V8F16 = fmul <vscale x 8 x half> undef, undef
  %V16F16 = fmul <vscale x 16 x half> undef, undef

  %V2F32 = fmul <vscale x 2 x float> undef, undef
  %V4F32 = fmul <vscale x 4 x float> undef, undef
  %V8F32 = fmul <vscale x 8 x float> undef, undef

  %V2F64 = fmul <vscale x 2 x double> undef, undef
  %V4F64 = fmul <vscale x 4 x double> undef, undef

  ret void
}

define void @fdiv() {
; CHECK-LABEL: 'fdiv'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F16 = fdiv <vscale x 4 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8F16 = fdiv <vscale x 8 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16F16 = fdiv <vscale x 16 x half> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F32 = fdiv <vscale x 2 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4F32 = fdiv <vscale x 4 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8F32 = fdiv <vscale x 8 x float> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2F64 = fdiv <vscale x 2 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V4F64 = fdiv <vscale x 4 x double> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %V4F16 = fdiv <vscale x 4 x half> undef, undef
  %V8F16 = fdiv <vscale x 8 x half> undef, undef
  %V16F16 = fdiv <vscale x 16 x half> undef, undef

  %V2F32 = fdiv <vscale x 2 x float> undef, undef
  %V4F32 = fdiv <vscale x 4 x float> undef, undef
  %V8F32 = fdiv <vscale x 8 x float> undef, undef

  %V2F64 = fdiv <vscale x 2 x double> undef, undef
  %V4F64 = fdiv <vscale x 4 x double> undef, undef

  ret void
}
