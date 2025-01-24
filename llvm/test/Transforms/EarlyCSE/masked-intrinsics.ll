; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=early-cse < %s | FileCheck %s

define <128 x i8> @f0(ptr %a0, <128 x i8> %a1, <128 x i8> %a2) {
; CHECK-LABEL: @f0(
; CHECK-NEXT:    [[V0:%.*]] = icmp eq <128 x i8> [[A1:%.*]], [[A2:%.*]]
; CHECK-NEXT:    call void @llvm.masked.store.v128i8.p0(<128 x i8> [[A1]], ptr [[A0:%.*]], i32 4, <128 x i1> [[V0]])
; CHECK-NEXT:    ret <128 x i8> [[A1]]
;
  %v0 = icmp eq <128 x i8> %a1, %a2
  call void @llvm.masked.store.v128i8.p0(<128 x i8> %a1, ptr %a0, i32 4, <128 x i1> %v0)
  %v1 = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr %a0, i32 4, <128 x i1> %v0, <128 x i8> undef)
  ret <128 x i8> %v1
}

define <128 x i8> @f1(ptr %a0, <128 x i8> %a1, <128 x i8> %a2) {
; CHECK-LABEL: @f1(
; CHECK-NEXT:    [[V0:%.*]] = icmp eq <128 x i8> [[A1:%.*]], [[A2:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr [[A0:%.*]], i32 4, <128 x i1> [[V0]], <128 x i8> undef)
; CHECK-NEXT:    ret <128 x i8> [[V1]]
;
  %v0 = icmp eq <128 x i8> %a1, %a2
  %v1 = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr %a0, i32 4, <128 x i1> %v0, <128 x i8> undef)
  call void @llvm.masked.store.v128i8.p0(<128 x i8> %v1, ptr %a0, i32 4, <128 x i1> %v0)
  ret <128 x i8> %v1
}

define <128 x i8> @f2(ptr %a0, <128 x i8> %a1, <128 x i8> %a2) {
; CHECK-LABEL: @f2(
; CHECK-NEXT:    [[V0:%.*]] = icmp eq <128 x i8> [[A1:%.*]], [[A2:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr [[A0:%.*]], i32 4, <128 x i1> [[V0]], <128 x i8> undef)
; CHECK-NEXT:    [[V3:%.*]] = add <128 x i8> [[V1]], [[V1]]
; CHECK-NEXT:    ret <128 x i8> [[V3]]
;
  %v0 = icmp eq <128 x i8> %a1, %a2
  %v1 = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr %a0, i32 4, <128 x i1> %v0, <128 x i8> undef)
  %v2 = call <128 x i8> @llvm.masked.load.v128i8.p0(ptr %a0, i32 4, <128 x i1> %v0, <128 x i8> undef)
  %v3 = add <128 x i8> %v1, %v2
  ret <128 x i8> %v3
}

declare <128 x i8> @llvm.masked.load.v128i8.p0(ptr, i32, <128 x i1>, <128 x i8>)
declare void @llvm.masked.store.v128i8.p0(<128 x i8>, ptr, i32, <128 x i1>)
