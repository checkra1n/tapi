; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -tailcallelim -inline -instcombine -dse -S | FileCheck %s
; RUN: opt < %s -aa-pipeline=basic-aa -passes='function(tailcallelim),cgscc(inline,function(instcombine,dse))' -S | FileCheck %s
; PR7272

; Calls that capture byval parameters cannot be marked as tail calls. Other
; tails that don't capture byval parameters can still be tail calls.

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-pc-linux-gnu"

declare void @ext(i32*)

define void @bar(i32* byval(i32) %x) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:    call void @ext(i32* nonnull [[X:%.*]])
; CHECK-NEXT:    ret void
;
  call void @ext(i32* %x)
  ret void
}

define void @foo(i32* %x) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[X1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X:%.*]], align 1
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[X1]], align 4
; CHECK-NEXT:    call void @ext(i32* nonnull [[X1]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull [[TMP3]])
; CHECK-NEXT:    ret void
;
  call void @bar(i32* byval(i32) %x)
  ret void
}

define internal void @qux(i32* byval(i32) %x) {
  call void @ext(i32* %x)
  tail call void @ext(i32* null)
  ret void
}

define void @frob(i32* %x) {
; CHECK-LABEL: @frob(
; CHECK-NEXT:    [[X1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X:%.*]], align 1
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[X1]], align 4
; CHECK-NEXT:    call void @ext(i32* nonnull [[X1]])
; CHECK-NEXT:    tail call void @ext(i32* null)
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull [[TMP3]])
; CHECK-NEXT:    ret void
;
  tail call void @qux(i32* byval(i32) %x)
  ret void
}

; A byval parameter passed into a function which is passed out as byval does
; not block the call from being marked as tail.

declare void @ext2(i32* byval(i32))

define void @bar2(i32* byval(i32) %x) {
; CHECK-LABEL: @bar2(
; CHECK-NEXT:    tail call void @ext2(i32* nonnull byval(i32) [[X:%.*]])
; CHECK-NEXT:    ret void
;
  call void @ext2(i32* byval(i32) %x)
  ret void
}

define void @foobar(i32* %x) {
; CHECK-LABEL: @foobar(
; CHECK-NEXT:    [[X1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X:%.*]], align 1
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[X1]], align 4
; CHECK-NEXT:    tail call void @ext2(i32* nonnull byval(i32) [[X1]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull [[TMP3]])
; CHECK-NEXT:    ret void
;
  tail call void @bar2(i32* byval(i32) %x)
  ret void
}

define void @barfoo() {
; CHECK-LABEL: @barfoo(
; CHECK-NEXT:    [[X1:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull [[TMP1]])
; CHECK-NEXT:    tail call void @ext2(i32* nonnull byval(i32) [[X1]])
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[X1]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull [[TMP2]])
; CHECK-NEXT:    ret void
;
  %x = alloca i32
  tail call void @bar2(i32* byval(i32) %x)
  ret void
}
