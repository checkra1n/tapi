; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-LE
; RUN: llc -mtriple=thumbebv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-BE

define void @foo_int8_int32(<4 x i8>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vstrb.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i8>
  store <4 x i8> %0, <4 x i8>* %dest, align 1
  ret void
}

define void @foo_int16_int32(<4 x i16>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vstrh.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i16>
  store <4 x i16> %0, <4 x i16>* %dest, align 2
  ret void
}

define void @foo_int8_int16(<8 x i8>* %dest, <8 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q0, [r1]
; CHECK-NEXT:    vstrb.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i16>, <8 x i16>* %src, align 2
  %0 = trunc <8 x i16> %wide.load to <8 x i8>
  store <8 x i8> %0, <8 x i8>* %dest, align 1
  ret void
}


define void @foo_int8_int32_double(<8 x i8>* %dest, <8 x i32>* readonly %src, i32 %n) {
; CHECK-LE-LABEL: foo_int8_int32_double:
; CHECK-LE:       @ %bb.0: @ %entry
; CHECK-LE-NEXT:    vldrh.u16 q1, [r1]
; CHECK-LE-NEXT:    vmov r2, r3, d2
; CHECK-LE-NEXT:    vmov.16 q0[0], r2
; CHECK-LE-NEXT:    vmov.16 q0[1], r3
; CHECK-LE-NEXT:    vmov r2, r3, d3
; CHECK-LE-NEXT:    vldrh.u16 q1, [r1, #16]
; CHECK-LE-NEXT:    vmov.16 q0[2], r2
; CHECK-LE-NEXT:    vmov.16 q0[3], r3
; CHECK-LE-NEXT:    vmov r1, r2, d2
; CHECK-LE-NEXT:    vmov.16 q0[4], r1
; CHECK-LE-NEXT:    vmov.16 q0[5], r2
; CHECK-LE-NEXT:    vmov r1, r2, d3
; CHECK-LE-NEXT:    vmov.16 q0[6], r1
; CHECK-LE-NEXT:    vmov.16 q0[7], r2
; CHECK-LE-NEXT:    vstrb.16 q0, [r0]
; CHECK-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: foo_int8_int32_double:
; CHECK-BE:       @ %bb.0: @ %entry
; CHECK-BE-NEXT:    vldrb.u8 q0, [r1]
; CHECK-BE-NEXT:    vrev32.8 q1, q0
; CHECK-BE-NEXT:    vmov r2, r3, d2
; CHECK-BE-NEXT:    vmov.16 q0[0], r2
; CHECK-BE-NEXT:    vmov.16 q0[1], r3
; CHECK-BE-NEXT:    vmov r2, r3, d3
; CHECK-BE-NEXT:    vldrb.u8 q1, [r1, #16]
; CHECK-BE-NEXT:    vmov.16 q0[2], r2
; CHECK-BE-NEXT:    vmov.16 q0[3], r3
; CHECK-BE-NEXT:    vrev32.8 q1, q1
; CHECK-BE-NEXT:    vmov r1, r2, d2
; CHECK-BE-NEXT:    vmov.16 q0[4], r1
; CHECK-BE-NEXT:    vmov.16 q0[5], r2
; CHECK-BE-NEXT:    vmov r1, r2, d3
; CHECK-BE-NEXT:    vmov.16 q0[6], r1
; CHECK-BE-NEXT:    vmov.16 q0[7], r2
; CHECK-BE-NEXT:    vstrb.16 q0, [r0]
; CHECK-BE-NEXT:    bx lr
entry:
  %wide.load = load <8 x i32>, <8 x i32>* %src, align 2
  %0 = trunc <8 x i32> %wide.load to <8 x i8>
  store <8 x i8> %0, <8 x i8>* %dest, align 1
  ret void
}

define void @foo_int16_int32_double(<8 x i16>* %dest, <8 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int32_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r1, #16]
; CHECK-NEXT:    vstrh.32 q1, [r0, #8]
; CHECK-NEXT:    vstrh.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i32>, <8 x i32>* %src, align 4
  %0 = trunc <8 x i32> %wide.load to <8 x i16>
  store <8 x i16> %0, <8 x i16>* %dest, align 2
  ret void
}

define void @foo_int8_int16_double(<16 x i8>* %dest, <16 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int16_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q0, [r1]
; CHECK-NEXT:    vldrh.u16 q1, [r1, #16]
; CHECK-NEXT:    vstrb.16 q1, [r0, #8]
; CHECK-NEXT:    vstrb.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i16>, <16 x i16>* %src, align 2
  %0 = trunc <16 x i16> %wide.load to <16 x i8>
  store <16 x i8> %0, <16 x i8>* %dest, align 1
  ret void
}

define void @foo_int8_int32_quad(<16 x i8>* %dest, <16 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int8_int32_quad:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r1, #16]
; CHECK-NEXT:    vldrw.u32 q2, [r1, #32]
; CHECK-NEXT:    vldrw.u32 q3, [r1, #48]
; CHECK-NEXT:    vstrb.32 q1, [r0, #4]
; CHECK-NEXT:    vstrb.32 q0, [r0]
; CHECK-NEXT:    vstrb.32 q3, [r0, #12]
; CHECK-NEXT:    vstrb.32 q2, [r0, #8]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i32>, <16 x i32>* %src, align 4
  %0 = trunc <16 x i32> %wide.load to <16 x i8>
  store <16 x i8> %0, <16 x i8>* %dest, align 1
  ret void
}


define void @foo_int32_int8(<4 x i32>* %dest, <4 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i8>, <4 x i8>* %src, align 1
  %0 = sext <4 x i8> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_int16_int8(<8 x i16>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s16 q0, [r1]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = sext <8 x i8> %wide.load to <8 x i16>
  store <8 x i16> %0, <8 x i16>* %dest, align 2
  ret void
}

define void @foo_int32_int16(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 2
  %0 = sext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_int32_int8_double(<8 x i32>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int8_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vldrb.s32 q1, [r1, #4]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = sext <8 x i8> %wide.load to <8 x i32>
  store <8 x i32> %0, <8 x i32>* %dest, align 4
  ret void
}

define void @foo_int16_int8_double(<16 x i16>* %dest, <16 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int8_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s16 q0, [r1]
; CHECK-NEXT:    vldrb.s16 q1, [r1, #8]
; CHECK-NEXT:    vstrh.16 q1, [r0, #16]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i8>, <16 x i8>* %src, align 1
  %0 = sext <16 x i8> %wide.load to <16 x i16>
  store <16 x i16> %0, <16 x i16>* %dest, align 2
  ret void
}

define void @foo_int32_int16_double(<8 x i32>* %dest, <8 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int16_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vldrh.s32 q1, [r1, #8]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i16>, <8 x i16>* %src, align 2
  %0 = sext <8 x i16> %wide.load to <8 x i32>
  store <8 x i32> %0, <8 x i32>* %dest, align 4
  ret void
}

define void @foo_int32_int8_quad(<16 x i32>* %dest, <16 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int8_quad:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s32 q0, [r1]
; CHECK-NEXT:    vldrb.s32 q1, [r1, #4]
; CHECK-NEXT:    vldrb.s32 q2, [r1, #8]
; CHECK-NEXT:    vldrb.s32 q3, [r1, #12]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q3, [r0, #48]
; CHECK-NEXT:    vstrw.32 q2, [r0, #32]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i8>, <16 x i8>* %src, align 1
  %0 = sext <16 x i8> %wide.load to <16 x i32>
  store <16 x i32> %0, <16 x i32>* %dest, align 4
  ret void
}


define void @foo_uint32_uint8(<4 x i32>* %dest, <4 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i8>, <4 x i8>* %src, align 1
  %0 = zext <4 x i8> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_uint16_uint8(<8 x i16>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint16_uint8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q0, [r1]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = zext <8 x i8> %wide.load to <8 x i16>
  store <8 x i16> %0, <8 x i16>* %dest, align 2
  ret void
}

define void @foo_uint32_uint16(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 2
  %0 = zext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}


define void @foo_uint32_uint8_double(<8 x i32>* %dest, <8 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint8_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u32 q0, [r1]
; CHECK-NEXT:    vldrb.u32 q1, [r1, #4]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i8>, <8 x i8>* %src, align 1
  %0 = zext <8 x i8> %wide.load to <8 x i32>
  store <8 x i32> %0, <8 x i32>* %dest, align 4
  ret void
}

define void @foo_uint16_uint8_double(<16 x i16>* %dest, <16 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint16_uint8_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q0, [r1]
; CHECK-NEXT:    vldrb.u16 q1, [r1, #8]
; CHECK-NEXT:    vstrh.16 q1, [r0, #16]
; CHECK-NEXT:    vstrh.16 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i8>, <16 x i8>* %src, align 1
  %0 = zext <16 x i8> %wide.load to <16 x i16>
  store <16 x i16> %0, <16 x i16>* %dest, align 2
  ret void
}

define void @foo_uint32_uint16_double(<8 x i32>* %dest, <8 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16_double:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u32 q0, [r1]
; CHECK-NEXT:    vldrh.u32 q1, [r1, #8]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <8 x i16>, <8 x i16>* %src, align 2
  %0 = zext <8 x i16> %wide.load to <8 x i32>
  store <8 x i32> %0, <8 x i32>* %dest, align 4
  ret void
}

define void @foo_uint32_uint8_quad(<16 x i32>* %dest, <16 x i8>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint8_quad:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u32 q0, [r1]
; CHECK-NEXT:    vldrb.u32 q1, [r1, #4]
; CHECK-NEXT:    vldrb.u32 q2, [r1, #8]
; CHECK-NEXT:    vldrb.u32 q3, [r1, #12]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q3, [r0, #48]
; CHECK-NEXT:    vstrw.32 q2, [r0, #32]
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <16 x i8>, <16 x i8>* %src, align 1
  %0 = zext <16 x i8> %wide.load to <16 x i32>
  store <16 x i32> %0, <16 x i32>* %dest, align 4
  ret void
}


define void @foo_int32_int8_both(<16 x i32>* %dest, <16 x i8>* readonly %src, i32 %n) {
; CHECK-LE-LABEL: foo_int32_int8_both:
; CHECK-LE:       @ %bb.0: @ %entry
; CHECK-LE-NEXT:    .pad #32
; CHECK-LE-NEXT:    sub sp, #32
; CHECK-LE-NEXT:    vldrb.s16 q0, [r1, #8]
; CHECK-LE-NEXT:    add r2, sp, #16
; CHECK-LE-NEXT:    vstrw.32 q0, [r2]
; CHECK-LE-NEXT:    vldrb.s16 q0, [r1]
; CHECK-LE-NEXT:    mov r1, sp
; CHECK-LE-NEXT:    vstrw.32 q0, [r1]
; CHECK-LE-NEXT:    vldrh.u32 q0, [r2, #8]
; CHECK-LE-NEXT:    vstrw.32 q0, [r0, #48]
; CHECK-LE-NEXT:    vldrh.u32 q0, [r2]
; CHECK-LE-NEXT:    vstrw.32 q0, [r0, #32]
; CHECK-LE-NEXT:    vldrh.u32 q0, [r1, #8]
; CHECK-LE-NEXT:    vstrw.32 q0, [r0, #16]
; CHECK-LE-NEXT:    vldrh.u32 q0, [r1]
; CHECK-LE-NEXT:    vstrw.32 q0, [r0]
; CHECK-LE-NEXT:    add sp, #32
; CHECK-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: foo_int32_int8_both:
; CHECK-BE:       @ %bb.0: @ %entry
; CHECK-BE-NEXT:    .pad #32
; CHECK-BE-NEXT:    sub sp, #32
; CHECK-BE-NEXT:    vldrb.s16 q0, [r1, #8]
; CHECK-BE-NEXT:    add r2, sp, #16
; CHECK-BE-NEXT:    vstrh.16 q0, [r2]
; CHECK-BE-NEXT:    vldrb.s16 q0, [r1]
; CHECK-BE-NEXT:    mov r1, sp
; CHECK-BE-NEXT:    vstrh.16 q0, [r1]
; CHECK-BE-NEXT:    vldrh.u32 q0, [r2, #8]
; CHECK-BE-NEXT:    vstrw.32 q0, [r0, #48]
; CHECK-BE-NEXT:    vldrh.u32 q0, [r2]
; CHECK-BE-NEXT:    vstrw.32 q0, [r0, #32]
; CHECK-BE-NEXT:    vldrh.u32 q0, [r1, #8]
; CHECK-BE-NEXT:    vstrw.32 q0, [r0, #16]
; CHECK-BE-NEXT:    vldrh.u32 q0, [r1]
; CHECK-BE-NEXT:    vstrw.32 q0, [r0]
; CHECK-BE-NEXT:    add sp, #32
; CHECK-BE-NEXT:    bx lr
entry:
  %wide.load = load <16 x i8>, <16 x i8>* %src, align 1
  %0 = sext <16 x i8> %wide.load to <16 x i16>
  %1 = zext <16 x i16> %0 to <16 x i32>
  store <16 x i32> %1, <16 x i32>* %dest, align 4
  ret void
}

define <8 x i16>* @foo_uint32_uint16_double_offset(<8 x i32>* %dest, <8 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16_double_offset:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1, #16]!
; CHECK-NEXT:    vldrh.s32 q1, [r1, #8]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bx lr
entry:
  %z = getelementptr inbounds <8 x i16>, <8 x i16>* %src, i32 1
  %wide.load = load <8 x i16>, <8 x i16>* %z, align 2
  %0 = sext <8 x i16> %wide.load to <8 x i32>
  store <8 x i32> %0, <8 x i32>* %dest, align 4
  ret <8 x i16>* %z
}

define <16 x i16>* @foo_uint32_uint16_quad_offset(<16 x i32>* %dest, <16 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16_quad_offset:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1, #32]!
; CHECK-NEXT:    vldrh.s32 q1, [r1, #8]
; CHECK-NEXT:    vldrh.s32 q2, [r1, #24]
; CHECK-NEXT:    vldrh.s32 q3, [r1, #16]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q2, [r0, #48]
; CHECK-NEXT:    vstrw.32 q1, [r0, #16]
; CHECK-NEXT:    vstrw.32 q3, [r0, #32]
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bx lr
entry:
  %z = getelementptr inbounds <16 x i16>, <16 x i16>* %src, i32 1
  %wide.load = load <16 x i16>, <16 x i16>* %z, align 2
  %0 = sext <16 x i16> %wide.load to <16 x i32>
  store <16 x i32> %0, <16 x i32>* %dest, align 4
  ret <16 x i16>* %z
}


define void @foo_int16_int32_align1(<4 x i16>* %dest, <4 x i32>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int16_int32_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vstrh.32 q0, [r1]
; CHECK-NEXT:    ldrd r1, r2, [sp]
; CHECK-NEXT:    str r1, [r0]
; CHECK-NEXT:    str r2, [r0, #4]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i32>, <4 x i32>* %src, align 4
  %0 = trunc <4 x i32> %wide.load to <4 x i16>
  store <4 x i16> %0, <4 x i16>* %dest, align 1
  ret void
}

define void @foo_int32_int16_align1(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_int32_int16_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    ldr r2, [r1]
; CHECK-NEXT:    ldr r1, [r1, #4]
; CHECK-NEXT:    strd r2, r1, [sp]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 1
  %0 = sext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}

define void @foo_uint32_uint16_align1(<4 x i32>* %dest, <4 x i16>* readonly %src, i32 %n) {
; CHECK-LABEL: foo_uint32_uint16_align1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .pad #8
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    ldr r2, [r1]
; CHECK-NEXT:    ldr r1, [r1, #4]
; CHECK-NEXT:    strd r2, r1, [sp]
; CHECK-NEXT:    mov r1, sp
; CHECK-NEXT:    vldrh.u32 q0, [r1]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    bx lr
entry:
  %wide.load = load <4 x i16>, <4 x i16>* %src, align 1
  %0 = zext <4 x i16> %wide.load to <4 x i32>
  store <4 x i32> %0, <4 x i32>* %dest, align 4
  ret void
}
