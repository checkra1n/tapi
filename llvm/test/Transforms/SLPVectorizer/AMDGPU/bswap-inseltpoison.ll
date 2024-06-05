; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX7 %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX8 %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX8 %s

define <2 x i16> @bswap_v2i16(<2 x i16> %arg) {
; GFX7-LABEL: @bswap_v2i16(
; GFX7-NEXT:  bb:
; GFX7-NEXT:    [[T:%.*]] = extractelement <2 x i16> [[ARG:%.*]], i64 0
; GFX7-NEXT:    [[T1:%.*]] = tail call i16 @llvm.bswap.i16(i16 [[T]])
; GFX7-NEXT:    [[T2:%.*]] = insertelement <2 x i16> poison, i16 [[T1]], i64 0
; GFX7-NEXT:    [[T3:%.*]] = extractelement <2 x i16> [[ARG]], i64 1
; GFX7-NEXT:    [[T4:%.*]] = tail call i16 @llvm.bswap.i16(i16 [[T3]])
; GFX7-NEXT:    [[T5:%.*]] = insertelement <2 x i16> [[T2]], i16 [[T4]], i64 1
; GFX7-NEXT:    ret <2 x i16> [[T5]]
;
; GFX8-LABEL: @bswap_v2i16(
; GFX8-NEXT:  bb:
; GFX8-NEXT:    [[TMP0:%.*]] = call <2 x i16> @llvm.bswap.v2i16(<2 x i16> [[ARG:%.*]])
; GFX8-NEXT:    ret <2 x i16> [[TMP0]]
;
bb:
  %t = extractelement <2 x i16> %arg, i64 0
  %t1 = tail call i16 @llvm.bswap.i16(i16 %t)
  %t2 = insertelement <2 x i16> poison, i16 %t1, i64 0
  %t3 = extractelement <2 x i16> %arg, i64 1
  %t4 = tail call i16 @llvm.bswap.i16(i16 %t3)
  %t5 = insertelement <2 x i16> %t2, i16 %t4, i64 1
  ret <2 x i16> %t5
}

define <2 x i32> @bswap_v2i32(<2 x i32> %arg) {
; GCN-LABEL: @bswap_v2i32(
; GCN-NEXT:  bb:
; GCN-NEXT:    [[T:%.*]] = extractelement <2 x i32> [[ARG:%.*]], i64 0
; GCN-NEXT:    [[T1:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[T]])
; GCN-NEXT:    [[T2:%.*]] = insertelement <2 x i32> poison, i32 [[T1]], i64 0
; GCN-NEXT:    [[T3:%.*]] = extractelement <2 x i32> [[ARG]], i64 1
; GCN-NEXT:    [[T4:%.*]] = tail call i32 @llvm.bswap.i32(i32 [[T3]])
; GCN-NEXT:    [[T5:%.*]] = insertelement <2 x i32> [[T2]], i32 [[T4]], i64 1
; GCN-NEXT:    ret <2 x i32> [[T5]]
;
bb:
  %t = extractelement <2 x i32> %arg, i64 0
  %t1 = tail call i32 @llvm.bswap.i32(i32 %t)
  %t2 = insertelement <2 x i32> poison, i32 %t1, i64 0
  %t3 = extractelement <2 x i32> %arg, i64 1
  %t4 = tail call i32 @llvm.bswap.i32(i32 %t3)
  %t5 = insertelement <2 x i32> %t2, i32 %t4, i64 1
  ret <2 x i32> %t5
}

declare i16 @llvm.bswap.i16(i16) #0
declare i32 @llvm.bswap.i32(i32) #0

attributes #0 = { nounwind readnone speculatable willreturn }
