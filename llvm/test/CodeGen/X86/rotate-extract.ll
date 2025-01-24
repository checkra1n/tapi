; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

; Check that under certain conditions we can factor out a rotate
; from the following idioms:
;   (a*c0) >> s1 | (a*c1)
;   (a/c0) << s1 | (a/c1)
; This targets cases where instcombine has folded a shl/srl/mul/udiv
; with one of the shifts from the rotate idiom

define i64 @rolq_extract_shl(i64 %i) nounwind {
; X86-LABEL: rolq_extract_shl:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shldl $3, %edx, %ecx
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    shll $3, %edx
; X86-NEXT:    shrdl $25, %edx, %eax
; X86-NEXT:    shrdl $25, %ecx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: rolq_extract_shl:
; X64:       # %bb.0:
; X64-NEXT:    leaq (,%rdi,8), %rax
; X64-NEXT:    rolq $7, %rax
; X64-NEXT:    retq
  %lhs_mul = shl i64 %i, 3
  %rhs_mul = shl i64 %i, 10
  %lhs_shift = lshr i64 %lhs_mul, 57
  %out = or i64 %lhs_shift, %rhs_mul
  ret i64 %out
}

define i16 @rolw_extract_shrl(i16 %i) nounwind {
; X86-LABEL: rolw_extract_shrl:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl $3, %eax
; X86-NEXT:    rolw $12, %ax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: rolw_extract_shrl:
; X64:       # %bb.0:
; X64-NEXT:    movzwl %di, %eax
; X64-NEXT:    shrl $3, %eax
; X64-NEXT:    rolw $12, %ax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %lhs_div = lshr i16 %i, 7
  %rhs_div = lshr i16 %i, 3
  %rhs_shift = shl i16 %rhs_div, 12
  %out = or i16 %lhs_div, %rhs_shift
  ret i16 %out
}

define i32 @roll_extract_mul(i32 %i) nounwind {
; X86-LABEL: roll_extract_mul:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,8), %eax
; X86-NEXT:    roll $7, %eax
; X86-NEXT:    retl
;
; X64-LABEL: roll_extract_mul:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi,8), %eax
; X64-NEXT:    roll $7, %eax
; X64-NEXT:    retq
  %lhs_mul = mul i32 %i, 9
  %rhs_mul = mul i32 %i, 1152
  %lhs_shift = lshr i32 %lhs_mul, 25
  %out = or i32 %lhs_shift, %rhs_mul
  ret i32 %out
}

define i8 @rolb_extract_udiv(i8 %i) nounwind {
; X86-LABEL: rolb_extract_udiv:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    imull $171, %eax, %eax
; X86-NEXT:    shrl $9, %eax
; X86-NEXT:    rolb $4, %al
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: rolb_extract_udiv:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    imull $171, %eax, %eax
; X64-NEXT:    shrl $9, %eax
; X64-NEXT:    rolb $4, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %lhs_div = udiv i8 %i, 3
  %rhs_div = udiv i8 %i, 48
  %lhs_shift = shl i8 %lhs_div, 4
  %out = or i8 %lhs_shift, %rhs_div
  ret i8 %out
}

define i64 @rolq_extract_mul_with_mask(i64 %i) nounwind {
; X86-LABEL: rolq_extract_mul_with_mask:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,8), %ecx
; X86-NEXT:    movl $9, %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    shrdl $25, %eax, %edx
; X86-NEXT:    movzbl %dl, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    retl
;
; X64-LABEL: rolq_extract_mul_with_mask:
; X64:       # %bb.0:
; X64-NEXT:    leaq (%rdi,%rdi,8), %rax
; X64-NEXT:    rolq $7, %rax
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    retq
  %lhs_mul = mul i64 %i, 1152
  %rhs_mul = mul i64 %i, 9
  %lhs_and = and i64 %lhs_mul, 160
  %rhs_shift = lshr i64 %rhs_mul, 57
  %out = or i64 %lhs_and, %rhs_shift
  ret i64 %out
}

; Result would undershift
define i64 @no_extract_shl(i64 %i) nounwind {
; X86-LABEL: no_extract_shl:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %edx
; X86-NEXT:    shldl $10, %ecx, %edx
; X86-NEXT:    shll $10, %ecx
; X86-NEXT:    shrl $20, %eax
; X86-NEXT:    andl $127, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: no_extract_shl:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shlq $10, %rax
; X64-NEXT:    shrq $52, %rdi
; X64-NEXT:    andl $127, %edi
; X64-NEXT:    orq %rdi, %rax
; X64-NEXT:    retq
  %lhs_mul = shl i64 %i, 5
  %rhs_mul = shl i64 %i, 10
  %lhs_shift = lshr i64 %lhs_mul, 57
  %out = or i64 %lhs_shift, %rhs_mul
  ret i64 %out
}

; Result would overshift
define i32 @no_extract_shrl(i32 %i) nounwind {
; X86-LABEL: no_extract_shrl:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shrl $9, %ecx
; X86-NEXT:    andl $-8, %eax
; X86-NEXT:    shll $25, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: no_extract_shrl:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl $9, %eax
; X64-NEXT:    andl $-8, %edi
; X64-NEXT:    shll $25, %edi
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %lhs_div = lshr i32 %i, 3
  %rhs_div = lshr i32 %i, 9
  %lhs_shift = shl i32 %lhs_div, 28
  %out = or i32 %lhs_shift, %rhs_div
  ret i32 %out
}

; Can factor 128 from 2304, but result is 18 instead of 9
define i16 @no_extract_mul(i16 %i) nounwind {
; X86-LABEL: no_extract_mul:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,8), %ecx
; X86-NEXT:    shll $8, %eax
; X86-NEXT:    leal (%eax,%eax,8), %edx
; X86-NEXT:    movzwl %cx, %eax
; X86-NEXT:    shrl $9, %eax
; X86-NEXT:    orl %edx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: no_extract_mul:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi,8), %eax
; X64-NEXT:    # kill: def $edi killed $edi killed $rdi def $rdi
; X64-NEXT:    shll $8, %edi
; X64-NEXT:    leal (%rdi,%rdi,8), %ecx
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    shrl $9, %eax
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %lhs_mul = mul i16 %i, 2304
  %rhs_mul = mul i16 %i, 9
  %rhs_shift = lshr i16 %rhs_mul, 9
  %out = or i16 %lhs_mul, %rhs_shift
  ret i16 %out
}

; Can't evenly factor 16 from 49
define i8 @no_extract_udiv(i8 %i) nounwind {
; X86-LABEL: no_extract_udiv:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    imull $171, %eax, %ecx
; X86-NEXT:    imull $79, %eax, %edx
; X86-NEXT:    subb %dh, %al
; X86-NEXT:    shrb %al
; X86-NEXT:    addb %dh, %al
; X86-NEXT:    shrb $5, %al
; X86-NEXT:    shlb $3, %ch
; X86-NEXT:    orb %al, %ch
; X86-NEXT:    andb $-9, %ch
; X86-NEXT:    movb %ch, %al
; X86-NEXT:    retl
;
; X64-LABEL: no_extract_udiv:
; X64:       # %bb.0:
; X64-NEXT:    movzbl %dil, %ecx
; X64-NEXT:    imull $171, %ecx, %eax
; X64-NEXT:    shrl $8, %eax
; X64-NEXT:    imull $79, %ecx, %edx
; X64-NEXT:    shrl $8, %edx
; X64-NEXT:    subb %dl, %cl
; X64-NEXT:    shrb %cl
; X64-NEXT:    addb %dl, %cl
; X64-NEXT:    shrb $5, %cl
; X64-NEXT:    shlb $3, %al
; X64-NEXT:    orb %cl, %al
; X64-NEXT:    andb $-9, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %lhs_div = udiv i8 %i, 3
  %rhs_div = udiv i8 %i, 49
  %lhs_shift = shl i8 %lhs_div,4
  %out = or i8 %lhs_shift, %rhs_div
  ret i8 %out
}

; DAGCombiner transforms shl X, 1 into add X, X.
define i32 @extract_add_1(i32 %i) nounwind {
; X86-LABEL: extract_add_1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll %eax
; X86-NEXT:    retl
;
; X64-LABEL: extract_add_1:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll %eax
; X64-NEXT:    retq
  %ii = add i32 %i, %i
  %rhs = lshr i32 %i, 31
  %out = or i32 %ii, %rhs
  ret i32 %out
}

define i32 @extract_add_1_comut(i32 %i) nounwind {
; X86-LABEL: extract_add_1_comut:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll %eax
; X86-NEXT:    retl
;
; X64-LABEL: extract_add_1_comut:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll %eax
; X64-NEXT:    retq
  %ii = add i32 %i, %i
  %lhs = lshr i32 %i, 31
  %out = or i32 %lhs, %ii
  ret i32 %out
}

define i32 @no_extract_add_1(i32 %i) nounwind {
; X86-LABEL: no_extract_add_1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax), %ecx
; X86-NEXT:    shrl $27, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: no_extract_add_1:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi), %eax
; X64-NEXT:    shrl $27, %edi
; X64-NEXT:    orl %edi, %eax
; X64-NEXT:    retq
  %ii = add i32 %i, %i
  %rhs = lshr i32 %i, 27
  %out = or i32 %ii, %rhs
  ret i32 %out
}
