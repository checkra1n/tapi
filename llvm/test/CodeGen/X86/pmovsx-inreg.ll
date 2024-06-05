; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknwon -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE41
; RUN: llc < %s -mtriple=x86_64-unknwon -mattr=+avx | FileCheck %s --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknwon -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=i686-unknwon -mattr=+avx2 | FileCheck %s --check-prefix=X32-AVX2

; PR14887
; These tests inject a store into the chain to test the inreg versions of pmovsx

define void @test1(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbq (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxbq (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test1:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbq (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <2 x i8>, ptr %in, align 1
  %sext = sext <2 x i8> %wide.load35 to <2 x i64>
  store <2 x i64> zeroinitializer, ptr undef, align 8
  store <2 x i64> %sext, ptr %out, align 8
  ret void
}

define void @test2(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test2:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbq (%rdi), %xmm0
; SSE41-NEXT:    pmovsxbq 2(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxbq (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxbq 2(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxbq (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test2:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbq (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <4 x i8>, ptr %in, align 1
  %sext = sext <4 x i8> %wide.load35 to <4 x i64>
  store <4 x i64> zeroinitializer, ptr undef, align 8
  store <4 x i64> %sext, ptr %out, align 8
  ret void
}

define void @test3(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test3:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbd (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test3:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxbd (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test3:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbd (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <4 x i8>, ptr %in, align 1
  %sext = sext <4 x i8> %wide.load35 to <4 x i32>
  store <4 x i32> zeroinitializer, ptr undef, align 8
  store <4 x i32> %sext, ptr %out, align 8
  ret void
}

define void @test4(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test4:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbd (%rdi), %xmm0
; SSE41-NEXT:    pmovsxbd 4(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test4:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxbd (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxbd 4(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxbd (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test4:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbd (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <8 x i8>, ptr %in, align 1
  %sext = sext <8 x i8> %wide.load35 to <8 x i32>
  store <8 x i32> zeroinitializer, ptr undef, align 8
  store <8 x i32> %sext, ptr %out, align 8
  ret void
}

define void @test5(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test5:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbw (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test5:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxbw (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test5:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbw (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <8 x i8>, ptr %in, align 1
  %sext = sext <8 x i8> %wide.load35 to <8 x i16>
  store <8 x i16> zeroinitializer, ptr undef, align 8
  store <8 x i16> %sext, ptr %out, align 8
  ret void
}

define void @test6(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test6:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxbw (%rdi), %xmm0
; SSE41-NEXT:    pmovsxbw 8(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test6:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxbw (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxbw 8(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test6:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxbw (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test6:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxbw (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <16 x i8>, ptr %in, align 1
  %sext = sext <16 x i8> %wide.load35 to <16 x i16>
  store <16 x i16> zeroinitializer, ptr undef, align 8
  store <16 x i16> %sext, ptr %out, align 8
  ret void
}

define void @test7(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test7:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxwq (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test7:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxwq (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test7:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxwq (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <2 x i16>, ptr %in, align 1
  %sext = sext <2 x i16> %wide.load35 to <2 x i64>
  store <2 x i64> zeroinitializer, ptr undef, align 8
  store <2 x i64> %sext, ptr %out, align 8
  ret void
}

define void @test8(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test8:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxwq (%rdi), %xmm0
; SSE41-NEXT:    pmovsxwq 4(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxwq (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxwq 4(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxwq (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test8:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxwq (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <4 x i16>, ptr %in, align 1
  %sext = sext <4 x i16> %wide.load35 to <4 x i64>
  store <4 x i64> zeroinitializer, ptr undef, align 8
  store <4 x i64> %sext, ptr %out, align 8
  ret void
}

define void @test9(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test9:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxwd (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test9:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxwd (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test9:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxwd (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <4 x i16>, ptr %in, align 1
  %sext = sext <4 x i16> %wide.load35 to <4 x i32>
  store <4 x i32> zeroinitializer, ptr undef, align 8
  store <4 x i32> %sext, ptr %out, align 8
  ret void
}

define void @test10(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test10:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxwd (%rdi), %xmm0
; SSE41-NEXT:    pmovsxwd 8(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test10:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxwd (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxwd 8(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test10:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxwd (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test10:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxwd (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <8 x i16>, ptr %in, align 1
  %sext = sext <8 x i16> %wide.load35 to <8 x i32>
  store <8 x i32> zeroinitializer, ptr undef, align 8
  store <8 x i32> %sext, ptr %out, align 8
  ret void
}

define void @test11(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test11:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxdq (%rdi), %xmm0
; SSE41-NEXT:    xorps %xmm1, %xmm1
; SSE41-NEXT:    movups %xmm1, (%rax)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX-LABEL: test11:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxdq (%rdi), %xmm0
; AVX-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vmovups %xmm1, (%rax)
; AVX-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; X32-AVX2-LABEL: test11:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxdq (%ecx), %xmm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %xmm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %xmm0, (%eax)
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <2 x i32>, ptr %in, align 1
  %sext = sext <2 x i32> %wide.load35 to <2 x i64>
  store <2 x i64> zeroinitializer, ptr undef, align 8
  store <2 x i64> %sext, ptr %out, align 8
  ret void
}

define void @test12(ptr %in, ptr %out) nounwind {
; SSE41-LABEL: test12:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxdq (%rdi), %xmm0
; SSE41-NEXT:    pmovsxdq 8(%rdi), %xmm1
; SSE41-NEXT:    xorps %xmm2, %xmm2
; SSE41-NEXT:    movups %xmm2, (%rax)
; SSE41-NEXT:    movdqu %xmm1, 16(%rsi)
; SSE41-NEXT:    movdqu %xmm0, (%rsi)
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test12:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxdq (%rdi), %xmm0
; AVX1-NEXT:    vpmovsxdq 8(%rdi), %xmm1
; AVX1-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; AVX1-NEXT:    vmovups %ymm2, (%rax)
; AVX1-NEXT:    vmovdqu %xmm1, 16(%rsi)
; AVX1-NEXT:    vmovdqu %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test12:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxdq (%rdi), %ymm0
; AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vmovups %ymm1, (%rax)
; AVX2-NEXT:    vmovdqu %ymm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; X32-AVX2-LABEL: test12:
; X32-AVX2:       # %bb.0:
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-AVX2-NEXT:    vpmovsxdq (%ecx), %ymm0
; X32-AVX2-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-AVX2-NEXT:    vmovups %ymm1, (%eax)
; X32-AVX2-NEXT:    vmovdqu %ymm0, (%eax)
; X32-AVX2-NEXT:    vzeroupper
; X32-AVX2-NEXT:    retl
  %wide.load35 = load <4 x i32>, ptr %in, align 1
  %sext = sext <4 x i32> %wide.load35 to <4 x i64>
  store <4 x i64> zeroinitializer, ptr undef, align 8
  store <4 x i64> %sext, ptr %out, align 8
  ret void
}
