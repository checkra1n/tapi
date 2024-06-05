; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -memcpyopt -instcombine -S < %s -verify-memoryssa | FileCheck %s

target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @foo(ptr noalias nocapture sret([8 x i64]) dereferenceable(64) %sret) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry-block:
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) [[SRET:%.*]], i8 0, i64 64, i1 false)
; CHECK-NEXT:    ret void
;
entry-block:
  %a = alloca [8 x i64], align 8
  call void @llvm.lifetime.start.p0(i64 64, ptr %a)
  call void @llvm.memset.p0.i64(ptr align 8 %a, i8 0, i64 64, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %sret, ptr align 8 %a, i64 64, i1 false)
  call void @llvm.lifetime.end.p0(i64 64, ptr %a)
  ret void

}

define void @bar(ptr noalias nocapture sret([8 x i64]) dereferenceable(64) %sret, ptr noalias nocapture dereferenceable(64) %out) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry-block:
; CHECK-NEXT:    [[A:%.*]] = alloca [8 x i64], align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 64, ptr nonnull [[A]])
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) [[A]], i8 0, i64 64, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) [[SRET:%.*]], i8 0, i64 64, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) [[A]], i8 42, i64 32, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) [[OUT:%.*]], ptr noundef nonnull align 8 dereferenceable(64) [[A]], i64 64, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 64, ptr nonnull [[A]])
; CHECK-NEXT:    ret void
;
entry-block:
  %a = alloca [8 x i64], align 8
  call void @llvm.lifetime.start.p0(i64 64, ptr %a)
  call void @llvm.memset.p0.i64(ptr align 8 %a, i8 0, i64 64, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %sret, ptr align 8 %a, i64 64, i1 false)
  call void @llvm.memset.p0.i64(ptr align 8 %a, i8 42, i64 32, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %out, ptr align 8 %a, i64 64, i1 false)
  call void @llvm.lifetime.end.p0(i64 64, ptr %a)
  ret void

}

declare void @llvm.lifetime.start.p0(i64, ptr nocapture) nounwind
declare void @llvm.lifetime.end.p0(i64, ptr nocapture) nounwind

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture readonly, i64, i1) nounwind
declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
