; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=aarch64 -type-promotion -verify -S %s -o - | FileCheck %s
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

; Function Attrs: mustprogress nofree nosync nounwind uwtable
define dso_local void @foo(ptr noundef %ptr0, ptr nocapture noundef readonly %ptr1, ptr nocapture noundef %dest) local_unnamed_addr {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[PTR0:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i64
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[TO_PROMOTE:%.*]] = phi i64 [ [[TMP1]], [[ENTRY:%.*]] ], [ [[TMP4:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, ptr [[PTR1:%.*]], i64 [[TO_PROMOTE]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i8, ptr [[ARRAYIDX1]], align 2
; CHECK-NEXT:    [[TMP3:%.*]] = zext i8 [[TMP2]] to i64
; CHECK-NEXT:    [[COND_IN_I:%.*]] = getelementptr inbounds i8, ptr [[PTR1]], i64 [[TMP3]]
; CHECK-NEXT:    [[COND_I:%.*]] = load i8, ptr [[COND_IN_I]], align 1
; CHECK-NEXT:    [[TMP4]] = zext i8 [[COND_I]] to i64
; CHECK-NEXT:    store i8 [[TMP2]], ptr [[DEST:%.*]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[TMP4]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i8, ptr %ptr0, align 1
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %to_promote = phi i8 [ %0, %entry ], [ %cond.i, %do.body ]
  %ext0 = zext i8 %to_promote to i64
  %arrayidx1 = getelementptr inbounds i8, ptr %ptr1, i64 %ext0
  %1 = load i8, ptr %arrayidx1, align 2
  %2 = zext i8 %1 to i64
  %cond.in.i = getelementptr inbounds i8, ptr %ptr1, i64 %2
  %cond.i = load i8, ptr %cond.in.i, align 1
  store i8 %1, ptr %dest, align 1
  %cmp = icmp ult i8 %cond.i, 0
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}
