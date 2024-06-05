; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a  -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=FASTF16,GFX90A-FASTF64 %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900  -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=NOPACKEDF32,FASTF16,FASTF64 %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mattr=-half-rate-64-ops < %s | FileCheck -check-prefixes=NOPACKEDF32,SLOWF64 %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a  -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=FASTF16-SIZE,GFX90A-FASTF64-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900  -mattr=+half-rate-64-ops < %s | FileCheck -check-prefixes=NOPACKEDF32-SIZE,FASTF16-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mattr=-half-rate-64-ops < %s | FileCheck -check-prefixes=NOPACKEDF32-SIZE,SLOWF64-SIZE %s
; END.

define amdgpu_kernel void @fsub_f32() #0 {
; GFX90A-FASTF64-LABEL: 'fsub_f32'
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f32 = fsub float undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2f32 = fsub <2 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3f32 = fsub <3 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f32 = fsub <4 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v5f32 = fsub <5 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v8f32 = fsub <8 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v9f32 = fsub <9 x float> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; NOPACKEDF32-LABEL: 'fsub_f32'
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f32 = fsub float undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f32 = fsub <2 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3f32 = fsub <3 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f32 = fsub <4 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5f32 = fsub <5 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v8f32 = fsub <8 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v9f32 = fsub <9 x float> undef, undef
; NOPACKEDF32-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; GFX90A-FASTF64-SIZE-LABEL: 'fsub_f32'
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f32 = fsub float undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2f32 = fsub <2 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3f32 = fsub <3 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f32 = fsub <4 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v5f32 = fsub <5 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v8f32 = fsub <8 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v9f32 = fsub <9 x float> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; NOPACKEDF32-SIZE-LABEL: 'fsub_f32'
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f32 = fsub float undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f32 = fsub <2 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3f32 = fsub <3 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f32 = fsub <4 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %v5f32 = fsub <5 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v8f32 = fsub <8 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v9f32 = fsub <9 x float> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f32 = fsub float undef, undef
  %v2f32 = fsub <2 x float> undef, undef
  %v3f32 = fsub <3 x float> undef, undef
  %v4f32 = fsub <4 x float> undef, undef
  %v5f32 = fsub <5 x float> undef, undef
  %v8f32 = fsub <8 x float> undef, undef
  %v9f32 = fsub <9 x float> undef, undef
  ret void
}

define amdgpu_kernel void @fsub_f64() #0 {
; GFX90A-FASTF64-LABEL: 'fsub_f64'
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f64 = fsub double undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f64 = fsub <2 x double> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3f64 = fsub <3 x double> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f64 = fsub <4 x double> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v5f64 = fsub <5 x double> undef, undef
; GFX90A-FASTF64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; FASTF64-LABEL: 'fsub_f64'
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %f64 = fsub double undef, undef
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2f64 = fsub <2 x double> undef, undef
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3f64 = fsub <3 x double> undef, undef
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4f64 = fsub <4 x double> undef, undef
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5f64 = fsub <5 x double> undef, undef
; FASTF64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; SLOWF64-LABEL: 'fsub_f64'
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %f64 = fsub double undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v2f64 = fsub <2 x double> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v3f64 = fsub <3 x double> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v4f64 = fsub <4 x double> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v5f64 = fsub <5 x double> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; GFX90A-FASTF64-SIZE-LABEL: 'fsub_f64'
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f64 = fsub double undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f64 = fsub <2 x double> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %v3f64 = fsub <3 x double> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f64 = fsub <4 x double> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v5f64 = fsub <5 x double> undef, undef
; GFX90A-FASTF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; NOPACKEDF32-SIZE-LABEL: 'fsub_f64'
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %f64 = fsub double undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v2f64 = fsub <2 x double> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %v3f64 = fsub <3 x double> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v4f64 = fsub <4 x double> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v5f64 = fsub <5 x double> undef, undef
; NOPACKEDF32-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f64 = fsub double undef, undef
  %v2f64 = fsub <2 x double> undef, undef
  %v3f64 = fsub <3 x double> undef, undef
  %v4f64 = fsub <4 x double> undef, undef
  %v5f64 = fsub <5 x double> undef, undef
  ret void
}

define amdgpu_kernel void @fsub_f16() #0 {
; FASTF16-LABEL: 'fsub_f16'
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f16 = fsub half undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2f16 = fsub <2 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3f16 = fsub <3 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f16 = fsub <4 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5f16 = fsub <5 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v16f16 = fsub <16 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v17f16 = fsub <17 x half> undef, undef
; FASTF16-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; SLOWF64-LABEL: 'fsub_f16'
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f16 = fsub half undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f16 = fsub <2 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3f16 = fsub <3 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f16 = fsub <4 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5f16 = fsub <5 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v16f16 = fsub <16 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %v17f16 = fsub <17 x half> undef, undef
; SLOWF64-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; FASTF16-SIZE-LABEL: 'fsub_f16'
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f16 = fsub half undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %v2f16 = fsub <2 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v3f16 = fsub <3 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f16 = fsub <4 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v5f16 = fsub <5 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v16f16 = fsub <16 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v17f16 = fsub <17 x half> undef, undef
; FASTF16-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SLOWF64-SIZE-LABEL: 'fsub_f16'
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f16 = fsub half undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f16 = fsub <2 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v3f16 = fsub <3 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %v4f16 = fsub <4 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v5f16 = fsub <5 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v16f16 = fsub <16 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %v17f16 = fsub <17 x half> undef, undef
; SLOWF64-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %f16 = fsub half undef, undef
  %v2f16 = fsub <2 x half> undef, undef
  %v3f16 = fsub <3 x half> undef, undef
  %v4f16 = fsub <4 x half> undef, undef
  %v5f16 = fsub <5 x half> undef, undef
  %v16f16 = fsub <16 x half> undef, undef
  %v17f16 = fsub <17 x half> undef, undef
  ret void
}
