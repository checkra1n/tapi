; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512f | FileCheck %s --check-prefixes=CHECK
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512f,+avx512vl | FileCheck %s --check-prefixes=CHECK

; Try to ensure that vselect folds into any previous instruction.
; Shuffle lowering can widen the select mask preventing it being used as a predicate mask move.

define void @PR46249(ptr noalias nocapture noundef %0) {
; CHECK-LABEL: PR46249:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovdqu64 (%rdi), %zmm0
; CHECK-NEXT:    vpshufd {{.*#+}} zmm1 = zmm0[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
; CHECK-NEXT:    vpminsd %zmm0, %zmm1, %zmm2
; CHECK-NEXT:    movw $-21846, %ax # imm = 0xAAAA
; CHECK-NEXT:    kmovw %eax, %k1
; CHECK-NEXT:    vpmaxsd %zmm0, %zmm1, %zmm2 {%k1}
; CHECK-NEXT:    vpshufd {{.*#+}} zmm0 = zmm2[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vshufps {{.*#+}} zmm2 = zmm1[0,1],zmm0[2,3],zmm1[4,5],zmm0[6,7],zmm1[8,9],zmm0[10,11],zmm1[12,13],zmm0[14,15]
; CHECK-NEXT:    vshufps {{.*#+}} zmm0 = zmm1[1,0],zmm0[3,2],zmm1[5,4],zmm0[7,6],zmm1[9,8],zmm0[11,10],zmm1[13,12],zmm0[15,14]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm1 {%k1}
; CHECK-NEXT:    vpshufd {{.*#+}} zmm0 = zmm1[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    vpermq {{.*#+}} zmm0 = zmm0[2,3,0,1,6,7,4,5]
; CHECK-NEXT:    vpminsd %zmm1, %zmm0, %zmm2
; CHECK-NEXT:    movw $-3856, %ax # imm = 0xF0F0
; CHECK-NEXT:    kmovw %eax, %k2
; CHECK-NEXT:    vpmaxsd %zmm1, %zmm0, %zmm2 {%k2}
; CHECK-NEXT:    vpshufd {{.*#+}} zmm0 = zmm2[2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vshufps {{.*#+}} zmm2 = zmm1[0,1],zmm0[2,3],zmm1[4,5],zmm0[6,7],zmm1[8,9],zmm0[10,11],zmm1[12,13],zmm0[14,15]
; CHECK-NEXT:    vshufps {{.*#+}} zmm0 = zmm1[1,0],zmm0[3,2],zmm1[5,4],zmm0[7,6],zmm1[9,8],zmm0[11,10],zmm1[13,12],zmm0[15,14]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm1 {%k1}
; CHECK-NEXT:    vpshufd {{.*#+}} zmm0 = zmm1[3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12]
; CHECK-NEXT:    vshufi64x2 {{.*#+}} zmm0 = zmm0[4,5,6,7,0,1,2,3]
; CHECK-NEXT:    vpminsd %zmm1, %zmm0, %zmm2
; CHECK-NEXT:    vpmaxsd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    vshufi64x2 {{.*#+}} zmm1 = zmm2[2,3,0,1],zmm0[6,7,4,5]
; CHECK-NEXT:    vshufi64x2 {{.*#+}} zmm0 = zmm2[0,1,2,3],zmm0[4,5,6,7]
; CHECK-NEXT:    vpminsd %zmm0, %zmm1, %zmm2
; CHECK-NEXT:    vpmaxsd %zmm0, %zmm1, %zmm2 {%k2}
; CHECK-NEXT:    vpshufd {{.*#+}} zmm0 = zmm2[2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm0
; CHECK-NEXT:    vshufps {{.*#+}} zmm2 = zmm1[0,1],zmm0[2,3],zmm1[4,5],zmm0[6,7],zmm1[8,9],zmm0[10,11],zmm1[12,13],zmm0[14,15]
; CHECK-NEXT:    vshufps {{.*#+}} zmm0 = zmm1[1,0],zmm0[3,2],zmm1[5,4],zmm0[7,6],zmm1[9,8],zmm0[11,10],zmm1[13,12],zmm0[15,14]
; CHECK-NEXT:    vpminsd %zmm2, %zmm0, %zmm1
; CHECK-NEXT:    vpmaxsd %zmm2, %zmm0, %zmm1 {%k1}
; CHECK-NEXT:    vmovdqu64 %zmm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %2 = load <16 x i32>, ptr %0, align 1
  %3 = shufflevector <16 x i32> %2, <16 x i32> poison, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %4 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %3, <16 x i32> %2) #2
  %5 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %3, <16 x i32> %2) #2
  %6 = shufflevector <16 x i32> %4, <16 x i32> %5, <16 x i32> <i32 0, i32 17, i32 2, i32 19, i32 4, i32 21, i32 6, i32 23, i32 8, i32 25, i32 10, i32 27, i32 12, i32 29, i32 14, i32 31>
  %7 = shufflevector <16 x i32> %6, <16 x i32> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %8 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %7, <16 x i32> %6) #2
  %9 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %7, <16 x i32> %6) #2
  %10 = shufflevector <16 x i32> %8, <16 x i32> %9, <16 x i32> <i32 0, i32 1, i32 18, i32 19, i32 4, i32 5, i32 22, i32 23, i32 8, i32 9, i32 26, i32 27, i32 12, i32 13, i32 30, i32 31>
  %11 = shufflevector <16 x i32> %10, <16 x i32> poison, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %12 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %11, <16 x i32> %10) #2
  %13 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %11, <16 x i32> %10) #2
  %14 = shufflevector <16 x i32> %12, <16 x i32> %13, <16 x i32> <i32 0, i32 17, i32 2, i32 19, i32 4, i32 21, i32 6, i32 23, i32 8, i32 25, i32 10, i32 27, i32 12, i32 29, i32 14, i32 31>
  %15 = shufflevector <16 x i32> %14, <16 x i32> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %16 = shufflevector <16 x i32> %15, <16 x i32> poison, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11>
  %17 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %16, <16 x i32> %14) #2
  %18 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %16, <16 x i32> %14) #2
  %19 = shufflevector <16 x i32> %17, <16 x i32> %18, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 20, i32 21, i32 22, i32 23, i32 8, i32 9, i32 10, i32 11, i32 28, i32 29, i32 30, i32 31>
  %20 = shufflevector <16 x i32> %19, <16 x i32> poison, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %21 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %20, <16 x i32> %19) #2
  %22 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %20, <16 x i32> %19) #2
  %23 = shufflevector <16 x i32> %21, <16 x i32> %22, <16 x i32> <i32 0, i32 1, i32 18, i32 19, i32 4, i32 5, i32 22, i32 23, i32 8, i32 9, i32 26, i32 27, i32 12, i32 13, i32 30, i32 31>
  %24 = shufflevector <16 x i32> %23, <16 x i32> poison, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %25 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %24, <16 x i32> %23) #2
  %26 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %24, <16 x i32> %23) #2
  %27 = shufflevector <16 x i32> %25, <16 x i32> %26, <16 x i32> <i32 0, i32 17, i32 2, i32 19, i32 4, i32 21, i32 6, i32 23, i32 8, i32 25, i32 10, i32 27, i32 12, i32 29, i32 14, i32 31>
  %28 = shufflevector <16 x i32> %27, <16 x i32> poison, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  %29 = shufflevector <16 x i32> %28, <16 x i32> poison, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %30 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %29, <16 x i32> %27) #2
  %31 = bitcast <16 x i32> %30 to <8 x i64>
  %32 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %29, <16 x i32> %27) #2
  %33 = bitcast <16 x i32> %32 to <8 x i64>
  %34 = shufflevector <8 x i64> %31, <8 x i64> %33, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
  %35 = shufflevector <8 x i64> %31, <8 x i64> %33, <8 x i32> <i32 2, i32 3, i32 0, i32 1, i32 14, i32 15, i32 12, i32 13>
  %36 = bitcast <8 x i64> %35 to <16 x i32>
  %37 = bitcast <8 x i64> %34 to <16 x i32>
  %38 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %36, <16 x i32> %37) #2
  %39 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %36, <16 x i32> %37) #2
  %40 = shufflevector <16 x i32> %38, <16 x i32> %39, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 20, i32 21, i32 22, i32 23, i32 8, i32 9, i32 10, i32 11, i32 28, i32 29, i32 30, i32 31>
  %41 = shufflevector <16 x i32> %40, <16 x i32> poison, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %42 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %41, <16 x i32> %40) #2
  %43 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %41, <16 x i32> %40) #2
  %44 = shufflevector <16 x i32> %42, <16 x i32> %43, <16 x i32> <i32 0, i32 1, i32 18, i32 19, i32 4, i32 5, i32 22, i32 23, i32 8, i32 9, i32 26, i32 27, i32 12, i32 13, i32 30, i32 31>
  %45 = shufflevector <16 x i32> %44, <16 x i32> poison, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %46 = tail call <16 x i32> @llvm.smin.v16i32(<16 x i32> %45, <16 x i32> %44) #2
  %47 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %45, <16 x i32> %44) #2
  %48 = shufflevector <16 x i32> %46, <16 x i32> %47, <16 x i32> <i32 0, i32 17, i32 2, i32 19, i32 4, i32 21, i32 6, i32 23, i32 8, i32 25, i32 10, i32 27, i32 12, i32 29, i32 14, i32 31>
  store <16 x i32> %48, ptr %0, align 1
  ret void
}
declare <16 x i32> @llvm.smin.v16i32(<16 x i32>, <16 x i32>)
declare <16 x i32> @llvm.smax.v16i32(<16 x i32>, <16 x i32>)
