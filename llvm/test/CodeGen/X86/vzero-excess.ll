; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s

; In the following 4 tests, the existing call to VZU/VZA ensures clean state before
; the call to the unknown, so we don't need to insert a second VZU at that point.

define <4 x float> @zeroupper_v4f32(ptr%x, <8 x float> %y) nounwind {
; CHECK-LABEL: zeroupper_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $32, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vaddps (%rbx), %ymm0, %ymm0
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    addq $32, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroupper()
  call void @the_unknown()
  %loadx = load <8 x float>, ptr%x, align 32
  %sum = fadd <8 x float> %loadx, %y
  %lo = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %hi = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %res = fadd <4 x float> %lo, %hi
  ret <4 x float> %res
}

define <8 x float> @zeroupper_v8f32(<8 x float> %x) nounwind {
; CHECK-LABEL: zeroupper_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroupper()
  call void @the_unknown()
  ret <8 x float> %x
}

define <4 x float> @zeroall_v4f32(ptr%x, <8 x float> %y) nounwind {
; CHECK-LABEL: zeroall_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $32, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    vzeroall
; CHECK-NEXT:    callq the_unknown@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vaddps (%rbx), %ymm0, %ymm0
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    addq $32, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroall()
  call void @the_unknown()
  %loadx = load <8 x float>, ptr%x, align 32
  %sum = fadd <8 x float> %loadx, %y
  %lo = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %hi = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %res = fadd <4 x float> %lo, %hi
  ret <4 x float> %res
}

define <8 x float> @zeroall_v8f32(<8 x float> %x) nounwind {
; CHECK-LABEL: zeroall_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vzeroall
; CHECK-NEXT:    callq the_unknown@PLT
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroall()
  call void @the_unknown()
  ret <8 x float> %x
}

declare void @llvm.x86.avx.vzeroupper() nounwind readnone
declare void @llvm.x86.avx.vzeroall() nounwind readnone
declare void @the_unknown() nounwind

