; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc-unknown-linux-gnu  | FileCheck %s
; RUN: llc -verify-machineinstrs < %s -mtriple=powerpc-unknown-linux-gnu  -regalloc=basic | FileCheck %s

declare ptr @llvm.frameaddress(i32) nounwind readnone

define ptr @g2() nounwind readnone {
; CHECK-LABEL: g2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lwz 3, 0(1)
; CHECK-NEXT:    blr
entry:
  %0 = tail call ptr @llvm.frameaddress(i32 1)    ; <ptr> [#uses=1]
  ret ptr %0
}

declare ptr @llvm.returnaddress(i32) nounwind readnone

define ptr @g() nounwind readnone {
; CHECK-LABEL: g:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    stw 0, 4(1)
; CHECK-NEXT:    stwu 1, -16(1)
; CHECK-NEXT:    lwz 3, 0(1)
; CHECK-NEXT:    lwz 3, 0(3)
; CHECK-NEXT:    lwz 3, 4(3)
; CHECK-NEXT:    lwz 0, 20(1)
; CHECK-NEXT:    addi 1, 1, 16
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
entry:
  %0 = tail call ptr @llvm.returnaddress(i32 1)   ; <ptr> [#uses=1]
  ret ptr %0
}