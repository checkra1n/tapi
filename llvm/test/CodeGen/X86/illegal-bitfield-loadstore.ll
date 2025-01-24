; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-linux-gnu | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s --check-prefix=X64

define void @i24_or(ptr %a) {
; X86-LABEL: i24_or:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl (%eax), %ecx
; X86-NEXT:    movzbl 2(%eax), %edx
; X86-NEXT:    shll $16, %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    orl $384, %edx # imm = 0x180
; X86-NEXT:    movw %dx, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: i24_or:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rdi), %eax
; X64-NEXT:    movzbl 2(%rdi), %ecx
; X64-NEXT:    shll $16, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    orl $384, %ecx # imm = 0x180
; X64-NEXT:    movw %cx, (%rdi)
; X64-NEXT:    retq
  %aa = load i24, ptr %a, align 1
  %b = or i24 %aa, 384
  store i24 %b, ptr %a, align 1
  ret void
}

define void @i24_and_or(ptr %a) {
; X86-LABEL: i24_and_or:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl (%eax), %ecx
; X86-NEXT:    movzbl 2(%eax), %edx
; X86-NEXT:    shll $16, %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    orl $384, %edx # imm = 0x180
; X86-NEXT:    andl $-128, %edx
; X86-NEXT:    movw %dx, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: i24_and_or:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rdi), %eax
; X64-NEXT:    movzbl 2(%rdi), %ecx
; X64-NEXT:    shll $16, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    orl $384, %ecx # imm = 0x180
; X64-NEXT:    andl $-128, %ecx
; X64-NEXT:    movw %cx, (%rdi)
; X64-NEXT:    retq
  %b = load i24, ptr %a, align 1
  %c = and i24 %b, -128
  %d = or i24 %c, 384
  store i24 %d, ptr %a, align 1
  ret void
}

define void @i24_insert_bit(ptr %a, i1 zeroext %bit) {
; X86-LABEL: i24_insert_bit:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl (%eax), %edx
; X86-NEXT:    movzbl 2(%eax), %esi
; X86-NEXT:    shll $16, %esi
; X86-NEXT:    orl %edx, %esi
; X86-NEXT:    shll $13, %ecx
; X86-NEXT:    andl $16769023, %esi # imm = 0xFFDFFF
; X86-NEXT:    orl %ecx, %esi
; X86-NEXT:    movw %si, (%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: i24_insert_bit:
; X64:       # %bb.0:
; X64-NEXT:    movzwl (%rdi), %eax
; X64-NEXT:    movzbl 2(%rdi), %ecx
; X64-NEXT:    shll $16, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    shll $13, %esi
; X64-NEXT:    andl $16769023, %ecx # imm = 0xFFDFFF
; X64-NEXT:    orl %esi, %ecx
; X64-NEXT:    movw %cx, (%rdi)
; X64-NEXT:    retq
  %extbit = zext i1 %bit to i24
  %b = load i24, ptr %a, align 1
  %extbit.shl = shl nuw nsw i24 %extbit, 13
  %c = and i24 %b, -8193
  %d = or i24 %c, %extbit.shl
  store i24 %d, ptr %a, align 1
  ret void
}

define void @i56_or(ptr %a) {
; X86-LABEL: i56_or:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    orl $384, (%eax) # imm = 0x180
; X86-NEXT:    retl
;
; X64-LABEL: i56_or:
; X64:       # %bb.0:
; X64-NEXT:    orl $384, (%rdi) # imm = 0x180
; X64-NEXT:    retq
  %aa = load i56, ptr %a, align 1
  %b = or i56 %aa, 384
  store i56 %b, ptr %a, align 1
  ret void
}

define void @i56_and_or(ptr %a) {
; X86-LABEL: i56_and_or:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $384, %ecx # imm = 0x180
; X86-NEXT:    orl (%eax), %ecx
; X86-NEXT:    andl $-128, %ecx
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: i56_and_or:
; X64:       # %bb.0:
; X64-NEXT:    movzwl 4(%rdi), %eax
; X64-NEXT:    movzbl 6(%rdi), %ecx
; X64-NEXT:    shll $16, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    shlq $32, %rcx
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    orq %rcx, %rax
; X64-NEXT:    orq $384, %rax # imm = 0x180
; X64-NEXT:    movabsq $72057594037927808, %rcx # imm = 0xFFFFFFFFFFFF80
; X64-NEXT:    andq %rax, %rcx
; X64-NEXT:    movl %ecx, (%rdi)
; X64-NEXT:    shrq $32, %rcx
; X64-NEXT:    movw %cx, 4(%rdi)
; X64-NEXT:    retq
  %b = load i56, ptr %a, align 1
  %c = and i56 %b, -128
  %d = or i56 %c, 384
  store i56 %d, ptr %a, align 1
  ret void
}

define void @i56_insert_bit(ptr %a, i1 zeroext %bit) {
; X86-LABEL: i56_insert_bit:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $13, %ecx
; X86-NEXT:    movl $-8193, %edx # imm = 0xDFFF
; X86-NEXT:    andl (%eax), %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    movl %edx, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: i56_insert_bit:
; X64:       # %bb.0:
; X64-NEXT:    movzwl 4(%rdi), %eax
; X64-NEXT:    movzbl 6(%rdi), %ecx
; X64-NEXT:    shll $16, %ecx
; X64-NEXT:    orl %eax, %ecx
; X64-NEXT:    shlq $32, %rcx
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    orq %rcx, %rax
; X64-NEXT:    shll $13, %esi
; X64-NEXT:    andq $-8193, %rax # imm = 0xDFFF
; X64-NEXT:    orl %eax, %esi
; X64-NEXT:    shrq $32, %rax
; X64-NEXT:    movw %ax, 4(%rdi)
; X64-NEXT:    movl %esi, (%rdi)
; X64-NEXT:    retq
  %extbit = zext i1 %bit to i56
  %b = load i56, ptr %a, align 1
  %extbit.shl = shl nuw nsw i56 %extbit, 13
  %c = and i56 %b, -8193
  %d = or i56 %c, %extbit.shl
  store i56 %d, ptr %a, align 1
  ret void
}

