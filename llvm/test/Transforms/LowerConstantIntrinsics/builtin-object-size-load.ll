; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --instcombine -lower-constant-intrinsics -S < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare i64 @llvm.objectsize.i64.p0i8(i8*, i1 immarg, i1 immarg, i1 immarg)


define dso_local i64 @check_store_load(i1 %cond) local_unnamed_addr {
; CHECK-LABEL: @check_store_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR01:%.*]] = alloca [10 x i8], align 1
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[PTR01_SUB:%.*]] = getelementptr inbounds [10 x i8], [10 x i8]* [[PTR01]], i64 0, i64 0
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[PTR12:%.*]] = alloca [12 x i8], align 1
; CHECK-NEXT:    [[PTR12_SUB:%.*]] = getelementptr inbounds [12 x i8], [12 x i8]* [[PTR12]], i64 0, i64 0
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[STOREMERGE:%.*]] = phi i8* [ [[PTR12_SUB]], [[IF_END]] ], [ [[PTR01_SUB]], [[IF_THEN]] ]
; CHECK-NEXT:    ret i64 12
;
entry:
  %holder = alloca i8*
  %ptr0 = alloca i8, i64 10
  br i1 %cond, label %if.then, label %if.end

if.then:
  store i8* %ptr0, i8** %holder
  br label %return

if.end:
  %ptr1 = alloca i8, i64 12
  store i8* %ptr1, i8** %holder
  br label %return

return:
  %held = load i8*, i8** %holder
  %objsize = call i64 @llvm.objectsize.i64.p0i8(i8* %held, i1 false, i1 true, i1 false)
  ret i64 %objsize

}
