; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <4 x i8> @load_v4i8(ptr %a) {
; CHECK-LABEL: load_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %load = load <4 x i8>, ptr %a
  ret <4 x i8> %load
}

define <8 x i8> @load_v8i8(ptr %a) {
; CHECK-LABEL: load_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <8 x i8>, ptr %a
  ret <8 x i8> %load
}

define <16 x i8> @load_v16i8(ptr %a) {
; CHECK-LABEL: load_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <16 x i8>, ptr %a
  ret <16 x i8> %load
}

define <32 x i8> @load_v32i8(ptr %a) {
; CHECK-LABEL: load_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <32 x i8>, ptr %a
  ret <32 x i8> %load
}

define <2 x i16> @load_v2i16(ptr %a) {
; CHECK-LABEL: load_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    ldrh w8, [x0, #2]
; CHECK-NEXT:    str w8, [sp, #12]
; CHECK-NEXT:    ldrh w8, [x0]
; CHECK-NEXT:    str w8, [sp, #8]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %load = load <2 x i16>, ptr %a
  ret <2 x i16> %load
}

define <2 x half> @load_v2f16(ptr %a) {
; CHECK-LABEL: load_v2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %load = load <2 x half>, ptr %a
  ret <2 x half> %load
}

define <4 x i16> @load_v4i16(ptr %a) {
; CHECK-LABEL: load_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x i16>, ptr %a
  ret <4 x i16> %load
}

define <4 x half> @load_v4f16(ptr %a) {
; CHECK-LABEL: load_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x half>, ptr %a
  ret <4 x half> %load
}

define <8 x i16> @load_v8i16(ptr %a) {
; CHECK-LABEL: load_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <8 x i16>, ptr %a
  ret <8 x i16> %load
}

define <8 x half> @load_v8f16(ptr %a) {
; CHECK-LABEL: load_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <8 x half>, ptr %a
  ret <8 x half> %load
}

define <16 x i16> @load_v16i16(ptr %a) {
; CHECK-LABEL: load_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <16 x i16>, ptr %a
  ret <16 x i16> %load
}

define <16 x half> @load_v16f16(ptr %a) {
; CHECK-LABEL: load_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <16 x half>, ptr %a
  ret <16 x half> %load
}

define <2 x i32> @load_v2i32(ptr %a) {
; CHECK-LABEL: load_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <2 x i32>, ptr %a
  ret <2 x i32> %load
}

define <2 x float> @load_v2f32(ptr %a) {
; CHECK-LABEL: load_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <2 x float>, ptr %a
  ret <2 x float> %load
}

define <4 x i32> @load_v4i32(ptr %a) {
; CHECK-LABEL: load_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x i32>, ptr %a
  ret <4 x i32> %load
}

define <4 x float> @load_v4f32(ptr %a) {
; CHECK-LABEL: load_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x float>, ptr %a
  ret <4 x float> %load
}

define <8 x i32> @load_v8i32(ptr %a) {
; CHECK-LABEL: load_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <8 x i32>, ptr %a
  ret <8 x i32> %load
}

define <8 x float> @load_v8f32(ptr %a) {
; CHECK-LABEL: load_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <8 x float>, ptr %a
  ret <8 x float> %load
}

define <1 x i64> @load_v1i64(ptr %a) {
; CHECK-LABEL: load_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <1 x i64>, ptr %a
  ret <1 x i64> %load
}

define <1 x double> @load_v1f64(ptr %a) {
; CHECK-LABEL: load_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %load = load <1 x double>, ptr %a
  ret <1 x double> %load
}

define <2 x i64> @load_v2i64(ptr %a) {
; CHECK-LABEL: load_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <2 x i64>, ptr %a
  ret <2 x i64> %load
}

define <2 x double> @load_v2f64(ptr %a) {
; CHECK-LABEL: load_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ret
  %load = load <2 x double>, ptr %a
  ret <2 x double> %load
}

define <4 x i64> @load_v4i64(ptr %a) {
; CHECK-LABEL: load_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x i64>, ptr %a
  ret <4 x i64> %load
}

define <4 x double> @load_v4f64(ptr %a) {
; CHECK-LABEL: load_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ret
  %load = load <4 x double>, ptr %a
  ret <4 x double> %load
}

