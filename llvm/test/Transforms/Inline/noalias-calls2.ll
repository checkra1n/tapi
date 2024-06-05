; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -inline -enable-noalias-to-md-conversion -S < %s | FileCheck %s
; RUN: opt -aa-pipeline=basic-aa -passes=inline -enable-noalias-to-md-conversion -S < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @llvm.experimental.noalias.scope.decl(metadata) #0

define void @caller_equals_callee(i32* noalias %p0, i32* noalias %p1, i32 %cnt) {
; CHECK-LABEL: define {{[^@]+}}@caller_equals_callee
; CHECK-SAME: (i32* noalias [[P0:%.*]], i32* noalias [[P1:%.*]], i32 [[CNT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, i32* [[P0]], i64 2
; CHECK-NEXT:    [[ADD_PTR1:%.*]] = getelementptr inbounds i32, i32* [[P1]], i64 2
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl(metadata !0)
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl(metadata !3)
; CHECK-NEXT:    store i32 10, i32* [[ADD_PTR]], align 4, !alias.scope !0, !noalias !3
; CHECK-NEXT:    store i32 20, i32* [[ADD_PTR1]], align 4, !alias.scope !3, !noalias !0
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[CNT]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i32 11, i32* [[P0]], align 4
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[ADD_PTR2:%.*]] = getelementptr inbounds i32, i32* [[P1]], i64 1
; CHECK-NEXT:    [[ADD_PTR3:%.*]] = getelementptr inbounds i32, i32* [[P0]], i64 1
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !5)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !8)
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR2]], i64 2
; CHECK-NEXT:    [[ADD_PTR1_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR3]], i64 2
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl(metadata !10)
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl(metadata !13)
; CHECK-NEXT:    store i32 10, i32* [[ADD_PTR_I]], align 4, !alias.scope !15, !noalias !16
; CHECK-NEXT:    store i32 20, i32* [[ADD_PTR1_I]], align 4, !alias.scope !16, !noalias !15
; CHECK-NEXT:    store i32 11, i32* [[ADD_PTR2]], align 4, !alias.scope !5, !noalias !8
; CHECK-NEXT:    store i32 12, i32* [[P1]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr = getelementptr inbounds i32, i32* %p0, i64 2
  %add.ptr1 = getelementptr inbounds i32, i32* %p1, i64 2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !0)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !3)
  store i32 10, i32* %add.ptr, align 4, !alias.scope !0, !noalias !3
  store i32 20, i32* %add.ptr1, align 4, !alias.scope !3, !noalias !0
  %cmp = icmp eq i32 %cnt, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 11, i32* %p0, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %add.ptr2 = getelementptr inbounds i32, i32* %p1, i64 1
  %add.ptr3 = getelementptr inbounds i32, i32* %p0, i64 1
  tail call void @caller_equals_callee(i32* nonnull %add.ptr2, i32* nonnull %add.ptr3, i32 0)
  store i32 12, i32* %p1, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

define void @test01(i32* noalias %p0, i32* noalias %p1, i32 %cnt) {
; CHECK-LABEL: define {{[^@]+}}@test01
; CHECK-SAME: (i32* noalias [[P0:%.*]], i32* noalias [[P1:%.*]], i32 [[CNT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 13, i32* [[P0]], align 4
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, i32* [[P0]], i64 1
; CHECK-NEXT:    [[ADD_PTR1:%.*]] = getelementptr inbounds i32, i32* [[P1]], i64 1
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !17)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !20)
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR]], i64 2
; CHECK-NEXT:    [[ADD_PTR1_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR1]], i64 2
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !22)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !25)
; CHECK-NEXT:    store i32 10, i32* [[ADD_PTR_I]], align 4, !alias.scope !27, !noalias !28
; CHECK-NEXT:    store i32 20, i32* [[ADD_PTR1_I]], align 4, !alias.scope !28, !noalias !27
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp eq i32 [[CNT]], 0
; CHECK-NEXT:    br i1 [[CMP_I]], label [[IF_THEN_I:%.*]], label [[IF_ELSE_I:%.*]]
; CHECK:       if.then.i:
; CHECK-NEXT:    store i32 11, i32* [[ADD_PTR]], align 4, !alias.scope !17, !noalias !20
; CHECK-NEXT:    br label [[CALLER_EQUALS_CALLEE_EXIT:%.*]]
; CHECK:       if.else.i:
; CHECK-NEXT:    [[ADD_PTR2_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR1]], i64 1
; CHECK-NEXT:    [[ADD_PTR3_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR]], i64 1
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !29)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !32)
; CHECK-NEXT:    [[ADD_PTR_I_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR2_I]], i64 2
; CHECK-NEXT:    [[ADD_PTR1_I_I:%.*]] = getelementptr inbounds i32, i32* [[ADD_PTR3_I]], i64 2
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !34)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !37)
; CHECK-NEXT:    store i32 10, i32* [[ADD_PTR_I_I]], align 4, !alias.scope !39, !noalias !40
; CHECK-NEXT:    store i32 20, i32* [[ADD_PTR1_I_I]], align 4, !alias.scope !40, !noalias !39
; CHECK-NEXT:    store i32 11, i32* [[ADD_PTR2_I]], align 4, !alias.scope !41, !noalias !42
; CHECK-NEXT:    store i32 12, i32* [[ADD_PTR1]], align 4, !alias.scope !20, !noalias !17
; CHECK-NEXT:    br label [[CALLER_EQUALS_CALLEE_EXIT]]
; CHECK:       caller_equals_callee.exit:
; CHECK-NEXT:    ret void
;
entry:
  store i32 13, i32* %p0, align 4
  %add.ptr = getelementptr inbounds i32, i32* %p0, i64 1
  %add.ptr1 = getelementptr inbounds i32, i32* %p1, i64 1
  call void @caller_equals_callee(i32* nonnull %add.ptr, i32* nonnull %add.ptr1, i32 %cnt)
  ret void
}

attributes #0 = { inaccessiblememonly nofree nosync nounwind willreturn }

!0 = !{!1}
!1 = distinct !{!1, !2, !"do_store: %p0"}
!2 = distinct !{!2, !"do_store"}
!3 = !{!4}
!4 = distinct !{!4, !2, !"do_store: %p1"}

; CHECK: !0 = !{!1}
; CHECK: !1 = distinct !{!1, !2, !"do_store: %p0"}
; CHECK: !2 = distinct !{!2, !"do_store"}
; CHECK: !3 = !{!4}
; CHECK: !4 = distinct !{!4, !2, !"do_store: %p1"}
; CHECK: !5 = !{!6}
; CHECK: !6 = distinct !{!6, !7, !"caller_equals_callee: %p0"}
; CHECK: !7 = distinct !{!7, !"caller_equals_callee"}
; CHECK: !8 = !{!9}
; CHECK: !9 = distinct !{!9, !7, !"caller_equals_callee: %p1"}
; CHECK: !10 = !{!11}
; CHECK: !11 = distinct !{!11, !12, !"do_store: %p0"}
; CHECK: !12 = distinct !{!12, !"do_store"}
; CHECK: !13 = !{!14}
; CHECK: !14 = distinct !{!14, !12, !"do_store: %p1"}
; CHECK: !15 = !{!11, !6}
; CHECK: !16 = !{!14, !9}
; CHECK: !17 = !{!18}
; CHECK: !18 = distinct !{!18, !19, !"caller_equals_callee: %p0"}
; CHECK: !19 = distinct !{!19, !"caller_equals_callee"}
; CHECK: !20 = !{!21}
; CHECK: !21 = distinct !{!21, !19, !"caller_equals_callee: %p1"}
; CHECK: !22 = !{!23}
; CHECK: !23 = distinct !{!23, !24, !"do_store: %p0"}
; CHECK: !24 = distinct !{!24, !"do_store"}
; CHECK: !25 = !{!26}
; CHECK: !26 = distinct !{!26, !24, !"do_store: %p1"}
; CHECK: !27 = !{!23, !18}
; CHECK: !28 = !{!26, !21}
; CHECK: !29 = !{!30}
; CHECK: !30 = distinct !{!30, !31, !"caller_equals_callee: %p0"}
; CHECK: !31 = distinct !{!31, !"caller_equals_callee"}
; CHECK: !32 = !{!33}
; CHECK: !33 = distinct !{!33, !31, !"caller_equals_callee: %p1"}
; CHECK: !34 = !{!35}
; CHECK: !35 = distinct !{!35, !36, !"do_store: %p0"}
; CHECK: !36 = distinct !{!36, !"do_store"}
; CHECK: !37 = !{!38}
; CHECK: !38 = distinct !{!38, !36, !"do_store: %p1"}
; CHECK: !39 = !{!35, !30, !21}
; CHECK: !40 = !{!38, !33, !18}
; CHECK: !41 = !{!30, !21}
; CHECK: !42 = !{!33, !18}
