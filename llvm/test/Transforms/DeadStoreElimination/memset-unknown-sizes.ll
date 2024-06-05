; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -dse -S %s | FileCheck %s

declare ptr @_Znwm() local_unnamed_addr #0

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

define ptr @test1(i1 %c, i64 %N) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[COND_TRUE_I_I_I:%.*]], label [[COND_END_I_I_I:%.*]]
; CHECK:       cond.true.i.i.i:
; CHECK-NEXT:    ret ptr null
; CHECK:       cond.end.i.i.i:
; CHECK-NEXT:    [[ALLOC:%.*]] = tail call noalias nonnull ptr @_Znam() #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    tail call void @llvm.memset.p0.i64(ptr nonnull align 8 [[ALLOC]], i8 0, i64 [[N:%.*]], i1 false) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    store i64 0, ptr [[ALLOC]], align 8
; CHECK-NEXT:    ret ptr [[ALLOC]]
;
entry:
  br i1 %c, label %cond.true.i.i.i, label %cond.end.i.i.i

cond.true.i.i.i:                                  ; preds = %entry
  ret ptr null

cond.end.i.i.i:                                   ; preds = %entry
  %alloc = tail call noalias nonnull ptr @_Znam() #2
  tail call void @llvm.memset.p0.i64(ptr nonnull align 8 %alloc, i8 0, i64 %N, i1 false) #3
  store i64 0, ptr %alloc, align 8
  ret ptr %alloc
}

declare ptr @_Znam()


define ptr @test2(i1 %c, i64 %N) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[CLEANUP_CONT104:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[MUL:%.*]] = shl nuw nsw i64 [[N:%.*]], 3
; CHECK-NEXT:    [[ALLOC:%.*]] = call noalias nonnull ptr @_Znwm() #[[ATTR2]]
; CHECK-NEXT:    store i64 0, ptr [[ALLOC]], align 8
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr nonnull align 8 [[ALLOC]], i8 0, i64 [[MUL]], i1 false) #[[ATTR3]]
; CHECK-NEXT:    ret ptr [[ALLOC]]
; CHECK:       cleanup.cont104:
; CHECK-NEXT:    ret ptr null
;
entry:
  br i1 %c, label %cleanup.cont104, label %if.then

if.then:                                          ; preds = %entry
  %mul = shl nuw nsw i64 %N, 3
  %alloc = call noalias nonnull ptr @_Znwm() #2
  store i64 0, ptr %alloc, align 8
  call void @llvm.memset.p0.i64(ptr nonnull align 8 %alloc, i8 0, i64 %mul, i1 false) #3
  ret ptr %alloc

cleanup.cont104:                                  ; preds = %entry
  ret ptr null
}

attributes #0 = { "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn writeonly }
attributes #2 = { builtin nounwind }
attributes #3 = { nounwind }
