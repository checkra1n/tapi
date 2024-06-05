; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -memcpyopt -S -verify-memoryssa | FileCheck %s
target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64"

%a = type { i32 }
%b = type { float }

declare void @g(ptr nocapture)

define float @f() {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_VAR:%.*]] = alloca [[A:%.*]], align 8
; CHECK-NEXT:    [[B_VAR:%.*]] = alloca [[B:%.*]], align 8
; CHECK-NEXT:    call void @g(ptr [[B_VAR]])
; CHECK-NEXT:    [[TMP2:%.*]] = load float, ptr [[B_VAR]], align 4
; CHECK-NEXT:    ret float [[TMP2]]
;
entry:
  %a_var = alloca %a
  %b_var = alloca %b, align 1
  call void @g(ptr %a_var)
  call void @llvm.memcpy.p0.p0.i32(ptr %b_var, ptr %a_var, i32 4, i1 false)
  %tmp2 = load float, ptr %b_var
  ret float %tmp2
}

declare void @llvm.memcpy.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind
