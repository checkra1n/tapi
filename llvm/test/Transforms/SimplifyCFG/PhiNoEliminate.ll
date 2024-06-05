; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

;; The PHI node in this example should not be turned into a select, as we are
;; not able to ifcvt the entire block.  As such, converting to a select just
;; introduces inefficiency without saving copies.

define i32 @bar(i1 %C) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[THEN:%.*]], label [[ENDIF:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[TMP_3:%.*]] = call i32 @qux()
; CHECK-NEXT:    br label [[ENDIF]]
; CHECK:       endif:
; CHECK-NEXT:    [[R:%.*]] = phi i32 [ 123, [[ENTRY:%.*]] ], [ 12312, [[THEN]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @qux()
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @qux()
; CHECK-NEXT:    ret i32 [[R]]
;
entry:
  br i1 %C, label %then, label %endif
then:           ; preds = %entry
  %tmp.3 = call i32 @qux( )               ; <i32> [#uses=0]
  br label %endif
endif:          ; preds = %then, %entry
  %R = phi i32 [ 123, %entry ], [ 12312, %then ]          ; <i32> [#uses=1]
  ;; stuff to disable tail duplication
  call i32 @qux( )                ; <i32>:0 [#uses=0]
  call i32 @qux( )                ; <i32>:1 [#uses=0]
  call i32 @qux( )                ; <i32>:2 [#uses=0]
  call i32 @qux( )                ; <i32>:3 [#uses=0]
  call i32 @qux( )                ; <i32>:4 [#uses=0]
  call i32 @qux( )                ; <i32>:5 [#uses=0]
  call i32 @qux( )                ; <i32>:6 [#uses=0]
  ret i32 %R
}

declare i32 @qux()
