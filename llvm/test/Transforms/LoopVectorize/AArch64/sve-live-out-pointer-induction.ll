; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-vectorize -mtriple=aarch64-unknown -mattr=+sve -S %s | FileCheck %s

define ptr @test(ptr %start.1, ptr %start.2, ptr %end) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[START_22:%.*]] = ptrtoint ptr [[START_2:%.*]] to i64
; CHECK-NEXT:    [[END1:%.*]] = ptrtoint ptr [[END:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[END1]], -8
; CHECK-NEXT:    [[TMP1:%.*]] = sub i64 [[TMP0]], [[START_22]]
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 4
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP3]], [[TMP5]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP6:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP7:%.*]] = mul i64 [[TMP6]], 4
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP3]], [[TMP7]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP3]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[N_VEC]], 8
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[START_1:%.*]], i64 [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = mul i64 [[N_VEC]], 8
; CHECK-NEXT:    [[IND_END3:%.*]] = getelementptr i8, ptr [[START_2]], i64 [[TMP9]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[POINTER_PHI:%.*]] = phi ptr [ [[START_1]], [[VECTOR_PH]] ], [ [[PTR_IND:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP11:%.*]] = mul i64 [[TMP10]], 2
; CHECK-NEXT:    [[TMP12:%.*]] = mul i64 [[TMP11]], 2
; CHECK-NEXT:    [[TMP13:%.*]] = mul i64 8, [[TMP12]]
; CHECK-NEXT:    [[TMP14:%.*]] = mul i64 [[TMP11]], 0
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[TMP14]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP15:%.*]] = call <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()
; CHECK-NEXT:    [[TMP16:%.*]] = add <vscale x 2 x i64> [[DOTSPLAT]], [[TMP15]]
; CHECK-NEXT:    [[VECTOR_GEP:%.*]] = mul <vscale x 2 x i64> [[TMP16]], shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 8, i32 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr i8, ptr [[POINTER_PHI]], <vscale x 2 x i64> [[VECTOR_GEP]]
; CHECK-NEXT:    [[TMP18:%.*]] = mul i64 [[TMP11]], 1
; CHECK-NEXT:    [[DOTSPLATINSERT5:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[TMP18]], i32 0
; CHECK-NEXT:    [[DOTSPLAT6:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT5]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP19:%.*]] = call <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()
; CHECK-NEXT:    [[TMP20:%.*]] = add <vscale x 2 x i64> [[DOTSPLAT6]], [[TMP19]]
; CHECK-NEXT:    [[VECTOR_GEP7:%.*]] = mul <vscale x 2 x i64> [[TMP20]], shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 8, i32 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr i8, ptr [[POINTER_PHI]], <vscale x 2 x i64> [[VECTOR_GEP7]]
; CHECK-NEXT:    [[TMP22:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP23:%.*]] = mul i64 [[TMP22]], 8
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[START_2]], i64 [[TMP23]]
; CHECK-NEXT:    [[TMP24:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP25:%.*]] = mul i64 [[TMP24]], 2
; CHECK-NEXT:    [[TMP26:%.*]] = add i64 [[TMP25]], 0
; CHECK-NEXT:    [[TMP27:%.*]] = add i64 [[INDEX]], [[TMP26]]
; CHECK-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 8
; CHECK-NEXT:    [[NEXT_GEP8:%.*]] = getelementptr i8, ptr [[START_2]], i64 [[TMP28]]
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr i64, ptr [[NEXT_GEP]], i32 0
; CHECK-NEXT:    store <vscale x 2 x i64> zeroinitializer, ptr [[TMP29]], align 4
; CHECK-NEXT:    [[TMP30:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP31:%.*]] = mul i32 [[TMP30]], 2
; CHECK-NEXT:    [[TMP32:%.*]] = getelementptr i64, ptr [[NEXT_GEP]], i32 [[TMP31]]
; CHECK-NEXT:    store <vscale x 2 x i64> zeroinitializer, ptr [[TMP32]], align 4
; CHECK-NEXT:    [[TMP33:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP34:%.*]] = mul i64 [[TMP33]], 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP34]]
; CHECK-NEXT:    [[PTR_IND]] = getelementptr i8, ptr [[POINTER_PHI]], i64 [[TMP13]]
; CHECK-NEXT:    [[TMP35:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP35]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP3]], [[N_VEC]]
; CHECK-NEXT:    [[CAST_CMO:%.*]] = sub i64 [[N_VEC]], 1
; CHECK-NEXT:    [[TMP36:%.*]] = mul i64 [[CAST_CMO]], 8
; CHECK-NEXT:    [[IND_ESCAPE:%.*]] = getelementptr i8, ptr [[START_1]], i64 [[TMP36]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START_1]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL4:%.*]] = phi ptr [ [[IND_END3]], [[MIDDLE_BLOCK]] ], [ [[START_2]], [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV_1:%.*]] = phi ptr [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_1_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_2:%.*]] = phi ptr [ [[BC_RESUME_VAL4]], [[SCALAR_PH]] ], [ [[IV_2_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    store i64 0, ptr [[IV_2]], align 4
; CHECK-NEXT:    [[IV_2_NEXT]] = getelementptr inbounds ptr, ptr [[IV_2]], i64 1
; CHECK-NEXT:    [[IV_1_NEXT]] = getelementptr inbounds ptr, ptr [[IV_1]], i64 1
; CHECK-NEXT:    [[CMP_I_I_NOT_I:%.*]] = icmp eq ptr [[IV_2_NEXT]], [[END]]
; CHECK-NEXT:    br i1 [[CMP_I_I_NOT_I]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[RES_LCSSA:%.*]] = phi ptr [ [[IV_1]], [[LOOP]] ], [ [[IND_ESCAPE]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret ptr [[RES_LCSSA]]
;
entry:
  br label %loop

loop:
  %iv.1 = phi ptr [ %start.1, %entry ], [ %iv.1.next, %loop ]
  %iv.2 = phi ptr [ %start.2, %entry ], [ %iv.2.next, %loop ]
  store i64 0, ptr %iv.2
  %iv.2.next = getelementptr inbounds ptr, ptr %iv.2, i64 1
  %iv.1.next = getelementptr inbounds ptr, ptr %iv.1, i64 1
  %cmp.i.i.not.i = icmp eq ptr %iv.2.next, %end
  br i1 %cmp.i.i.not.i, label %exit, label %loop

exit:
  %res.lcssa = phi ptr [ %iv.1, %loop ]
  ret ptr %res.lcssa
}
