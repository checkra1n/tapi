; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=X64

define void @PR57283() nounwind {
; X86-LABEL: PR57283:
; X86:       # %bb.0: # %BB
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $0, (%esp)
; X86-NEXT:    movl $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl $0, {{[0-9]+}}(%esp)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: PR57283:
; X64:       # %bb.0: # %BB
; X64-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; X64-NEXT:    retq
BB:
  %A6 = alloca i64, align 8
  %A = alloca i64, align 8
  %L = load i64, i64* %A, align 4
  %B3 = sub i64 %L, %L
  %B2 = mul i64 %B3, 4294967296
  %B1 = add i64 %B2, %B2
  %B4 = udiv i64 %B2, -9223372036854775808
  %B = xor i64 %B1, %B4
  store i64 %B, i64* %A, align 4
  %B5 = sdiv i64 %B, -1
  store i64 %B5, i64* %A6, align 4
  ret void
}
