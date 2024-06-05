; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -memcpyopt -S -verify-memoryssa | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

define void @foo(ptr nocapture %P) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i16, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i16, ptr [[P:%.*]], i64 3
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 2 [[P:%.*]], i8 0, i64 8, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx = getelementptr inbounds i16, ptr %P, i64 1
  %arrayidx1 = getelementptr inbounds i16, ptr %P, i64 3
  store i16 0, ptr %P, align 2
  store i32 0, ptr %arrayidx, align 4
  store i16 0, ptr %arrayidx1, align 2
  ret void
}

