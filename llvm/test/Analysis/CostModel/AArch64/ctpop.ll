; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=aarch64 -passes="print<cost-model>" 2>&1 -disable-output | FileCheck %s

; Verify the cost of scalar ctpop instructions.

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define i64 @test_ctpop_i64(i64 %a) {
; CHECK-LABEL: 'test_ctpop_i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %ctpop = call i64 @llvm.ctpop.i64(i64 %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %ctpop
  %ctpop = call i64 @llvm.ctpop.i64(i64 %a)
  ret i64 %ctpop
}

define i32 @test_ctpop_i32(i32 %a) {
; CHECK-LABEL: 'test_ctpop_i32'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %ctpop = call i32 @llvm.ctpop.i32(i32 %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 %ctpop
  %ctpop = call i32 @llvm.ctpop.i32(i32 %a)
  ret i32 %ctpop
}

define i16 @test_ctpop_i16(i16 %a) {
; CHECK-LABEL: 'test_ctpop_i16'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %ctpop = call i16 @llvm.ctpop.i16(i16 %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i16 %ctpop
  %ctpop = call i16 @llvm.ctpop.i16(i16 %a)
  ret i16 %ctpop
}

define i8 @test_ctpop_i8(i8 %a) {
; CHECK-LABEL: 'test_ctpop_i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %ctpop = call i8 @llvm.ctpop.i8(i8 %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i8 %ctpop
  %ctpop = call i8 @llvm.ctpop.i8(i8 %a)
  ret i8 %ctpop
}

declare i64 @llvm.ctpop.i64(i64)
declare i32 @llvm.ctpop.i32(i32)
declare i16 @llvm.ctpop.i16(i16)
declare i8 @llvm.ctpop.i8(i8)

; Verify the cost of vector ctpop instructions.

define <2 x i64> @test_ctpop_v2i64(<2 x i64> %a) {
; CHECK-LABEL: 'test_ctpop_v2i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %ctpop = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <2 x i64> %ctpop
  %ctpop = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %a)
  ret <2 x i64> %ctpop
}

define <2 x i32> @test_ctpop_v2i32(<2 x i32> %a) {
; CHECK-LABEL: 'test_ctpop_v2i32'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %ctpop = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <2 x i32> %ctpop
  %ctpop = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %a)
  ret <2 x i32> %ctpop
}

define <4 x i32> @test_ctpop_v4i32(<4 x i32> %a) {
; CHECK-LABEL: 'test_ctpop_v4i32'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %ctpop = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <4 x i32> %ctpop
  %ctpop = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> %a)
  ret <4 x i32> %ctpop
}

define <2 x i16> @test_ctpop_v2i16(<2 x i16> %a) {
; CHECK-LABEL: 'test_ctpop_v2i16'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %ctpop = call <2 x i16> @llvm.ctpop.v2i16(<2 x i16> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <2 x i16> %ctpop
  %ctpop = call <2 x i16> @llvm.ctpop.v2i16(<2 x i16> %a)
  ret <2 x i16> %ctpop
}

define <4 x i16> @test_ctpop_v4i16(<4 x i16> %a) {
; CHECK-LABEL: 'test_ctpop_v4i16'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %ctpop = call <4 x i16> @llvm.ctpop.v4i16(<4 x i16> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <4 x i16> %ctpop
  %ctpop = call <4 x i16> @llvm.ctpop.v4i16(<4 x i16> %a)
  ret <4 x i16> %ctpop
}

define <8 x i16> @test_ctpop_v8i16(<8 x i16> %a) {
; CHECK-LABEL: 'test_ctpop_v8i16'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %ctpop = call <8 x i16> @llvm.ctpop.v8i16(<8 x i16> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i16> %ctpop
  %ctpop = call <8 x i16> @llvm.ctpop.v8i16(<8 x i16> %a)
  ret <8 x i16> %ctpop
}

define <2 x i8> @test_ctpop_v2i8(<2 x i8> %a) {
; CHECK-LABEL: 'test_ctpop_v2i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %ctpop = call <2 x i8> @llvm.ctpop.v2i8(<2 x i8> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <2 x i8> %ctpop
  %ctpop = call <2 x i8> @llvm.ctpop.v2i8(<2 x i8> %a)
  ret <2 x i8> %ctpop
}

define <4 x i8> @test_ctpop_v4i8(<4 x i8> %a) {
; CHECK-LABEL: 'test_ctpop_v4i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %ctpop = call <4 x i8> @llvm.ctpop.v4i8(<4 x i8> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <4 x i8> %ctpop
  %ctpop = call <4 x i8> @llvm.ctpop.v4i8(<4 x i8> %a)
  ret <4 x i8> %ctpop
}

define <8 x i8> @test_ctpop_v8i8(<8 x i8> %a) {
; CHECK-LABEL: 'test_ctpop_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %ctpop = call <8 x i8> @llvm.ctpop.v8i8(<8 x i8> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %ctpop
  %ctpop = call <8 x i8> @llvm.ctpop.v8i8(<8 x i8> %a)
  ret <8 x i8> %ctpop
}

define <16 x i8> @test_ctpop_v16i8(<16 x i8> %a) {
; CHECK-LABEL: 'test_ctpop_v16i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %ctpop = call <16 x i8> @llvm.ctpop.v16i8(<16 x i8> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <16 x i8> %ctpop
  %ctpop = call <16 x i8> @llvm.ctpop.v16i8(<16 x i8> %a)
  ret <16 x i8> %ctpop
}

define <4 x i64> @test_ctpop_v4i64(<4 x i64> %a) {
; CHECK-LABEL: 'test_ctpop_v4i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %ctpop = call <4 x i64> @llvm.ctpop.v4i64(<4 x i64> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <4 x i64> %ctpop
  %ctpop = call <4 x i64> @llvm.ctpop.v4i64(<4 x i64> %a)
  ret <4 x i64> %ctpop
}

define <8 x i32> @test_ctpop_v8i32(<8 x i32> %a) {
; CHECK-LABEL: 'test_ctpop_v8i32'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %ctpop = call <8 x i32> @llvm.ctpop.v8i32(<8 x i32> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i32> %ctpop
  %ctpop = call <8 x i32> @llvm.ctpop.v8i32(<8 x i32> %a)
  ret <8 x i32> %ctpop
}

define <16 x i16> @test_ctpop_v16i16(<16 x i16> %a) {
; CHECK-LABEL: 'test_ctpop_v16i16'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %ctpop = call <16 x i16> @llvm.ctpop.v16i16(<16 x i16> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <16 x i16> %ctpop
  %ctpop = call <16 x i16> @llvm.ctpop.v16i16(<16 x i16> %a)
  ret <16 x i16> %ctpop
}

define <32 x i8> @test_ctpop_v32i8(<32 x i8> %a) {
; CHECK-LABEL: 'test_ctpop_v32i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %ctpop = call <32 x i8> @llvm.ctpop.v32i8(<32 x i8> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <32 x i8> %ctpop
  %ctpop = call <32 x i8> @llvm.ctpop.v32i8(<32 x i8> %a)
  ret <32 x i8> %ctpop
}

define i64 @test_ctpop_noneon_i64(i64 %a) "target-features"="-fp-armv8,-neon" {
; CHECK-LABEL: 'test_ctpop_noneon_i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %ctpop = call i64 @llvm.ctpop.i64(i64 %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %ctpop
  %ctpop = call i64 @llvm.ctpop.i64(i64 %a)
  ret i64 %ctpop
}

define <2 x i64> @test_ctpop_noneon_v2i64(<2 x i64> %a) "target-features"="-fp-armv8,-neon" {
; CHECK-LABEL: 'test_ctpop_noneon_v2i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %ctpop = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %a)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <2 x i64> %ctpop
  %ctpop = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %a)
  ret <2 x i64> %ctpop
}

declare <2 x i64> @llvm.ctpop.v2i64(<2 x i64>)
declare <2 x i32> @llvm.ctpop.v2i32(<2 x i32>)
declare <4 x i32> @llvm.ctpop.v4i32(<4 x i32>)
declare <2 x i16> @llvm.ctpop.v2i16(<2 x i16>)
declare <4 x i16> @llvm.ctpop.v4i16(<4 x i16>)
declare <8 x i16> @llvm.ctpop.v8i16(<8 x i16>)
declare <2 x i8> @llvm.ctpop.v2i8(<2 x i8>)
declare <4 x i8> @llvm.ctpop.v4i8(<4 x i8>)
declare <8 x i8> @llvm.ctpop.v8i8(<8 x i8>)
declare <16 x i8> @llvm.ctpop.v16i8(<16 x i8>)

declare <4 x i64> @llvm.ctpop.v4i64(<4 x i64>)
declare <8 x i32> @llvm.ctpop.v8i32(<8 x i32>)
declare <16 x i16> @llvm.ctpop.v16i16(<16 x i16>)
declare <32 x i8> @llvm.ctpop.v32i8(<32 x i8>)
