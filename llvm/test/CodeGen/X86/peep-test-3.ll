; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mcpu=generic -mtriple=i686-- -post-RA-scheduler=false | FileCheck %s
; rdar://7226797

; LLVM should omit the testl and use the flags result from the orl.

define void @or(ptr %A, i32 %IA, i32 %N) nounwind {
; CHECK-LABEL: or:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl %eax, %edx
; CHECK-NEXT:    andl $3, %edx
; CHECK-NEXT:    xorl $1, %ecx
; CHECK-NEXT:    orl %edx, %ecx
; CHECK-NEXT:    je .LBB0_2
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    movl $0, (%eax)
; CHECK-NEXT:  .LBB0_2: # %return
; CHECK-NEXT:    retl
entry:
  %0 = ptrtoint ptr %A to i32                  ; <i32> [#uses=1]
  %1 = and i32 %0, 3                              ; <i32> [#uses=1]
  %2 = xor i32 %IA, 1                             ; <i32> [#uses=1]
  %3 = or i32 %2, %1                              ; <i32> [#uses=1]
  %4 = icmp eq i32 %3, 0                          ; <i1> [#uses=1]
  br i1 %4, label %return, label %bb

bb:                                               ; preds = %entry
  store float 0.000000e+00, ptr %A, align 4
  ret void

return:                                           ; preds = %entry
  ret void
}

define void @xor(ptr %A, i32 %IA, i32 %N) nounwind {
; CHECK-LABEL: xor:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    andl $3, %ecx
; CHECK-NEXT:    xorl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    cmpl $1, %ecx
; CHECK-NEXT:    je .LBB1_2
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    movl $0, (%eax)
; CHECK-NEXT:  .LBB1_2: # %return
; CHECK-NEXT:    retl
entry:
  %0 = ptrtoint ptr %A to i32                  ; <i32> [#uses=1]
  %1 = and i32 %0, 3                              ; <i32> [#uses=1]
  %2 = xor i32 %IA, 1                             ; <i32> [#uses=1]
  %3 = xor i32 %2, %1                              ; <i32> [#uses=1]
  %4 = icmp eq i32 %3, 0                          ; <i1> [#uses=1]
  br i1 %4, label %return, label %bb

bb:                                               ; preds = %entry
  store float 0.000000e+00, ptr %A, align 4
  ret void

return:                                           ; preds = %entry
  ret void
}

define void @and(ptr %A, i32 %IA, i32 %N, ptr %p) nounwind {
; CHECK-LABEL: and:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    xorl $1, %eax
; CHECK-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    andl $3, %eax
; CHECK-NEXT:    movb %al, (%ecx)
; CHECK-NEXT:    je .LBB2_2
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    movl $0, 0
; CHECK-NEXT:  .LBB2_2: # %return
; CHECK-NEXT:    retl
entry:
  store i8 0, ptr %p
  %0 = ptrtoint ptr %A to i32                  ; <i32> [#uses=1]
  %1 = and i32 %0, 3                              ; <i32> [#uses=1]
  %2 = xor i32 %IA, 1                             ; <i32> [#uses=1]
  %3 = and i32 %2, %1                              ; <i32> [#uses=1]
  %t = trunc i32 %3 to i8
  store i8 %t, ptr %p
  %4 = icmp eq i32 %3, 0                          ; <i1> [#uses=1]
  br i1 %4, label %return, label %bb

bb:                                               ; preds = %entry
  store float 0.000000e+00, ptr null, align 4
  ret void

return:                                           ; preds = %entry
  ret void
}

; Just like @and, but without the trunc+store. This should use a testb
; instead of an andl.
define void @test(ptr %A, i32 %IA, i32 %N, ptr %p) nounwind {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movb $0, (%ecx)
; CHECK-NEXT:    xorl $1, %eax
; CHECK-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    testb $3, %al
; CHECK-NEXT:    je .LBB3_2
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    movl $0, 0
; CHECK-NEXT:  .LBB3_2: # %return
; CHECK-NEXT:    retl
entry:
  store i8 0, ptr %p
  %0 = ptrtoint ptr %A to i32                  ; <i32> [#uses=1]
  %1 = and i32 %0, 3                              ; <i32> [#uses=1]
  %2 = xor i32 %IA, 1                             ; <i32> [#uses=1]
  %3 = and i32 %2, %1                              ; <i32> [#uses=1]
  %4 = icmp eq i32 %3, 0                          ; <i1> [#uses=1]
  br i1 %4, label %return, label %bb

bb:                                               ; preds = %entry
  store float 0.000000e+00, ptr null, align 4
  ret void

return:                                           ; preds = %entry
  ret void
}
