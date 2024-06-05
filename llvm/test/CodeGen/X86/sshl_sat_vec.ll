; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefix=X86

declare  <4 x i32> @llvm.sshl.sat.v4i32(<4 x i32>, <4 x i32>)

define <4 x i32> @vec(<4 x i32> %x, <4 x i32> %y) nounwind {
; X64-LABEL: vec:
; X64:       # %bb.0:
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[3,3,3,3]
; X64-NEXT:    movd %xmm2, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[3,3,3,3]
; X64-NEXT:    movd %xmm2, %ecx
; X64-NEXT:    movl %eax, %edx
; X64-NEXT:    shll %cl, %edx
; X64-NEXT:    movl %edx, %esi
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarl %cl, %esi
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    testl %eax, %eax
; X64-NEXT:    sets %cl
; X64-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X64-NEXT:    cmpl %esi, %eax
; X64-NEXT:    cmovel %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[2,3,2,3]
; X64-NEXT:    movd %xmm3, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[2,3,2,3]
; X64-NEXT:    movd %xmm3, %ecx
; X64-NEXT:    movl %eax, %edx
; X64-NEXT:    shll %cl, %edx
; X64-NEXT:    movl %edx, %esi
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarl %cl, %esi
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    testl %eax, %eax
; X64-NEXT:    sets %cl
; X64-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X64-NEXT:    cmpl %esi, %eax
; X64-NEXT:    cmovel %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm3
; X64-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    movd %xmm1, %ecx
; X64-NEXT:    movl %eax, %edx
; X64-NEXT:    shll %cl, %edx
; X64-NEXT:    movl %edx, %esi
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarl %cl, %esi
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    testl %eax, %eax
; X64-NEXT:    sets %cl
; X64-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X64-NEXT:    cmpl %esi, %eax
; X64-NEXT:    cmovel %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,1,1]
; X64-NEXT:    movd %xmm0, %ecx
; X64-NEXT:    movl %eax, %edx
; X64-NEXT:    shll %cl, %edx
; X64-NEXT:    movl %edx, %esi
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarl %cl, %esi
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    testl %eax, %eax
; X64-NEXT:    sets %cl
; X64-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X64-NEXT:    cmpl %esi, %eax
; X64-NEXT:    cmovel %edx, %ecx
; X64-NEXT:    movd %ecx, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm3[0]
; X64-NEXT:    movdqa %xmm2, %xmm0
; X64-NEXT:    retq
;
; X86-LABEL: vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movb {{[0-9]+}}(%esp), %ch
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ebp
; X86-NEXT:    shll %cl, %ebp
; X86-NEXT:    movl %ebp, %edi
; X86-NEXT:    sarl %cl, %edi
; X86-NEXT:    xorl %ebx, %ebx
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    sets %bl
; X86-NEXT:    addl $2147483647, %ebx # imm = 0x7FFFFFFF
; X86-NEXT:    cmpl %edi, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    cmovel %ebp, %ebx
; X86-NEXT:    movl %edi, %ebp
; X86-NEXT:    movb %ch, %cl
; X86-NEXT:    shll %cl, %ebp
; X86-NEXT:    movl %ebp, %eax
; X86-NEXT:    sarl %cl, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    testl %edi, %edi
; X86-NEXT:    sets %dl
; X86-NEXT:    addl $2147483647, %edx # imm = 0x7FFFFFFF
; X86-NEXT:    cmpl %eax, %edi
; X86-NEXT:    cmovel %ebp, %edx
; X86-NEXT:    movl %esi, %edi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll %cl, %edi
; X86-NEXT:    movl %edi, %ebp
; X86-NEXT:    sarl %cl, %ebp
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    sets %al
; X86-NEXT:    addl $2147483647, %eax # imm = 0x7FFFFFFF
; X86-NEXT:    cmpl %ebp, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    cmovel %edi, %eax
; X86-NEXT:    movl %esi, %edi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll %cl, %edi
; X86-NEXT:    movl %edi, %ebp
; X86-NEXT:    sarl %cl, %ebp
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    sets %cl
; X86-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X86-NEXT:    cmpl %ebp, %esi
; X86-NEXT:    cmovel %edi, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %ecx, 12(%esi)
; X86-NEXT:    movl %eax, 8(%esi)
; X86-NEXT:    movl %edx, 4(%esi)
; X86-NEXT:    movl %ebx, (%esi)
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %tmp = call <4 x i32> @llvm.sshl.sat.v4i32(<4 x i32> %x, <4 x i32> %y)
  ret <4 x i32> %tmp
}
