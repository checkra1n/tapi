; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -dse %s -S | FileCheck --check-prefixes=CHECK %s


%struct.ham = type { [3 x double], [3 x double]}

declare void @may_throw()
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg)

; We miss this case, because of an aggressive limit of partial overlap analysis.
; With a larger partial store limit, we remove the memset.
define void @overlap1(ptr %arg, i1 %cond) {
; CHECK-LABEL: @overlap1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr inbounds [[STRUCT_HAM:%.*]], ptr [[ARG:%.*]], i64 0, i32 0, i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 0, i64 1
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i64 2
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i32 0
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB7:%.*]], label [[BB8:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    br label [[BB9]]
; CHECK:       bb9:
; CHECK-NEXT:    store double 1.000000e+00, ptr [[ARG]], align 8
; CHECK-NEXT:    store double 2.000000e+00, ptr [[TMP1]], align 8
; CHECK-NEXT:    store double 3.000000e+00, ptr [[TMP]], align 8
; CHECK-NEXT:    store double 4.000000e+00, ptr [[TMP5]], align 8
; CHECK-NEXT:    store double 5.000000e+00, ptr [[TMP4]], align 8
; CHECK-NEXT:    store double 6.000000e+00, ptr [[TMP3]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %tmp = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 0, i64 2
  %tmp1 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 0, i64 1
  %tmp3 = getelementptr inbounds %struct.ham, ptr %arg, i64 0,i32 1, i64 2
  %tmp4 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 1, i64 1
  %tmp5 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 1, i32 0
  call void @llvm.memset.p0.i64(ptr nonnull align 8 dereferenceable(48) %arg, i8 0, i64 48, i1 false)
  br i1 %cond, label %bb7, label %bb8

bb7:                                              ; preds = %bb
  br label %bb9

bb8:                                              ; preds = %bb
  br label %bb9

bb9:                                              ; preds = %bb8, %bb7
  store double 1.0, ptr %arg, align 8
  store double 2.0, ptr %tmp1, align 8
  store double 3.0, ptr %tmp, align 8
  store double 4.0, ptr %tmp5, align 8
  store double 5.0, ptr %tmp4, align 8
  store double 6.0, ptr %tmp3, align 8
  ret void
}

define void @overlap2(ptr %arg, i1 %cond) {
; CHECK-LABEL: @overlap2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr inbounds [[STRUCT_HAM:%.*]], ptr [[ARG:%.*]], i64 0, i32 0, i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 0, i64 1
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i64 2
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_HAM]], ptr [[ARG]], i64 0, i32 1, i32 0
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr nonnull align 8 dereferenceable(48) [[ARG]], i8 0, i64 48, i1 false)
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB7:%.*]], label [[BB8:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    call void @may_throw()
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    br label [[BB9]]
; CHECK:       bb9:
; CHECK-NEXT:    store double 1.000000e+00, ptr [[ARG]], align 8
; CHECK-NEXT:    store double 2.000000e+00, ptr [[TMP1]], align 8
; CHECK-NEXT:    store double 3.000000e+00, ptr [[TMP]], align 8
; CHECK-NEXT:    store double 4.000000e+00, ptr [[TMP5]], align 8
; CHECK-NEXT:    store double 5.000000e+00, ptr [[TMP4]], align 8
; CHECK-NEXT:    store double 6.000000e+00, ptr [[TMP3]], align 8
; CHECK-NEXT:    ret void
;
bb:
  %tmp = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 0, i64 2
  %tmp1 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 0, i64 1
  %tmp3 = getelementptr inbounds %struct.ham, ptr %arg, i64 0,i32 1, i64 2
  %tmp4 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 1, i64 1
  %tmp5 = getelementptr inbounds %struct.ham, ptr %arg, i64 0, i32 1, i32 0
  call void @llvm.memset.p0.i64(ptr nonnull align 8 dereferenceable(48) %arg, i8 0, i64 48, i1 false)
  br i1 %cond, label %bb7, label %bb8

bb7:                                              ; preds = %bb
  call void @may_throw()
  br label %bb9

bb8:                                              ; preds = %bb
  br label %bb9

bb9:                                              ; preds = %bb8, %bb7
  store double 1.0, ptr %arg, align 8
  store double 2.0, ptr %tmp1, align 8
  store double 3.0, ptr %tmp, align 8
  store double 4.0, ptr %tmp5, align 8
  store double 5.0, ptr %tmp4, align 8
  store double 6.0, ptr %tmp3, align 8
  ret void
}

; Test case from PR46513. Make sure we do not crash.
; TODO: we should be able to shorten store i32 844283136, ptr %cast.i32 to a
; store of i16.
define void @overlap_no_dominance(ptr %arg, i1 %c)  {
; CHECK-LABEL: @overlap_no_dominance(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB13:%.*]], label [[BB9:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    store i32 844283136, ptr [[ARG:%.*]], align 4
; CHECK-NEXT:    br label [[BB13]]
; CHECK:       bb13:
; CHECK-NEXT:    store i16 0, ptr [[ARG]], align 4
; CHECK-NEXT:    ret void
;
bb:
  br i1 %c, label %bb13, label %bb9

bb9:                                              ; preds = %bb
  store i32 844283136, ptr %arg, align 4
  br label %bb13

bb13:                                             ; preds = %bb9, %bb
  store i16 0, ptr %arg, align 4
  ret void
}
