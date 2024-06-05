; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -verify-scev -passes='loop(require<iv-users>),loop-mssa(loop-simplifycfg)' -S %s | FileCheck %s

target datalayout = "p:16:16-n16:32"

define void @test_pr58179_remove_dead_block_from_loop() {
; CHECK-LABEL: @test_pr58179_remove_dead_block_from_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca [10 x i64], align 1
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    br label [[OUTER_HEADER]]
;
entry:
  %a = alloca [10 x i64], align 1
  br label %outer.header

outer.header:
  br i1 false, label %inner, label %outer.header

inner:
  %iv = phi i16 [ 0, %outer.header ], [ %iv.next, %inner ]
  %gep = getelementptr inbounds [10 x i64], ptr %a, i32 0, i16 %iv
  store i64 0, ptr %gep
  %iv.next = add nsw i16 %iv, 1
  br i1 false, label %inner, label %outer.header
}

define void @test_remove_instrs_in_exit_block() {
; CHECK-LABEL: @test_remove_instrs_in_exit_block(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca [10 x i64], align 1
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[OUTER_IV:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[OUTER_IV_NEXT:%.*]], [[OUTER_LATCH:%.*]] ]
; CHECK-NEXT:    switch i32 0, label [[OUTER_HEADER_SPLIT:%.*]] [
; CHECK-NEXT:    i32 1, label [[OUTER_LATCH]]
; CHECK-NEXT:    ]
; CHECK:       outer.header.split:
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 0, [[OUTER_HEADER_SPLIT]] ], [ [[IV_NEXT:%.*]], [[INNER]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [10 x i64], ptr [[A]], i32 0, i16 [[IV]]
; CHECK-NEXT:    store i64 0, ptr [[GEP]], align 4
; CHECK-NEXT:    [[L:%.*]] = call i16 @get()
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i16 [[IV]], 1
; CHECK-NEXT:    br label [[INNER]]
; CHECK:       outer.latch:
; CHECK-NEXT:    [[OUTER_IV_NEXT]] = add nsw i16 [[OUTER_IV]], 1
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp eq i16 poison, [[OUTER_IV]]
; CHECK-NEXT:    br i1 [[CMP_2]], label [[OUTER_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca [10 x i64], align 1
  br label %outer.header

outer.header:
  %outer.iv = phi i16 [ 0, %entry ], [ %outer.iv.next, %outer.latch ]
  br label %inner

inner:
  %iv = phi i16 [ 0, %outer.header ], [ %iv.next, %inner ]
  %gep = getelementptr inbounds [10 x i64], ptr %a, i32 0, i16 %iv
  store i64 0, ptr %gep
  %l = call i16 @get()
  %iv.next = add nsw i16 %iv, 1
  br i1 true, label %inner, label %outer.latch

outer.latch:
  %l.lcssa = phi i16 [ %l, %inner ]
  %outer.iv.next = add nsw i16 %outer.iv, 1
  %cmp.2 = icmp eq i16 %l.lcssa, %outer.iv
  br i1 %cmp.2, label %outer.header, label %exit

exit:
  ret void
}

declare i16 @get()