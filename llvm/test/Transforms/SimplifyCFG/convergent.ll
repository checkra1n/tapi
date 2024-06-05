; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s
; RUN: opt -S -passes=simplifycfg < %s | FileCheck %s

declare void @foo() convergent

define i32 @test_01(i32 %a) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A:%.*]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[MERGE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.false:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[IF_FALSE_2:%.*]]
; CHECK:       if.false.2:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[A]]
;
entry:
  %cond = icmp eq i32 %a, 0
  br i1 %cond, label %merge, label %if.false

if.false:
  call void @foo()
  br label %merge

merge:
  call void @foo()
  br i1 %cond, label %exit, label %if.false.2

if.false.2:
  call void @foo()
  br label %exit

exit:
  ret i32 %a
}
