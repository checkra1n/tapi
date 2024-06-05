; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -memcpyopt -verify-memoryssa | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64"
target triple = "armv7-eabi"

%struct.qw = type { [4 x float] }
%struct.bar = type { %struct.qw, %struct.qw, %struct.qw, %struct.qw, %struct.qw, float, float}

; PR4882
define void @test1(ptr %this) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[STRUCT_BAR:%.*]], ptr [[THIS:%.*]], i32 0, i32 0, i32 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 0, i32 0, i32 2
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 0, i32 0, i32 3
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 1, i32 0, i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 1, i32 0, i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 1, i32 0, i32 2
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 1, i32 0, i32 3
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 3, i32 0, i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 3, i32 0, i32 2
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 3, i32 0, i32 3
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 4, i32 0, i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 4, i32 0, i32 1
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 4, i32 0, i32 2
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 4, i32 0, i32 3
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT_BAR]], ptr [[THIS]], i32 0, i32 5
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[THIS]], i8 0, i64 32, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[TMP7]], i8 0, i64 32, i1 false)
; CHECK-NEXT:    unreachable
;
entry:
  store float 0.000000e+00, ptr %this, align 4
  %0 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 0, i32 0, i32 1
  store float 0.000000e+00, ptr %0, align 4
  %1 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 0, i32 0, i32 2
  store float 0.000000e+00, ptr %1, align 4
  %2 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 0, i32 0, i32 3
  store float 0.000000e+00, ptr %2, align 4
  %3 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 1, i32 0, i32 0
  store float 0.000000e+00, ptr %3, align 4
  %4 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 1, i32 0, i32 1
  store float 0.000000e+00, ptr %4, align 4
  %5 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 1, i32 0, i32 2
  store float 0.000000e+00, ptr %5, align 4
  %6 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 1, i32 0, i32 3
  store float 0.000000e+00, ptr %6, align 4
  %7 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 3, i32 0, i32 1
  store float 0.000000e+00, ptr %7, align 4
  %8 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 3, i32 0, i32 2
  store float 0.000000e+00, ptr %8, align 4
  %9 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 3, i32 0, i32 3
  store float 0.000000e+00, ptr %9, align 4
  %10 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 4, i32 0, i32 0
  store float 0.000000e+00, ptr %10, align 4
  %11 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 4, i32 0, i32 1
  store float 0.000000e+00, ptr %11, align 4
  %12 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 4, i32 0, i32 2
  store float 0.000000e+00, ptr %12, align 4
  %13 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 4, i32 0, i32 3
  store float 0.000000e+00, ptr %13, align 4
  %14 = getelementptr inbounds %struct.bar, ptr %this, i32 0, i32 5
  store float 0.000000e+00, ptr %14, align 4
  unreachable
}

; PR8753

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind

define void @test2(i32 %cmd) nounwind {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr null, ptr undef, i64 20, i1 false) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr undef, ptr undef, i64 20, i1 false) nounwind
  call void @llvm.memcpy.p0.p0.i64(ptr null, ptr undef, i64 20, i1 false) nounwind
  ret void
}

; https://llvm.org/PR48075

@g = external global i16, align 1

define void @inttoptr_constexpr_crash(ptr %p) {
; CHECK-LABEL: @inttoptr_constexpr_crash(
; CHECK-NEXT:    store <1 x ptr> inttoptr (<1 x i16> bitcast (<2 x i8> <i8 ptrtoint (ptr @g to i8), i8 ptrtoint (ptr @g to i8)> to <1 x i16>) to <1 x ptr>), ptr [[P:%.*]], align 1
; CHECK-NEXT:    ret void
;
  store <1 x ptr> inttoptr (<1 x i16> bitcast (<2 x i8> <i8 ptrtoint (ptr @g to i8), i8 ptrtoint (ptr @g to i8)> to <1 x i16>) to <1 x ptr>), ptr %p, align 1
  ret void
}
