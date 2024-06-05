; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i686-unknown-unknown -mattr=+avx512ifma,+avx512vl | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+avx512ifma,+avx512vl | FileCheck %s --check-prefixes=CHECK,X64

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/avx512ifmavl-builtins.c

define <2 x i64> @test_mm_madd52hi_epu64(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z) {
; CHECK-LABEL: test_mm_madd52hi_epu64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z)
  ret <2 x i64> %0
}

define <2 x i64> @test_mm_mask_madd52hi_epu64(<2 x i64> %__W, i8 zeroext %__M, <2 x i64> %__X, <2 x i64> %__Y) {
; X86-LABEL: test_mm_mask_madd52hi_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm_mask_madd52hi_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1}
; X64-NEXT:    retq
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64> %__W, <2 x i64> %__X, <2 x i64> %__Y)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <2 x i32> <i32 0, i32 1>
  %2 = select <2 x i1> %extract.i, <2 x i64> %0, <2 x i64> %__W
  ret <2 x i64> %2
}

define <2 x i64> @test_mm_maskz_madd52hi_epu64(i8 zeroext %__M, <2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z) {
; X86-LABEL: test_mm_maskz_madd52hi_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm_maskz_madd52hi_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52huq %xmm2, %xmm1, %xmm0 {%k1} {z}
; X64-NEXT:    retq
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <2 x i32> <i32 0, i32 1>
  %2 = select <2 x i1> %extract.i, <2 x i64> %0, <2 x i64> zeroinitializer
  ret <2 x i64> %2
}

define <4 x i64> @test_mm256_madd52hi_epu64(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z) {
; CHECK-LABEL: test_mm256_madd52hi_epu64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z)
  ret <4 x i64> %0
}

define <4 x i64> @test_mm256_mask_madd52hi_epu64(<4 x i64> %__W, i8 zeroext %__M, <4 x i64> %__X, <4 x i64> %__Y) {
; X86-LABEL: test_mm256_mask_madd52hi_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm256_mask_madd52hi_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1}
; X64-NEXT:    retq
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64> %__W, <4 x i64> %__X, <4 x i64> %__Y)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = select <4 x i1> %extract.i, <4 x i64> %0, <4 x i64> %__W
  ret <4 x i64> %2
}

define <4 x i64> @test_mm256_maskz_madd52hi_epu64(i8 zeroext %__M, <4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z) {
; X86-LABEL: test_mm256_maskz_madd52hi_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm256_maskz_madd52hi_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52huq %ymm2, %ymm1, %ymm0 {%k1} {z}
; X64-NEXT:    retq
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = select <4 x i1> %extract.i, <4 x i64> %0, <4 x i64> zeroinitializer
  ret <4 x i64> %2
}

define <2 x i64> @test_mm_madd52lo_epu64(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z) {
; CHECK-LABEL: test_mm_madd52lo_epu64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z)
  ret <2 x i64> %0
}

define <2 x i64> @test_mm_mask_madd52lo_epu64(<2 x i64> %__W, i8 zeroext %__M, <2 x i64> %__X, <2 x i64> %__Y) {
; X86-LABEL: test_mm_mask_madd52lo_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm_mask_madd52lo_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1}
; X64-NEXT:    retq
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64> %__W, <2 x i64> %__X, <2 x i64> %__Y)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <2 x i32> <i32 0, i32 1>
  %2 = select <2 x i1> %extract.i, <2 x i64> %0, <2 x i64> %__W
  ret <2 x i64> %2
}

define <2 x i64> @test_mm_maskz_madd52lo_epu64(i8 zeroext %__M, <2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z) {
; X86-LABEL: test_mm_maskz_madd52lo_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm_maskz_madd52lo_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52luq %xmm2, %xmm1, %xmm0 {%k1} {z}
; X64-NEXT:    retq
entry:
  %0 = tail call <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64> %__X, <2 x i64> %__Y, <2 x i64> %__Z)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <2 x i32> <i32 0, i32 1>
  %2 = select <2 x i1> %extract.i, <2 x i64> %0, <2 x i64> zeroinitializer
  ret <2 x i64> %2
}

define <4 x i64> @test_mm256_madd52lo_epu64(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z) {
; CHECK-LABEL: test_mm256_madd52lo_epu64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z)
  ret <4 x i64> %0
}

define <4 x i64> @test_mm256_mask_madd52lo_epu64(<4 x i64> %__W, i8 zeroext %__M, <4 x i64> %__X, <4 x i64> %__Y) {
; X86-LABEL: test_mm256_mask_madd52lo_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm256_mask_madd52lo_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1}
; X64-NEXT:    retq
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64> %__W, <4 x i64> %__X, <4 x i64> %__Y)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = select <4 x i1> %extract.i, <4 x i64> %0, <4 x i64> %__W
  ret <4 x i64> %2
}

define <4 x i64> @test_mm256_maskz_madd52lo_epu64(i8 zeroext %__M, <4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z) {
; X86-LABEL: test_mm256_maskz_madd52lo_epu64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    kmovw %eax, %k1
; X86-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1} {z}
; X86-NEXT:    retl
;
; X64-LABEL: test_mm256_maskz_madd52lo_epu64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpmadd52luq %ymm2, %ymm1, %ymm0 {%k1} {z}
; X64-NEXT:    retq
entry:
  %0 = tail call <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64> %__X, <4 x i64> %__Y, <4 x i64> %__Z)
  %1 = bitcast i8 %__M to <8 x i1>
  %extract.i = shufflevector <8 x i1> %1, <8 x i1> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = select <4 x i1> %extract.i, <4 x i64> %0, <4 x i64> zeroinitializer
  ret <4 x i64> %2
}

declare <2 x i64> @llvm.x86.avx512.vpmadd52h.uq.128(<2 x i64>, <2 x i64>, <2 x i64>)
declare <4 x i64> @llvm.x86.avx512.vpmadd52h.uq.256(<4 x i64>, <4 x i64>, <4 x i64>)
declare <2 x i64> @llvm.x86.avx512.vpmadd52l.uq.128(<2 x i64>, <2 x i64>, <2 x i64>)
declare <4 x i64> @llvm.x86.avx512.vpmadd52l.uq.256(<4 x i64>, <4 x i64>, <4 x i64>)
