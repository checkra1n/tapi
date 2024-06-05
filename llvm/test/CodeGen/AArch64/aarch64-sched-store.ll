; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64 -mcpu=cortex-a57 -mattr=+slow-paired-128 < %s | FileCheck %s --check-prefixes=DEFAULT
; RUN: llc -mtriple aarch64 -mcpu=cortex-a57 -mattr=+slow-paired-128 -mattr=+ascend-store-address < %s | FileCheck %s --check-prefixes=ASCEND

target triple = "aarch64-unknown-linux-gnu"

define dso_local void @memset_unroll2(double* nocapture %array, i64 %size) {
; DEFAULT-LABEL: memset_unroll2:
; DEFAULT:       // %bb.0: // %entry
; DEFAULT-NEXT:    fmov v0.2d, #2.00000000
; DEFAULT-NEXT:    add x8, x0, #64
; DEFAULT-NEXT:    .p2align 4, , 8
; DEFAULT-NEXT:  .LBB0_1: // %vector.body
; DEFAULT-NEXT:    // =>This Inner Loop Header: Depth=1
; DEFAULT-NEXT:    stur q0, [x8, #-64]
; DEFAULT-NEXT:    subs x1, x1, #4
; DEFAULT-NEXT:    stur q0, [x8, #-48]
; DEFAULT-NEXT:    str q0, [x8]
; DEFAULT-NEXT:    str q0, [x8, #16]
; DEFAULT-NEXT:    str q0, [x8, #32]
; DEFAULT-NEXT:    str q0, [x8, #48]
; DEFAULT-NEXT:    stur q0, [x8, #-32]
; DEFAULT-NEXT:    stur q0, [x8, #-16]
; DEFAULT-NEXT:    add x8, x8, #128
; DEFAULT-NEXT:    b.ne .LBB0_1
; DEFAULT-NEXT:  // %bb.2: // %cleanup
; DEFAULT-NEXT:    ret
;
; ASCEND-LABEL: memset_unroll2:
; ASCEND:       // %bb.0: // %entry
; ASCEND-NEXT:    fmov v0.2d, #2.00000000
; ASCEND-NEXT:    add x8, x0, #64
; ASCEND-NEXT:    .p2align 4, , 8
; ASCEND-NEXT:  .LBB0_1: // %vector.body
; ASCEND-NEXT:    // =>This Inner Loop Header: Depth=1
; ASCEND-NEXT:    stur q0, [x8, #-64]
; ASCEND-NEXT:    subs x1, x1, #4
; ASCEND-NEXT:    stur q0, [x8, #-48]
; ASCEND-NEXT:    stur q0, [x8, #-32]
; ASCEND-NEXT:    stur q0, [x8, #-16]
; ASCEND-NEXT:    str q0, [x8]
; ASCEND-NEXT:    str q0, [x8, #16]
; ASCEND-NEXT:    str q0, [x8, #32]
; ASCEND-NEXT:    str q0, [x8, #48]
; ASCEND-NEXT:    add x8, x8, #128
; ASCEND-NEXT:    b.ne .LBB0_1
; ASCEND-NEXT:  // %bb.2: // %cleanup
; ASCEND-NEXT:    ret
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index16, %vector.body ]
  %niter = phi i64 [ %size, %entry ], [ %niter.nsub.3, %vector.body ]
  %array0 = getelementptr inbounds double, double* %array, i64 %index
  %array0.cast = bitcast double* %array0 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array0.cast, align 8
  %array2 = getelementptr inbounds double, double* %array0, i64 2
  %array2.cast = bitcast double* %array2 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array2.cast, align 8
  %index4 = or i64 %index, 4
  %array4 = getelementptr inbounds double, double* %array, i64 %index4
  %array4.cast = bitcast double* %array4 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array4.cast, align 8
  %array6 = getelementptr inbounds double, double* %array4, i64 2
  %array6.cast = bitcast double* %array6 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array6.cast, align 8
  %index8 = or i64 %index, 8
  %array8 = getelementptr inbounds double, double* %array, i64 %index8
  %array8.cast = bitcast double* %array8 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array8.cast, align 8
  %array10 = getelementptr inbounds double, double* %array8, i64 2
  %array10.cast = bitcast double* %array10 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array10.cast, align 8
  %index12 = or i64 %index, 12
  %array12 = getelementptr inbounds double, double* %array, i64 %index12
  %array12.cast = bitcast double* %array12 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array12.cast, align 8
  %array14 = getelementptr inbounds double, double* %array12, i64 2
  %array14.cast = bitcast double* %array14 to <2 x double>*
  store <2 x double> <double 2.000000e+00, double 2.000000e+00>, <2 x double>* %array14.cast, align 8
  %index16 = add i64 %index, 16
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %cleanup, label %vector.body

cleanup:                           ; preds = %vector.body
  ret void
}
