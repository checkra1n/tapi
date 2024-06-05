; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=arm64-apple-macosx11.0.0 -slp-vectorizer -S < %s | FileCheck %s

; Test case reported on D134605 where the vectorization was causing a slowdown due to an underestimation in the cost of the extractions.

define fastcc i64 @zot(float %arg, float %arg1, float %arg2, float %arg3, float %arg4, ptr %arg5, i1 %arg6, i1 %arg7, i1 %arg8) {
; CHECK-LABEL: @zot(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[VAL:%.*]] = fmul fast float 0.000000e+00, 0.000000e+00
; CHECK-NEXT:    [[VAL9:%.*]] = fmul fast float 0.000000e+00, [[ARG:%.*]]
; CHECK-NEXT:    [[VAL10:%.*]] = fmul fast float [[ARG3:%.*]], 1.000000e+00
; CHECK-NEXT:    [[VAL11:%.*]] = fmul fast float [[ARG3]], 1.000000e+00
; CHECK-NEXT:    [[VAL12:%.*]] = fadd fast float [[ARG3]], 1.000000e+00
; CHECK-NEXT:    [[VAL13:%.*]] = fadd fast float [[VAL12]], 2.000000e+00
; CHECK-NEXT:    [[VAL14:%.*]] = fadd fast float 0.000000e+00, 0.000000e+00
; CHECK-NEXT:    [[VAL15:%.*]] = fadd fast float [[VAL14]], 1.000000e+00
; CHECK-NEXT:    [[VAL16:%.*]] = fadd fast float [[ARG3]], 1.000000e+00
; CHECK-NEXT:    [[VAL17:%.*]] = fadd fast float [[ARG3]], 1.000000e+00
; CHECK-NEXT:    br i1 [[ARG6:%.*]], label [[BB18:%.*]], label [[BB57:%.*]]
; CHECK:       bb18:
; CHECK-NEXT:    [[VAL19:%.*]] = phi float [ [[VAL13]], [[BB:%.*]] ]
; CHECK-NEXT:    [[VAL20:%.*]] = phi float [ [[VAL15]], [[BB]] ]
; CHECK-NEXT:    [[VAL21:%.*]] = phi float [ [[VAL16]], [[BB]] ]
; CHECK-NEXT:    [[VAL22:%.*]] = phi float [ [[VAL17]], [[BB]] ]
; CHECK-NEXT:    [[VAL23:%.*]] = fmul fast float [[VAL16]], 2.000000e+00
; CHECK-NEXT:    [[VAL24:%.*]] = fmul fast float [[VAL17]], 3.000000e+00
; CHECK-NEXT:    br i1 [[ARG7:%.*]], label [[BB25:%.*]], label [[BB57]]
; CHECK:       bb25:
; CHECK-NEXT:    [[VAL26:%.*]] = phi float [ [[VAL19]], [[BB18]] ]
; CHECK-NEXT:    [[VAL27:%.*]] = phi float [ [[VAL20]], [[BB18]] ]
; CHECK-NEXT:    [[VAL28:%.*]] = phi float [ [[VAL21]], [[BB18]] ]
; CHECK-NEXT:    [[VAL29:%.*]] = phi float [ [[VAL22]], [[BB18]] ]
; CHECK-NEXT:    br label [[BB30:%.*]]
; CHECK:       bb30:
; CHECK-NEXT:    [[VAL31:%.*]] = phi float [ [[VAL55:%.*]], [[BB30]] ], [ 0.000000e+00, [[BB25]] ]
; CHECK-NEXT:    [[VAL32:%.*]] = phi float [ [[VAL9]], [[BB30]] ], [ 0.000000e+00, [[BB25]] ]
; CHECK-NEXT:    [[VAL33:%.*]] = load i8, ptr [[ARG5:%.*]], align 1
; CHECK-NEXT:    [[VAL34:%.*]] = uitofp i8 [[VAL33]] to float
; CHECK-NEXT:    [[VAL35:%.*]] = getelementptr inbounds i8, ptr [[ARG5]], i64 1
; CHECK-NEXT:    [[VAL36:%.*]] = load i8, ptr [[VAL35]], align 1
; CHECK-NEXT:    [[VAL37:%.*]] = uitofp i8 [[VAL36]] to float
; CHECK-NEXT:    [[VAL38:%.*]] = getelementptr inbounds i8, ptr [[ARG5]], i64 2
; CHECK-NEXT:    [[VAL39:%.*]] = load i8, ptr [[VAL38]], align 1
; CHECK-NEXT:    [[VAL40:%.*]] = uitofp i8 [[VAL39]] to float
; CHECK-NEXT:    [[VAL41:%.*]] = getelementptr inbounds i8, ptr [[ARG5]], i64 3
; CHECK-NEXT:    [[VAL42:%.*]] = load i8, ptr [[VAL41]], align 1
; CHECK-NEXT:    [[VAL43:%.*]] = uitofp i8 [[VAL42]] to float
; CHECK-NEXT:    [[VAL44:%.*]] = fsub fast float [[VAL34]], [[VAL]]
; CHECK-NEXT:    [[VAL45:%.*]] = fsub fast float [[VAL37]], [[VAL9]]
; CHECK-NEXT:    [[VAL46:%.*]] = fsub fast float [[VAL40]], [[VAL10]]
; CHECK-NEXT:    [[VAL47:%.*]] = fsub fast float [[VAL43]], [[VAL11]]
; CHECK-NEXT:    [[VAL48:%.*]] = fmul fast float [[VAL44]], [[VAL26]]
; CHECK-NEXT:    [[VAL49:%.*]] = fmul fast float [[VAL45]], [[VAL27]]
; CHECK-NEXT:    [[VAL50:%.*]] = fadd fast float [[VAL49]], [[VAL48]]
; CHECK-NEXT:    [[VAL51:%.*]] = fmul fast float [[VAL46]], [[VAL28]]
; CHECK-NEXT:    [[VAL52:%.*]] = fadd fast float [[VAL50]], [[VAL51]]
; CHECK-NEXT:    [[VAL53:%.*]] = fmul fast float [[VAL47]], [[VAL29]]
; CHECK-NEXT:    [[VAL54:%.*]] = fadd fast float [[VAL52]], [[VAL53]]
; CHECK-NEXT:    [[VAL55]] = tail call fast float @llvm.minnum.f32(float [[VAL31]], float [[ARG1:%.*]])
; CHECK-NEXT:    [[VAL56:%.*]] = tail call fast float @llvm.maxnum.f32(float [[ARG2:%.*]], float [[VAL54]])
; CHECK-NEXT:    call void @ham(float [[VAL55]], float [[VAL56]])
; CHECK-NEXT:    br i1 [[ARG8:%.*]], label [[BB30]], label [[BB57]]
; CHECK:       bb57:
; CHECK-NEXT:    ret i64 0
;
bb:
  %val = fmul fast float 0.000000e+00, 0.000000e+00
  %val9 = fmul fast float 0.000000e+00, %arg
  %val10 = fmul fast float %arg3, 1.000000e+00
  %val11 = fmul fast float %arg3, 1.000000e+00
  %val12 = fadd fast float %arg3, 1.000000e+00
  %val13 = fadd fast float %val12, 2.000000e+00
  %val14 = fadd fast float 0.000000e+00, 0.000000e+00
  %val15 = fadd fast float %val14, 1.000000e+00
  %val16 = fadd fast float %arg3, 1.000000e+00
  %val17 = fadd fast float %arg3, 1.000000e+00
  br i1 %arg6, label %bb18, label %bb57

bb18:                                             ; preds = %bb
  %val19 = phi float [ %val13, %bb ]
  %val20 = phi float [ %val15, %bb ]
  %val21 = phi float [ %val16, %bb ]
  %val22 = phi float [ %val17, %bb ]
  %val23 = fmul fast float %val16, 2.000000e+00
  %val24 = fmul fast float %val17, 3.000000e+00
  br i1 %arg7, label %bb25, label %bb57

bb25:                                             ; preds = %bb18
  %val26 = phi float [ %val19, %bb18 ]
  %val27 = phi float [ %val20, %bb18 ]
  %val28 = phi float [ %val21, %bb18 ]
  %val29 = phi float [ %val22, %bb18 ]
  br label %bb30

bb30:                                             ; preds = %bb30, %bb25
  %val31 = phi float [ %val55, %bb30 ], [ 0.000000e+00, %bb25 ]
  %val32 = phi float [ %val9, %bb30 ], [ 0.000000e+00, %bb25 ]
  %val33 = load i8, ptr %arg5, align 1
  %val34 = uitofp i8 %val33 to float
  %val35 = getelementptr inbounds i8, ptr %arg5, i64 1
  %val36 = load i8, ptr %val35, align 1
  %val37 = uitofp i8 %val36 to float
  %val38 = getelementptr inbounds i8, ptr %arg5, i64 2
  %val39 = load i8, ptr %val38, align 1
  %val40 = uitofp i8 %val39 to float
  %val41 = getelementptr inbounds i8, ptr %arg5, i64 3
  %val42 = load i8, ptr %val41, align 1
  %val43 = uitofp i8 %val42 to float
  %val44 = fsub fast float %val34, %val
  %val45 = fsub fast float %val37, %val9
  %val46 = fsub fast float %val40, %val10
  %val47 = fsub fast float %val43, %val11
  %val48 = fmul fast float %val44, %val26
  %val49 = fmul fast float %val45, %val27
  %val50 = fadd fast float %val49, %val48
  %val51 = fmul fast float %val46, %val28
  %val52 = fadd fast float %val50, %val51
  %val53 = fmul fast float %val47, %val29
  %val54 = fadd fast float %val52, %val53
  %val55 = tail call fast float @llvm.minnum.f32(float %val31, float %arg1)
  %val56 = tail call fast float @llvm.maxnum.f32(float %arg2, float %val54)
  call void @ham(float %val55, float %val56)
  br i1 %arg8, label %bb30, label %bb57

bb57:                                             ; preds = %bb30, %bb18, %bb
  ret i64 0
}

declare float @llvm.maxnum.f32(float, float)
declare float @llvm.minnum.f32(float, float)
declare void @ham(float, float)