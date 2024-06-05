; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -passes=instcombine  -S | FileCheck %s

define void @test1(ptr %a, ptr readnone %a_end, ptr %b.i64) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B:%.*]] = load i64, ptr [[B_I64:%.*]], align 8
; CHECK-NEXT:    [[B_PTR:%.*]] = inttoptr i64 [[B]] to ptr
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi ptr [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B_PTR]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[I1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, ptr [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, ptr %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi ptr [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to ptr
  %i1 = load float, ptr %tmp, align 4
  %mul.i = fmul float %i1, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %add = getelementptr inbounds float, ptr %tmp, i64 1
  %add.int = ptrtoint ptr %add to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @test1_neg(ptr %a, ptr readnone %a_end, ptr %b.i64) {
; CHECK-LABEL: @test1_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B:%.*]] = load i64, ptr [[B_I64:%.*]], align 8
; CHECK-NEXT:    [[TMP0:%.*]] = inttoptr i64 [[B]] to ptr
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[BB:%.*]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02:%.*]] = phi ptr [ [[ADD:%.*]], [[BB]] ], [ [[TMP0]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PTRCMP:%.*]] = icmp ult ptr [[B_ADDR_02]], [[A_END]]
; CHECK-NEXT:    br i1 [[PTRCMP]], label [[FOR_END]], label [[BB]]
; CHECK:       bb:
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr [[A]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[I1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, ptr [[A]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, ptr %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi ptr [ %incdec.ptr, %bb ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %bb ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to ptr
  %ptrcmp = icmp ult ptr %tmp, %a_end
  br i1 %ptrcmp, label %for.end, label %bb

bb:
  %i1 = load float, ptr %a, align 4
  %mul.i = fmul float %i1, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %add = getelementptr inbounds float, ptr %a, i64 1
  %add.int = ptrtoint ptr %add to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test2(ptr %a, ptr readnone %a_end, ptr %b.float) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B:%.*]] = load i64, ptr [[B_FLOAT:%.*]], align 8
; CHECK-NEXT:    [[B_PTR:%.*]] = inttoptr i64 [[B]] to ptr
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi ptr [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B_PTR]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[I1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, ptr [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, ptr %b.float, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi ptr [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to ptr
  %i1 = load float, ptr %tmp, align 4
  %mul.i = fmul float %i1, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %add = getelementptr inbounds float, ptr %tmp, i64 1
  %add.int = ptrtoint ptr %add to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test3(ptr %a, ptr readnone %a_end, ptr %b.i8p) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B:%.*]] = load i64, ptr [[B_I8P:%.*]], align 8
; CHECK-NEXT:    [[B_PTR:%.*]] = inttoptr i64 [[B]] to ptr
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi ptr [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B_PTR]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[I1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, ptr [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, ptr %b.i8p, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi ptr [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to ptr
  %i1 = load float, ptr %tmp, align 4
  %mul.i = fmul float %i1, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %add = getelementptr inbounds float, ptr %tmp, i64 1
  %add.int = ptrtoint ptr %add to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test4(ptr %a, ptr readnone %a_end, ptr %b.float) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B_F:%.*]] = load ptr, ptr [[B_FLOAT:%.*]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_IN:%.*]] = phi ptr [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B_F]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I1:%.*]] = load float, ptr [[B_ADDR_02_IN]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[I1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, ptr [[B_ADDR_02_IN]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b.f = load ptr, ptr %b.float, align 8
  %b = ptrtoint ptr %b.f to i64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi ptr [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]
  %tmp = inttoptr i64 %b.addr.02 to ptr
  %i1 = load float, ptr %tmp, align 4
  %mul.i = fmul float %i1, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %add = getelementptr inbounds float, ptr %tmp, i64 1
  %add.int = ptrtoint ptr %add to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}