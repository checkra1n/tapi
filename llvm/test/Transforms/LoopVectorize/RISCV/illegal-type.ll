; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-vectorize -mattr=+v -force-vector-width=4 -scalable-vectorization=on -S 2>&1 | FileCheck %s
target triple = "riscv64-linux-gnu"

;
define dso_local void @loop_i128(i128* nocapture %ptr, i64 %N) {
; CHECK-LABEL: @loop_i128(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i128, i128* [[PTR:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i128, i128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i128 [[TMP0]], 42
; CHECK-NEXT:    store i128 [[ADD]], i128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, i128* %ptr, i64 %iv
  %0 = load i128, i128* %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, i128* %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define dso_local void @loop_f128(fp128* nocapture %ptr, i64 %N) {
; CHECK-LABEL: @loop_f128(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds fp128, fp128* [[PTR:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = load fp128, fp128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[ADD:%.*]] = fsub fp128 [[TMP0]], 0xL00000000000000008000000000000000
; CHECK-NEXT:    store fp128 [[ADD]], fp128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]], !llvm.loop [[LOOP0]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds fp128, fp128* %ptr, i64 %iv
  %0 = load fp128, fp128* %arrayidx, align 16
  %add = fsub fp128 %0, 0xL00000000000000008000000000000000
  store fp128 %add, fp128* %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define dso_local void @loop_invariant_i128(i128* nocapture %ptr, i128 %val, i64 %N) {
; CHECK-LABEL: @loop_invariant_i128(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i128, i128* [[PTR:%.*]], i64 [[IV]]
; CHECK-NEXT:    store i128 [[VAL:%.*]], i128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]], !llvm.loop [[LOOP0]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, i128* %ptr, i64 %iv
  store i128 %val, i128* %arrayidx, align 16
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !0

for.end:
  ret void
}

define void @uniform_store_i1(i1* noalias %dst, i64* noalias %start, i64 %N) {
; CHECK-LABEL: @uniform_store_i1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[N:%.*]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP0]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i64, i64* [[START:%.*]], i64 [[N_VEC]]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <2 x i64*> poison, i64* [[START]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <2 x i64*> [[BROADCAST_SPLATINSERT]], <2 x i64*> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT3:%.*]] = insertelement <2 x i64*> poison, i64* [[START]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT4:%.*]] = shufflevector <2 x i64*> [[BROADCAST_SPLATINSERT3]], <2 x i64*> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[POINTER_PHI:%.*]] = phi i64* [ [[START]], [[VECTOR_PH]] ], [ [[PTR_IND:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i64, i64* [[POINTER_PHI]], <2 x i64> <i64 0, i64 1>
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i64, i64* [[POINTER_PHI]], <2 x i64> <i64 2, i64 3>
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x i64*> [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i64* [[TMP4]] to <2 x i64>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x i64>, <2 x i64>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[TMP3]], i32 2
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i64* [[TMP6]] to <2 x i64>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <2 x i64>, <2 x i64>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i64, <2 x i64*> [[TMP1]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i64, <2 x i64*> [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq <2 x i64*> [[TMP8]], [[BROADCAST_SPLAT]]
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq <2 x i64*> [[TMP9]], [[BROADCAST_SPLAT4]]
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x i1> [[TMP11]], i32 1
; CHECK-NEXT:    store i1 [[TMP12]], i1* [[DST:%.*]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[PTR_IND]] = getelementptr i64, i64* [[POINTER_PHI]], i64 4
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP13]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64* [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[FIRST_SROA:%.*]] = phi i64* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[TMP14:%.*]] = load i64, i64* [[FIRST_SROA]], align 4
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i64, i64* [[FIRST_SROA]], i64 1
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i64* [[INCDEC_PTR]], [[START]]
; CHECK-NEXT:    store i1 [[CMP_NOT]], i1* [[DST]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %first.sroa = phi i64* [ %incdec.ptr, %for.body ], [ %start, %entry ]
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i64 %iv, 1
  %0 = load i64, i64* %first.sroa
  %incdec.ptr = getelementptr inbounds i64, i64* %first.sroa, i64 1
  %cmp.not = icmp eq i64* %incdec.ptr, %start
  store i1 %cmp.not, i1* %dst
  %cmp = icmp ult i64 %iv, %N
  br i1 %cmp, label %for.body, label %end, !llvm.loop !0

end:
  ret void
}

define dso_local void @loop_fixed_width_i128(i128* nocapture %ptr, i64 %N) {
; CHECK-LABEL: @loop_fixed_width_i128(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i128, i128* [[PTR:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i128, i128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i128 [[TMP0]], 42
; CHECK-NEXT:    store i128 [[ADD]], i128* [[ARRAYIDX]], align 16
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i128, i128* %ptr, i64 %iv
  %0 = load i128, i128* %arrayidx, align 16
  %add = add nsw i128 %0, 42
  store i128 %add, i128* %arrayidx, align 16
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %for.end, label %for.body

for.end:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.scalable.enable", i1 true}