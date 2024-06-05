; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -verify -iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; When consolidating PHINodes, the outliner replaces the incoming value with
; a corresponding value from the first outlined section.  When this replaced
; value is passed in as an argument, the corresponding value is found outside
; of the outlined region, and must be replaced with an argument to avoid
; dominating value errors. This checks that we use the argument to replace
; the incoming value.

define void @func1(i32 %0, i32 %1) local_unnamed_addr #0 {
bb1:
  br label %bb5

bb2:
  %a = add i32 %0, %1
  %b = add i32 %0, %1
  %c = icmp eq i32 %b, %a
  br i1 %c, label %bb5, label %bb3

bb3:
  %d = add i32 %0, %1
  br label %bb5

bb4:
  %e = sub i32 %0, %1
  br label %bb2

bb5:
  ret void
}

define void @func2(i32 %0, i32 %1) local_unnamed_addr #0 {
bb1:
  br label %bb5

bb2:
  %a = sub i32 %0, %1
  %b = add i32 %0, %1
  %c = icmp eq i32 %b, 1
  br i1 %c, label %bb5, label %bb3

bb3:
  %d = add i32 %0, %1
  br label %bb5

bb4:
  %e = add i32 %0, %1
  br label %bb2

bb5:
  %f = phi i32 [ 0, %bb1 ], [ 1, %bb2 ], [ 1, %bb3 ]
  ret void
}
; CHECK-LABEL: @func1(
; CHECK-NEXT:  bb1:
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[A:%.*]] = add i32 [[TMP0:%.*]], [[TMP1:%.*]]
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 [[TMP0]], i32 [[TMP1]], i32 [[A]], ptr null, i32 -1)
; CHECK-NEXT:    br label [[BB5]]
; CHECK:       bb4:
; CHECK-NEXT:    [[E:%.*]] = sub i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @func2(
; CHECK-NEXT:  bb1:
; CHECK-NEXT:    [[F_CE_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[A:%.*]] = sub i32 [[TMP0:%.*]], [[TMP1:%.*]]
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[F_CE_LOC]])
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 [[TMP0]], i32 [[TMP1]], i32 1, ptr [[F_CE_LOC]], i32 0)
; CHECK-NEXT:    [[F_CE_RELOAD:%.*]] = load i32, ptr [[F_CE_LOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 -1, ptr [[F_CE_LOC]])
; CHECK-NEXT:    br label [[BB5]]
; CHECK:       bb4:
; CHECK-NEXT:    [[E:%.*]] = add i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[F:%.*]] = phi i32 [ 0, [[BB1:%.*]] ], [ [[F_CE_RELOAD]], [[BB2]] ]
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[BB2_TO_OUTLINE:%.*]]
; CHECK:       bb2_to_outline:
; CHECK-NEXT:    [[B:%.*]] = add i32 [[TMP0:%.*]], [[TMP1:%.*]]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[B]], [[TMP2:%.*]]
; CHECK-NEXT:    br i1 [[C]], label [[PHI_BLOCK:%.*]], label [[BB3:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[D:%.*]] = add i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br label [[PHI_BLOCK]]
; CHECK:       bb5.exitStub:
; CHECK-NEXT:    switch i32 [[TMP4:%.*]], label [[FINAL_BLOCK_0:%.*]] [
; CHECK-NEXT:    i32 0, label [[OUTPUT_BLOCK_1_0:%.*]]
; CHECK-NEXT:    ]
; CHECK:       output_block_1_0:
; CHECK-NEXT:    store i32 [[TMP5:%.*]], ptr [[TMP3:%.*]], align 4
; CHECK-NEXT:    br label [[FINAL_BLOCK_0]]
; CHECK:       phi_block:
; CHECK-NEXT:    [[TMP5]] = phi i32 [ [[TMP2]], [[BB2_TO_OUTLINE]] ], [ [[TMP2]], [[BB3]] ]
; CHECK-NEXT:    br label [[BB5_EXITSTUB:%.*]]
; CHECK:       final_block_0:
; CHECK-NEXT:    ret void
;
