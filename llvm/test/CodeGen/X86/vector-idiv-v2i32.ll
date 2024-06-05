; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i386-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X86

define void @test_udiv7_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_udiv7_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movdqa {{.*#+}} xmm1 = [613566757,613566757,613566757,613566757]
; X64-NEXT:    movdqa %xmm0, %xmm2
; X64-NEXT:    pmuludq %xmm1, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq %xmm1, %xmm3
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,3,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; X64-NEXT:    psubd %xmm2, %xmm0
; X64-NEXT:    psrld $1, %xmm0
; X64-NEXT:    paddd %xmm2, %xmm0
; X64-NEXT:    psrld $2, %xmm0
; X64-NEXT:    movq %xmm0, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_udiv7_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [613566757,613566757,613566757,613566757]
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    pmuludq %xmm1, %xmm2
; X86-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X86-NEXT:    movdqa %xmm0, %xmm3
; X86-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1,1,1]
; X86-NEXT:    pmuludq %xmm1, %xmm3
; X86-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,3,2,3]
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; X86-NEXT:    psubd %xmm2, %xmm0
; X86-NEXT:    psrld $1, %xmm0
; X86-NEXT:    paddd %xmm2, %xmm0
; X86-NEXT:    psrld $2, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = udiv <2 x i32> %a, <i32 7, i32 7>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_urem7_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_urem7_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movdqa {{.*#+}} xmm1 = [613566757,613566757,613566757,613566757]
; X64-NEXT:    movdqa %xmm0, %xmm2
; X64-NEXT:    pmuludq %xmm1, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq %xmm1, %xmm3
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,3,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; X64-NEXT:    movdqa %xmm0, %xmm1
; X64-NEXT:    psubd %xmm2, %xmm1
; X64-NEXT:    psrld $1, %xmm1
; X64-NEXT:    paddd %xmm2, %xmm1
; X64-NEXT:    psrld $2, %xmm1
; X64-NEXT:    movdqa %xmm1, %xmm2
; X64-NEXT:    pslld $3, %xmm2
; X64-NEXT:    psubd %xmm2, %xmm1
; X64-NEXT:    paddd %xmm0, %xmm1
; X64-NEXT:    movq %xmm1, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_urem7_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [613566757,613566757,613566757,613566757]
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    pmuludq %xmm1, %xmm2
; X86-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X86-NEXT:    movdqa %xmm0, %xmm3
; X86-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1,1,1]
; X86-NEXT:    pmuludq %xmm1, %xmm3
; X86-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,3,2,3]
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    psubd %xmm2, %xmm1
; X86-NEXT:    psrld $1, %xmm1
; X86-NEXT:    paddd %xmm2, %xmm1
; X86-NEXT:    psrld $2, %xmm1
; X86-NEXT:    movdqa %xmm1, %xmm2
; X86-NEXT:    pslld $3, %xmm2
; X86-NEXT:    psubd %xmm2, %xmm1
; X86-NEXT:    paddd %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = urem <2 x i32> %a, <i32 7, i32 7>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_sdiv7_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_sdiv7_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movdqa {{.*#+}} xmm1 = [2454267027,2454267027,2454267027,2454267027]
; X64-NEXT:    movdqa %xmm0, %xmm2
; X64-NEXT:    pmuludq %xmm1, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq %xmm1, %xmm3
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[1,3,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; X64-NEXT:    pxor %xmm3, %xmm3
; X64-NEXT:    pcmpgtd %xmm0, %xmm3
; X64-NEXT:    pand %xmm1, %xmm3
; X64-NEXT:    paddd %xmm0, %xmm3
; X64-NEXT:    psubd %xmm3, %xmm2
; X64-NEXT:    paddd %xmm0, %xmm2
; X64-NEXT:    movdqa %xmm2, %xmm0
; X64-NEXT:    psrld $31, %xmm0
; X64-NEXT:    psrad $2, %xmm2
; X64-NEXT:    paddd %xmm0, %xmm2
; X64-NEXT:    movq %xmm2, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_sdiv7_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movdqa {{.*#+}} xmm2 = [2454267027,2454267027,2454267027,2454267027]
; X86-NEXT:    movdqa %xmm1, %xmm0
; X86-NEXT:    pmuludq %xmm2, %xmm0
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,3,2,3]
; X86-NEXT:    movdqa %xmm1, %xmm3
; X86-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1,1,1]
; X86-NEXT:    pmuludq %xmm2, %xmm3
; X86-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[1,3,2,3]
; X86-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; X86-NEXT:    pxor %xmm3, %xmm3
; X86-NEXT:    pcmpgtd %xmm1, %xmm3
; X86-NEXT:    pand %xmm2, %xmm3
; X86-NEXT:    paddd %xmm1, %xmm3
; X86-NEXT:    psubd %xmm3, %xmm0
; X86-NEXT:    paddd %xmm1, %xmm0
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    psrld $31, %xmm1
; X86-NEXT:    psrad $2, %xmm0
; X86-NEXT:    paddd %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = sdiv <2 x i32> %a, <i32 7, i32 7>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_srem7_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_srem7_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movdqa {{.*#+}} xmm1 = [2454267027,2454267027,2454267027,2454267027]
; X64-NEXT:    movdqa %xmm0, %xmm2
; X64-NEXT:    pmuludq %xmm1, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq %xmm1, %xmm3
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[1,3,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; X64-NEXT:    pxor %xmm3, %xmm3
; X64-NEXT:    pcmpgtd %xmm0, %xmm3
; X64-NEXT:    pand %xmm1, %xmm3
; X64-NEXT:    paddd %xmm0, %xmm3
; X64-NEXT:    psubd %xmm3, %xmm2
; X64-NEXT:    paddd %xmm0, %xmm2
; X64-NEXT:    movdqa %xmm2, %xmm1
; X64-NEXT:    psrld $31, %xmm1
; X64-NEXT:    psrad $2, %xmm2
; X64-NEXT:    paddd %xmm1, %xmm2
; X64-NEXT:    movdqa %xmm2, %xmm1
; X64-NEXT:    pslld $3, %xmm1
; X64-NEXT:    psubd %xmm1, %xmm2
; X64-NEXT:    paddd %xmm0, %xmm2
; X64-NEXT:    movq %xmm2, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_srem7_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movdqa {{.*#+}} xmm2 = [2454267027,2454267027,2454267027,2454267027]
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    pmuludq %xmm2, %xmm1
; X86-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,3,2,3]
; X86-NEXT:    movdqa %xmm0, %xmm3
; X86-NEXT:    shufps {{.*#+}} xmm3 = xmm3[1,1,1,1]
; X86-NEXT:    pmuludq %xmm2, %xmm3
; X86-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[1,3,2,3]
; X86-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
; X86-NEXT:    pxor %xmm3, %xmm3
; X86-NEXT:    pcmpgtd %xmm0, %xmm3
; X86-NEXT:    pand %xmm2, %xmm3
; X86-NEXT:    paddd %xmm0, %xmm3
; X86-NEXT:    psubd %xmm3, %xmm1
; X86-NEXT:    paddd %xmm0, %xmm1
; X86-NEXT:    movdqa %xmm1, %xmm2
; X86-NEXT:    psrld $31, %xmm2
; X86-NEXT:    psrad $2, %xmm1
; X86-NEXT:    paddd %xmm2, %xmm1
; X86-NEXT:    movdqa %xmm1, %xmm2
; X86-NEXT:    pslld $3, %xmm2
; X86-NEXT:    psubd %xmm2, %xmm1
; X86-NEXT:    paddd %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = srem <2 x i32> %a, <i32 7, i32 7>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_udiv_pow2_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_udiv_pow2_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    psrld $3, %xmm0
; X64-NEXT:    movq %xmm0, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_udiv_pow2_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    psrld $3, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = udiv <2 x i32> %a, <i32 8, i32 8>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_urem_pow2_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_urem_pow2_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movabsq $30064771079, %rax # imm = 0x700000007
; X64-NEXT:    andq (%rdi), %rax
; X64-NEXT:    movq %rax, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_urem_pow2_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    movlps %xmm0, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = urem <2 x i32> %a, <i32 8, i32 8>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_sdiv_pow2_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_sdiv_pow2_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movdqa %xmm0, %xmm1
; X64-NEXT:    psrad $31, %xmm1
; X64-NEXT:    psrld $29, %xmm1
; X64-NEXT:    paddd %xmm0, %xmm1
; X64-NEXT:    psrad $3, %xmm1
; X64-NEXT:    movq %xmm1, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_sdiv_pow2_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    psrad $31, %xmm1
; X86-NEXT:    psrld $29, %xmm1
; X86-NEXT:    paddd %xmm0, %xmm1
; X86-NEXT:    psrad $3, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = sdiv <2 x i32> %a, <i32 8, i32 8>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_srem_pow2_v2i32(ptr %x, ptr %y) nounwind {
; X64-LABEL: test_srem_pow2_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    psrld $3, %xmm0
; X64-NEXT:    movq %xmm0, (%rsi)
; X64-NEXT:    retq
;
; X86-LABEL: test_srem_pow2_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    psrld $3, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = udiv <2 x i32> %a, <i32 8, i32 8>
  store <2 x i32> %b, ptr %y
  ret void
}

define void @test_udiv_v2i32(ptr %x, ptr %y, ptr %z) nounwind {
; X64-LABEL: test_udiv_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rcx
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movq %rax, %xmm0
; X64-NEXT:    movq (%rsi), %rsi
; X64-NEXT:    movq %rsi, %xmm1
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    movd %eax, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,1,1]
; X64-NEXT:    movd %xmm0, %esi
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    movd %eax, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    movq %xmm2, (%rcx)
; X64-NEXT:    retq
;
; X86-LABEL: test_udiv_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    divl %esi
; X86-NEXT:    movd %eax, %xmm2
; X86-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    divl %esi
; X86-NEXT:    movd %eax, %xmm0
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X86-NEXT:    movq %xmm2, (%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = load <2 x i32>, ptr %y
  %c = udiv <2 x i32> %a, %b
  store <2 x i32> %c, ptr %z
  ret void
}

define void @test_urem_v2i32(ptr %x, ptr %y, ptr %z) nounwind {
; X64-LABEL: test_urem_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rcx
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movq %rax, %xmm0
; X64-NEXT:    movq (%rsi), %rsi
; X64-NEXT:    movq %rsi, %xmm1
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    movd %edx, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,1,1]
; X64-NEXT:    movd %xmm0, %esi
; X64-NEXT:    xorl %edx, %edx
; X64-NEXT:    divl %esi
; X64-NEXT:    movd %edx, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    movq %xmm2, (%rcx)
; X64-NEXT:    retq
;
; X86-LABEL: test_urem_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    divl %esi
; X86-NEXT:    movd %edx, %xmm2
; X86-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    divl %esi
; X86-NEXT:    movd %edx, %xmm0
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X86-NEXT:    movq %xmm2, (%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = load <2 x i32>, ptr %y
  %c = urem <2 x i32> %a, %b
  store <2 x i32> %c, ptr %z
  ret void
}

define void @test_sdiv_v2i32(ptr %x, ptr %y, ptr %z) nounwind {
; X64-LABEL: test_sdiv_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rcx
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movq %rax, %xmm0
; X64-NEXT:    movq (%rsi), %rsi
; X64-NEXT:    movq %rsi, %xmm1
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    movd %eax, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,1,1]
; X64-NEXT:    movd %xmm0, %esi
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    movd %eax, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    movq %xmm2, (%rcx)
; X64-NEXT:    retq
;
; X86-LABEL: test_sdiv_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    movd %eax, %xmm2
; X86-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    movd %eax, %xmm0
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X86-NEXT:    movq %xmm2, (%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = load <2 x i32>, ptr %y
  %c = sdiv <2 x i32> %a, %b
  store <2 x i32> %c, ptr %z
  ret void
}

define void @test_srem_v2i32(ptr %x, ptr %y, ptr %z) nounwind {
; X64-LABEL: test_srem_v2i32:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rcx
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movq %rax, %xmm0
; X64-NEXT:    movq (%rsi), %rsi
; X64-NEXT:    movq %rsi, %xmm1
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    movd %eax, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,1,1]
; X64-NEXT:    movd %xmm0, %esi
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    movd %eax, %xmm0
; X64-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X64-NEXT:    movq %xmm2, (%rcx)
; X64-NEXT:    retq
;
; X86-LABEL: test_srem_v2i32:
; X86:       # %bb.0:
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    movd %eax, %xmm2
; X86-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; X86-NEXT:    movd %xmm1, %esi
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    movd %eax, %xmm0
; X86-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; X86-NEXT:    movq %xmm2, (%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    retl
  %a = load <2 x i32>, ptr %x
  %b = load <2 x i32>, ptr %y
  %c = sdiv <2 x i32> %a, %b
  store <2 x i32> %c, ptr %z
  ret void
}
