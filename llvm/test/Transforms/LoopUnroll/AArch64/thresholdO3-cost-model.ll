; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-unroll -unroll-threshold=300 -S %s | FileCheck %s

; This test was full unrolled and simplified at -O3 with clang 11.
; Changes to the cost model may cause that decision to differ.
; We would not necessarily view the difference as a regression,
; but we should be aware that cost model changes can affect an
; example like this drastically.

target datalayout = "e-m:w-p:64:64-i32:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-w64-windows-gnu"

@tab_log2 = internal unnamed_addr constant [33 x i16] [i16 4, i16 1459, i16 2870, i16 4240, i16 5572, i16 6867, i16 8127, i16 9355, i16 10552, i16 11719, i16 12858, i16 13971, i16 15057, i16 16120, i16 17158, i16 18175, i16 19170, i16 20145, i16 21100, i16 22036, i16 22954, i16 23854, i16 24738, i16 25605, i16 26457, i16 27294, i16 28116, i16 28924, i16 29719, i16 30500, i16 31269, i16 32025, i16 -32767], align 2

declare i32 @llvm.ctlz.i32(i32, i1 immarg)
declare double @llvm.log2.f64(double)

define i32 @tripcount_11() {
; CHECK-LABEL: @tripcount_11(
; CHECK-NEXT:  do.body6.preheader:
; CHECK-NEXT:    br label [[DO_BODY6:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_1:%.*]], label [[IF_THEN11:%.*]]
; CHECK:       for.cond.1:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_2:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.2:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_3:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.3:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_4:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.4:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_5:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.5:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_6:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.6:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_7:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.7:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_8:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.8:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_9:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.9:
; CHECK-NEXT:    br i1 true, label [[FOR_COND_10:%.*]], label [[IF_THEN11]]
; CHECK:       for.cond.10:
; CHECK-NEXT:    ret i32 0
; CHECK:       do.body6:
; CHECK-NEXT:    br i1 true, label [[FOR_COND:%.*]], label [[IF_THEN11]]
; CHECK:       if.then11:
; CHECK-NEXT:    unreachable
;
do.body6.preheader:
  br label %do.body6

for.cond:
  %cmp5.not = icmp eq i32 %div20, 0
  br i1 %cmp5.not, label %for.end, label %do.body6

do.body6:
  %i.021 = phi i32 [ %div20, %for.cond ], [ 1024, %do.body6.preheader ]
  %or.i = or i32 %i.021, 1
  %t0 = tail call i32 @llvm.ctlz.i32(i32 %or.i, i1 true)
  %shl.i = shl i32 %i.021, %t0
  %and.i = lshr i32 %shl.i, 26
  %t1 = trunc i32 %and.i to i8
  %conv3.i = and i8 %t1, 31
  %and4.i = lshr i32 %shl.i, 11
  %conv6.i = and i32 %and4.i, 32767
  %idxprom.i = zext i8 %conv3.i to i64
  %arrayidx.i7 = getelementptr inbounds [33 x i16], ptr @tab_log2, i64 0, i64 %idxprom.i
  %t2 = load i16, ptr %arrayidx.i7, align 2
  %conv7.i = zext i16 %t2 to i32
  %narrow.i = add nuw nsw i8 %conv3.i, 1
  %t3 = zext i8 %narrow.i to i64
  %arrayidx11.i = getelementptr inbounds [33 x i16], ptr @tab_log2, i64 0, i64 %t3
  %t4 = load i16, ptr %arrayidx11.i, align 2
  %conv12.i = zext i16 %t4 to i32
  %sub16.i = sub nsw i32 %conv12.i, %conv7.i
  %mul.i8 = mul nsw i32 %conv6.i, %sub16.i
  %shr17.i = ashr i32 %mul.i8, 15
  %conv.i = shl nuw nsw i32 %t0, 15
  %shl20.i = xor i32 %conv.i, 1015808
  %add18.i = add nuw nsw i32 %shl20.i, %conv7.i
  %add21.i = add nsw i32 %add18.i, %shr17.i
  %conv = sitofp i32 %i.021 to double
  %t5 = tail call double @llvm.log2.f64(double %conv)
  %conv8 = fptosi double %t5 to i32
  %mul = shl nsw i32 %conv8, 15
  %add = or i32 %mul, 4
  %cmp9 = icmp eq i32 %add21.i, %add
  %div20 = lshr i32 %i.021, 1
  br i1 %cmp9, label %for.cond, label %if.then11

if.then11:
  unreachable

for.end:
  ret i32 0
}
