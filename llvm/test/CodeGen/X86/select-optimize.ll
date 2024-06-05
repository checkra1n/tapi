; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-unknown-unknown -select-optimize -S < %s | FileCheck %s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test base heuristic 1:
;; highly-biased selects assumed to be highly predictable, converted to branches
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; If a select is obviously predictable, turn it into a branch.
define i32 @weighted_select1(i32 %a, i32 %b, i1 %cmp) {
; CHECK-LABEL: @weighted_select1(
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_END:%.*]], label [[SELECT_FALSE:%.*]], !prof [[PROF16:![0-9]+]]
; CHECK:       select.false:
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[A:%.*]], [[TMP0:%.*]] ], [ [[B:%.*]], [[SELECT_FALSE]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !15
  ret i32 %sel
}

; If a select is obviously predictable (reversed profile weights),
; turn it into a branch.
define i32 @weighted_select2(i32 %a, i32 %b, i1 %cmp) {
; CHECK-LABEL: @weighted_select2(
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_END:%.*]], label [[SELECT_FALSE:%.*]], !prof [[PROF17:![0-9]+]]
; CHECK:       select.false:
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[A:%.*]], [[TMP0:%.*]] ], [ [[B:%.*]], [[SELECT_FALSE]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !16
  ret i32 %sel
}

; Not obvioulsy predictable select.
define i32 @weighted_select3(i32 %a, i32 %b, i1 %cmp) {
; CHECK-LABEL: @weighted_select3(
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[A:%.*]], i32 [[B:%.*]], !prof [[PROF18:![0-9]+]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !17
  ret i32 %sel
}

; Unpredictable select should not form a branch.
define i32 @unpred_select(i32 %a, i32 %b, i1 %cmp) {
; CHECK-LABEL: @unpred_select(
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[A:%.*]], i32 [[B:%.*]], !unpredictable !19
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !unpredictable !20
  ret i32 %sel
}

; Predictable select in function with optsize attribute should not form branch.
define i32 @weighted_select_optsize(i32 %a, i32 %b, i1 %cmp) optsize {
; CHECK-LABEL: @weighted_select_optsize(
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[A:%.*]], i32 [[B:%.*]], !prof [[PROF16]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !15
  ret i32 %sel
}

define i32 @weighted_select_pgso(i32 %a, i32 %b, i1 %cmp) !prof !14 {
; CHECK-LABEL: @weighted_select_pgso(
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[A:%.*]], i32 [[B:%.*]], !prof [[PROF16]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !15
  ret i32 %sel
}

; If two selects in a row are predictable, turn them into branches.
define i32 @weighted_selects(i32 %a, i32 %b) !prof !19 {
; CHECK-LABEL: @weighted_selects(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[A:%.*]], 0
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_END:%.*]], label [[SELECT_FALSE:%.*]], !prof [[PROF16]]
; CHECK:       select.false:
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[A]], [[TMP0:%.*]] ], [ [[B:%.*]], [[SELECT_FALSE]] ]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ne i32 [[SEL]], 0
; CHECK-NEXT:    [[SEL1_FROZEN:%.*]] = freeze i1 [[CMP1]]
; CHECK-NEXT:    br i1 [[SEL1_FROZEN]], label [[SELECT_END1:%.*]], label [[SELECT_FALSE2:%.*]], !prof [[PROF16]]
; CHECK:       select.false2:
; CHECK-NEXT:    br label [[SELECT_END1]]
; CHECK:       select.end1:
; CHECK-NEXT:    [[SEL1:%.*]] = phi i32 [ [[B]], [[SELECT_END]] ], [ [[A]], [[SELECT_FALSE2]] ]
; CHECK-NEXT:    ret i32 [[SEL1]]
;
  %cmp = icmp ne i32 %a, 0
  %sel = select i1 %cmp, i32 %a, i32 %b, !prof !15
  %cmp1 = icmp ne i32 %sel, 0
  %sel1 = select i1 %cmp1, i32 %b, i32 %a, !prof !15
  ret i32 %sel1
}

; If select group predictable, turn it into a branch.
define i32 @weighted_select_group(i32 %a, i32 %b, i32 %c, i1 %cmp) !prof !19 {
; CHECK-LABEL: @weighted_select_group(
; CHECK-NEXT:    [[A1:%.*]] = add i32 [[A:%.*]], 1
; CHECK-NEXT:    [[SEL1_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL1_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_FALSE_SINK:%.*]], !prof [[PROF16]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[C1:%.*]] = add i32 [[C:%.*]], 1
; CHECK-NEXT:    br label [[SELECT_END:%.*]]
; CHECK:       select.false.sink:
; CHECK-NEXT:    [[B1:%.*]] = add i32 [[B:%.*]], 1
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL1:%.*]] = phi i32 [ [[A1]], [[SELECT_TRUE_SINK]] ], [ [[B1]], [[SELECT_FALSE_SINK]] ]
; CHECK-NEXT:    [[SEL2:%.*]] = phi i32 [ [[C1]], [[SELECT_TRUE_SINK]] ], [ [[A1]], [[SELECT_FALSE_SINK]] ]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[SEL1]], metadata [[META22:![0-9]+]], metadata !DIExpression()), !dbg [[DBG26:![0-9]+]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[SEL1]], [[SEL2]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %a1 = add i32 %a, 1
  %b1 = add i32 %b, 1
  %c1 = add i32 %c, 1
  %sel1 = select i1 %cmp, i32 %a1, i32 %b1, !prof !15
  call void @llvm.dbg.value(metadata i32 %sel1, metadata !24, metadata !DIExpression()), !dbg !DILocation(scope: !23)
  %sel2 = select i1 %cmp, i32 %c1, i32 %a1, !prof !15
  %add = add i32 %sel1, %sel2
  ret i32 %add
}

; Predictable select group with intra-group dependence converted to branch
define i32 @select_group_intra_group(i32 %a, i32 %b, i32 %c, i1 %cmp) {
; CHECK-LABEL: @select_group_intra_group(
; CHECK-NEXT:    [[SEL1_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL1_FROZEN]], label [[SELECT_END:%.*]], label [[SELECT_FALSE:%.*]], !prof [[PROF16]]
; CHECK:       select.false:
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL1:%.*]] = phi i32 [ [[A:%.*]], [[TMP0:%.*]] ], [ [[B:%.*]], [[SELECT_FALSE]] ]
; CHECK-NEXT:    [[SEL2:%.*]] = phi i32 [ [[C:%.*]], [[TMP0]] ], [ [[B]], [[SELECT_FALSE]] ]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[SEL1]], [[SEL2]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %sel1 = select i1 %cmp, i32 %a, i32 %b,!prof !15
  %sel2 = select i1 %cmp, i32 %c, i32 %sel1, !prof !15
  %sub = sub i32 %sel1, %sel2
  ret i32 %sub
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test base heuristic 2:
;; look for expensive instructions in the one-use slice of the cold path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Select with cold one-use load value operand should form branch and
; sink load
define i32 @expensive_val_operand1(ptr nocapture %a, i32 %y, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand1(
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END:%.*]], !prof [[PROF18]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[LOAD]], [[SELECT_TRUE_SINK]] ], [ [[Y:%.*]], [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load = load i32, ptr %a, align 8
  %sel = select i1 %cmp, i32 %load, i32 %y, !prof !17
  ret i32 %sel
}

; Expensive hot value operand and cheap cold value operand.
define i32 @expensive_val_operand2(ptr nocapture %a, i32 %x, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand2(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[X:%.*]], i32 [[LOAD]], !prof [[PROF18]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load = load i32, ptr %a, align 8
  %sel = select i1 %cmp, i32 %x, i32 %load, !prof !17
  ret i32 %sel
}

; Cold value operand with load in its one-use dependence slice should result
; into a branch with sinked dependence slice.
define i32 @expensive_val_operand3(ptr nocapture %a, i32 %b, i32 %y, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand3(
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END:%.*]], !prof [[PROF18]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    [[X:%.*]] = add i32 [[LOAD]], [[B:%.*]]
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[X]], [[SELECT_TRUE_SINK]] ], [ [[Y:%.*]], [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load = load i32, ptr %a, align 8
  %x = add i32 %load, %b
  %sel = select i1 %cmp, i32 %x, i32 %y, !prof !17
  ret i32 %sel
}

; Expensive cold value operand with unsafe-to-sink (due to func call) load (partial slice sinking).
define i32 @expensive_val_operand4(ptr nocapture %a, i32 %b, i32 %y, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand4(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    call void @free(ptr [[A]])
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END:%.*]], !prof [[PROF18]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[X:%.*]] = add i32 [[LOAD]], [[B:%.*]]
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[X]], [[SELECT_TRUE_SINK]] ], [ [[Y:%.*]], [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load = load i32, ptr %a, align 8
  call void @free(ptr %a)
  %x = add i32 %load, %b
  %sel = select i1 %cmp, i32 %x, i32 %y, !prof !17
  ret i32 %sel
}

; Expensive cold value operand with unsafe-to-sink (due to lifetime-end marker) load (partial slice sinking).
define i32 @expensive_val_operand5(ptr nocapture %a, i32 %b, i32 %y, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand5(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 2, ptr nonnull [[A]])
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END:%.*]], !prof [[PROF18]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[X:%.*]] = add i32 [[LOAD]], [[B:%.*]]
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[X]], [[SELECT_TRUE_SINK]] ], [ [[Y:%.*]], [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load = load i32, ptr %a, align 8
  call void @llvm.lifetime.end.p0(i64 2, ptr nonnull %a)
  %x = add i32 %load, %b
  %sel = select i1 %cmp, i32 %x, i32 %y, !prof !17
  ret i32 %sel
}

; Expensive cold value operand with potentially-unsafe-to-sink load (located
; in a different basic block and thus unchecked for sinkability).
define i32 @expensive_val_operand6(ptr nocapture %a, i32 %b, i32 %y, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A:%.*]], align 8
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[SEL_FROZEN:%.*]] = freeze i1 [[CMP:%.*]]
; CHECK-NEXT:    br i1 [[SEL_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END:%.*]], !prof [[PROF18]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[X:%.*]] = add i32 [[LOAD]], [[B:%.*]]
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SEL:%.*]] = phi i32 [ [[X]], [[SELECT_TRUE_SINK]] ], [ [[Y:%.*]], [[BB1]] ]
; CHECK-NEXT:    ret i32 [[SEL]]
;
entry:
  %load = load i32, ptr %a, align 8
  br label %bb1
bb1:                                 ; preds = %entry
  %x = add i32 %load, %b
  %sel = select i1 %cmp, i32 %x, i32 %y, !prof !17
  ret i32 %sel
}

; Multiple uses of the load value operand.
define i32 @expensive_val_operand7(i32 %a, ptr nocapture %b, i32 %x, i1 %cmp) {
; CHECK-LABEL: @expensive_val_operand7(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP:%.*]], i32 [[X:%.*]], i32 [[LOAD]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[SEL]], [[LOAD]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %load = load i32, ptr %b, align 4
  %sel = select i1 %cmp, i32 %x, i32 %load
  %add = add i32 %sel, %load
  ret i32 %add
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test loop heuristic: loop-level critical-path analysis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use of cmov in this test would put a load and a fsub on the critical path.
;; Loop-level analysis should decide to form a branch.
;;
;;double cmov_on_critical_path(int n, double x, ptr a) {
;;  for (int i = 0; i < n; i++) {
;;    double r = a[i];
;;    if (x > r)
;; 			// 50% of iterations
;;   		x -= r;
;;  }
;;  return x;
;;}
define double @cmov_on_critical_path(i32 %n, double %x, ptr nocapture %a) {
; CHECK-LABEL: @cmov_on_critical_path(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret double [[X:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[SELECT_END:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[X1:%.*]] = phi double [ [[X2:%.*]], [[SELECT_END]] ], [ [[X]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[R:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ogt double [[X1]], [[R]]
; CHECK-NEXT:    [[X2_FROZEN:%.*]] = freeze i1 [[CMP2]]
; CHECK-NEXT:    br i1 [[X2_FROZEN]], label [[SELECT_TRUE_SINK:%.*]], label [[SELECT_END]], !prof [[PROF27:![0-9]+]]
; CHECK:       select.true.sink:
; CHECK-NEXT:    [[SUB:%.*]] = fsub double [[X1]], [[R]]
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[X2]] = phi double [ [[SUB]], [[SELECT_TRUE_SINK]] ], [ [[X1]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_EXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.exit:
; CHECK-NEXT:    ret double [[X2]]
;
entry:
  %cmp1 = icmp sgt i32 %n, 0
  br i1 %cmp1, label %for.body.preheader, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %entry
  ret double %x

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %x1 = phi double [ %x2, %for.body ], [ %x, %for.body.preheader ]
  %arrayidx = getelementptr inbounds double, ptr %a, i64 %indvars.iv
  %r = load double, ptr %arrayidx, align 8
  %sub = fsub double %x1, %r
  %cmp2 = fcmp ogt double %x1, %r
  %x2 = select i1 %cmp2, double %sub, double %x1, !prof !18
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.exit, label %for.body

for.exit:                                         ; preds = %for.body
  ret double %x2
}

;; The common path includes expensive operations (load and fsub) making
;; branch similarly expensive to cmov, and thus the gain is small.
;; Loop-level analysis should decide on not forming a branch.
;;
;;double small_gain(int n, double x, ptr a) {
;;  for (int i = 0; i < n; i++) {
;;    double r = a[i];
;;    if (x > r)
;;      // 99% of iterations
;;      x -= r;
;;  }
;;  return x;
;;}
define double @small_gain(i32 %n, double %x, ptr nocapture %a) {
; CHECK-LABEL: @small_gain(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret double [[X:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[X1:%.*]] = phi double [ [[X2:%.*]], [[FOR_BODY]] ], [ [[X]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[R:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[SUB:%.*]] = fsub double [[X1]], [[R]]
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ole double [[X1]], [[R]]
; CHECK-NEXT:    [[X2]] = select i1 [[CMP2]], double [[X1]], double [[SUB]], !prof [[PROF18]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_EXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.exit:
; CHECK-NEXT:    ret double [[X2]]
;
entry:
  %cmp1 = icmp sgt i32 %n, 0
  br i1 %cmp1, label %for.body.preheader, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %entry
  ret double %x

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %x1 = phi double [ %x2, %for.body ], [ %x, %for.body.preheader ]
  %arrayidx = getelementptr inbounds double, ptr %a, i64 %indvars.iv
  %r = load double, ptr %arrayidx, align 8
  %sub = fsub double %x1, %r
  %cmp2 = fcmp ole double %x1, %r
  %x2 = select i1 %cmp2, double %x1, double %sub, !prof !17
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.exit, label %for.body

for.exit:                                         ; preds = %for.body
  ret double %x2
}

;; One select on the critical path and one off the critical path.
;; Loop-level analysis should decide to form a branch only for
;; the select on the critical path.
;;
;;double loop_select_groups(int n, double x, ptr a, int k) {
;;  int c = 0;
;;  for (int i = 0; i < n; i++) {
;;    double r = a[i];
;;    if (x > r)
;;      x -= r;
;;    if (i == k)
;;      c += n;
;;  }
;;  return x + c;
;;}
define double @loop_select_groups(i32 %n, double %x, ptr nocapture %a, i32 %k) {
; CHECK-LABEL: @loop_select_groups(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP19:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP19]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    [[PHI_CAST:%.*]] = sitofp i32 [[C_1:%.*]] to double
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[C_0_LCSSA:%.*]] = phi double [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[PHI_CAST]], [[FOR_COND_CLEANUP_LOOPEXIT:%.*]] ]
; CHECK-NEXT:    [[X_ADDR_0_LCSSA:%.*]] = phi double [ [[X:%.*]], [[ENTRY]] ], [ [[X_ADDR_1:%.*]], [[FOR_COND_CLEANUP_LOOPEXIT]] ]
; CHECK-NEXT:    [[ADD5:%.*]] = fadd double [[X_ADDR_0_LCSSA]], [[C_0_LCSSA]]
; CHECK-NEXT:    ret double [[ADD5]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[FOR_BODY_PREHEADER]] ], [ [[INDVARS_IV_NEXT:%.*]], [[SELECT_END:%.*]] ]
; CHECK-NEXT:    [[X_ADDR_022:%.*]] = phi double [ [[X]], [[FOR_BODY_PREHEADER]] ], [ [[X_ADDR_1]], [[SELECT_END]] ]
; CHECK-NEXT:    [[C_020:%.*]] = phi i32 [ 0, [[FOR_BODY_PREHEADER]] ], [ [[C_1]], [[SELECT_END]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[A:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CMP1:%.*]] = fcmp ogt double [[X_ADDR_022]], [[TMP0]]
; CHECK-NEXT:    [[SUB_FROZEN:%.*]] = freeze i1 [[CMP1]]
; CHECK-NEXT:    br i1 [[SUB_FROZEN]], label [[SELECT_END]], label [[SELECT_FALSE:%.*]]
; CHECK:       select.false:
; CHECK-NEXT:    br label [[SELECT_END]]
; CHECK:       select.end:
; CHECK-NEXT:    [[SUB:%.*]] = phi double [ [[TMP0]], [[FOR_BODY]] ], [ 0.000000e+00, [[SELECT_FALSE]] ]
; CHECK-NEXT:    [[X_ADDR_1]] = fsub double [[X_ADDR_022]], [[SUB]]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[K:%.*]], [[N]]
; CHECK-NEXT:    [[ADD:%.*]] = select i1 [[CMP2]], i32 [[N]], i32 0
; CHECK-NEXT:    [[C_1]] = add nsw i32 [[ADD]], [[C_020]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]]
;
entry:
  %cmp19 = icmp sgt i32 %n, 0
  br i1 %cmp19, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  %phi.cast = sitofp i32 %c.1 to double
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %c.0.lcssa = phi double [ 0.000000e+00, %entry ], [ %phi.cast, %for.cond.cleanup.loopexit ]
  %x.addr.0.lcssa = phi double [ %x, %entry ], [ %x.addr.1, %for.cond.cleanup.loopexit ]
  %add5 = fadd double %x.addr.0.lcssa, %c.0.lcssa
  ret double %add5

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %x.addr.022 = phi double [ %x, %for.body.preheader ], [ %x.addr.1, %for.body ]
  %c.020 = phi i32 [ 0, %for.body.preheader ], [ %c.1, %for.body ]
  %arrayidx = getelementptr inbounds double, ptr %a, i64 %indvars.iv
  %0 = load double, ptr %arrayidx, align 8
  %cmp1 = fcmp ogt double %x.addr.022, %0
  %sub = select i1 %cmp1, double %0, double 0.000000e+00
  %x.addr.1 = fsub double %x.addr.022, %sub
  %1 = trunc i64 %indvars.iv to i32
  %cmp2 = icmp eq i32 %k, %n
  %add = select i1 %cmp2, i32 %n, i32 0
  %c.1 = add nsw i32 %add, %c.020
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup.loopexit, label %for.body
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata)

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)

declare void @free(ptr nocapture)

!llvm.module.flags = !{!0, !26, !27}
!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 10000}
!4 = !{!"MaxCount", i64 10}
!5 = !{!"MaxInternalCount", i64 1}
!6 = !{!"MaxFunctionCount", i64 1000}
!7 = !{!"NumCounts", i64 3}
!8 = !{!"NumFunctions", i64 3}
!9 = !{!"DetailedSummary", !10}
!10 = !{!11, !12, !13}
!11 = !{i32 10000, i64 100, i32 1}
!12 = !{i32 999000, i64 100, i32 1}
!13 = !{i32 999999, i64 1, i32 2}
!14 = !{!"function_entry_count", i64 0}
!15 = !{!"branch_weights", i32 1, i32 100}
!16 = !{!"branch_weights", i32 100, i32 1}
!17 = !{!"branch_weights", i32 1, i32 99}
!18 = !{!"branch_weights", i32 50, i32 50}
!19 = !{!"function_entry_count", i64 100}
!20 = !{}
!21 = !DIFile(filename: "test.c", directory: "/test")
!22 = distinct !DICompileUnit(language: DW_LANG_C99, file: !21, producer: "clang version 15.0.0", isOptimized: true, emissionKind: FullDebug, globals: !25, splitDebugInlining: false, nameTableKind: None)
!23 = distinct !DISubprogram(name: "test", scope: !21, file: !21, line: 1, unit: !22)
!24 = !DILocalVariable(name: "x", scope: !23)
!25 = !{}
!26 = !{i32 2, !"Dwarf Version", i32 4}
!27 = !{i32 1, !"Debug Info Version", i32 3}
!28 = !{!"branch_weights", i32 30, i32 70}
