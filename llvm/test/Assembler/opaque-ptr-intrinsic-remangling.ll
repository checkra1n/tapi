; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -opaque-pointers < %s | FileCheck %s

; Make sure that opaque pointer intrinsic remangling upgrade works.

declare i32* @fake_personality_function()
declare void @func()

; Upgrading of invoked intrinsic.
define void @test_invoke(i32 addrspace(1)* %b) gc "statepoint-example" personality i32* ()* @fake_personality_function {
; CHECK-LABEL: @test_invoke(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = getelementptr i32, ptr addrspace(1) [[B:%.*]], i64 16
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = invoke token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(ptr addrspace(1) [[B]], ptr addrspace(1) [[B]], ptr addrspace(1) [[D]], ptr addrspace(1) [[D]]) ]
; CHECK-NEXT:    to label [[NORMAL_DEST:%.*]] unwind label [[UNWIND_DEST:%.*]]
; CHECK:       normal_dest:
; CHECK-NEXT:    ret void
; CHECK:       unwind_dest:
; CHECK-NEXT:    [[LPAD:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  to label %normal_dest unwind label %unwind_dest

normal_dest:
  ret void

unwind_dest:
  %lpad = landingpad token
  cleanup
  ret void
}

define i8* @test_ptr_annotation(i8* %p) {
; CHECK-LABEL: @test_ptr_annotation(
; CHECK-NEXT:    [[P2:%.*]] = call ptr @llvm.ptr.annotation.p0(ptr [[P:%.*]], ptr undef, ptr undef, i32 undef, ptr undef)
; CHECK-NEXT:    ret ptr [[P2]]
;
  %p2 = call i8* @llvm.ptr.annotation.p0i8(i8* %p, i8* undef, i8* undef, i32 undef, i8* undef)
  ret i8* %p2
}

declare token @llvm.experimental.gc.statepoint.p0f_isVoidf(i64, i32, void ()*, i32, i32, ...)
declare i8* @llvm.ptr.annotation.p0i8(i8*, i8*, i8*, i32, i8*)
