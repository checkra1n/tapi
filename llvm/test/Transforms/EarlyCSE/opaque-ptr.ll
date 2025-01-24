; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=early-cse < %s | FileCheck %s

define i32 @different_types_load(ptr %p) {
; CHECK-LABEL: @different_types_load(
; CHECK-NEXT:    [[V1:%.*]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[V2:%.*]] = load i64, ptr [[P]], align 4
; CHECK-NEXT:    [[V2_C:%.*]] = trunc i64 [[V2]] to i32
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[V1]], [[V2_C]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %v1 = load i32, ptr %p
  %v2 = load i64, ptr %p
  %v2.c = trunc i64 %v2 to i32
  %sub = sub i32 %v1, %v2.c
  ret i32 %sub
}

define i32 @different_types_vector_load(ptr %p) {
; CHECK-LABEL: @different_types_vector_load(
; CHECK-NEXT:    [[V1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[P:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 false>, <4 x i32> poison)
; CHECK-NEXT:    [[V2:%.*]] = call <8 x i32> @llvm.masked.load.v8i32.p0(ptr [[P]], i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 false, i1 false, i1 false, i1 false>, <8 x i32> poison)
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x i32> [[V1]], i32 0
; CHECK-NEXT:    [[E2:%.*]] = extractelement <8 x i32> [[V2]], i32 6
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[E1]], [[E2]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %v1 = call <4 x i32> @llvm.masked.load.v4i32.p(ptr %p, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 false>, <4 x i32> poison)
  %v2 = call <8 x i32> @llvm.masked.load.v8i32.p(ptr %p, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 false, i1 false, i1 false, i1 false>, <8 x i32> poison)
  %e1 = extractelement <4 x i32> %v1, i32 0
  %e2 = extractelement <8 x i32> %v2, i32 6
  %sum = add i32 %e1, %e2
  ret i32 %sum
}

define i32 @different_types_store(ptr %p, i32 %a) {
; CHECK-LABEL: @different_types_store(
; CHECK-NEXT:    store i32 [[A:%.*]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[V2:%.*]] = load i64, ptr [[P]], align 4
; CHECK-NEXT:    [[V2_C:%.*]] = trunc i64 [[V2]] to i32
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[A]], [[V2_C]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  store i32 %a, ptr %p
  %v2 = load i64, ptr %p
  %v2.c = trunc i64 %v2 to i32
  %sub = sub i32 %a, %v2.c
  ret i32 %sub
}

define i32 @different_elt_types_vector_load(ptr %p, <4 x i1> %c) {
; CHECK-LABEL: @different_elt_types_vector_load(
; CHECK-NEXT:    [[V1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[P:%.*]], i32 4, <4 x i1> [[C:%.*]], <4 x i32> poison)
; CHECK-NEXT:    [[V2:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[P]], i32 4, <4 x i1> [[C]], <4 x float> poison)
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x i32> [[V1]], i32 0
; CHECK-NEXT:    [[E2:%.*]] = extractelement <4 x float> [[V2]], i32 0
; CHECK-NEXT:    [[E2I:%.*]] = fptosi float [[E2]] to i32
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[E1]], [[E2I]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %v1 = call <4 x i32> @llvm.masked.load.v4i32.p(ptr %p, i32 4, <4 x i1> %c, <4 x i32> poison)
  %v2 = call <4 x float> @llvm.masked.load.v4f32.p(ptr %p, i32 4, <4 x i1> %c, <4 x float> poison)
  %e1 = extractelement <4 x i32> %v1, i32 0
  %e2 = extractelement <4 x float> %v2, i32 0
  %e2i = fptosi float %e2 to i32
  %sum = add i32 %e1, %e2i
  ret i32 %sum
}

define float @different_elt_types_vector_store_load(ptr %p, <4 x i32> %v1, <4 x i1> %c) {
; CHECK-LABEL: @different_elt_types_vector_store_load(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0(<4 x i32> [[V1:%.*]], ptr [[P:%.*]], i32 4, <4 x i1> [[C:%.*]])
; CHECK-NEXT:    [[V2:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[P]], i32 4, <4 x i1> [[C]], <4 x float> poison)
; CHECK-NEXT:    [[E2:%.*]] = extractelement <4 x float> [[V2]], i32 0
; CHECK-NEXT:    ret float [[E2]]
;
  call void @llvm.masked.store.v4i32.p(<4 x i32> %v1, ptr %p, i32 4, <4 x i1> %c)
  %v2 = call <4 x float> @llvm.masked.load.v4f32.p(ptr %p, i32 4, <4 x i1> %c, <4 x float> poison)
  %e2 = extractelement <4 x float> %v2, i32 0
  ret float %e2
}

define void @dse(ptr %p, i32 %i1, i8 %i2) {
; CHECK-LABEL: @dse(
; CHECK-NEXT:    store i32 [[I1:%.*]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    store i8 [[I2:%.*]], ptr [[P]], align 1
; CHECK-NEXT:    ret void
;
  store i32 %i1, ptr %p
  store i8 %i2, ptr %p
  ret void
}

declare <4 x i32> @llvm.masked.load.v4i32.p(ptr, i32 immarg, <4 x i1>, <4 x i32>)
declare <8 x i32> @llvm.masked.load.v8i32.p(ptr, i32 immarg, <8 x i1>, <8 x i32>)
declare <4 x float> @llvm.masked.load.v4f32.p(ptr, i32 immarg, <4 x i1>, <4 x float>)
declare void @llvm.masked.store.v4i32.p(<4 x i32>, ptr, i32 immarg, <4 x i1>)
