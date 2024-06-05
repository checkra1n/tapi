; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S | FileCheck %s
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "x86_64--linux-gnu"

@a = common global [4 x double] zeroinitializer, align 8
@b = common global [4 x double] zeroinitializer, align 8

; [4], b[4];
; double foo() {
;  double sum =0;
;  sum = (a[0]+b[0]) + (a[1]+b[1]);
;  return sum;
; }

define double @return1() {
; CHECK-LABEL: @return1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x double>, <2 x double>* bitcast ([4 x double]* @a to <2 x double>*), align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* bitcast ([4 x double]* @b to <2 x double>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = fadd <2 x double> [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x double> [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[TMP2]], i32 1
; CHECK-NEXT:    [[ADD2:%.*]] = fadd double [[TMP3]], [[TMP4]]
; CHECK-NEXT:    ret double [[ADD2]]
;
entry:
  %a0 = load double, double* getelementptr inbounds ([4 x double], [4 x double]* @a, i32 0, i32 0), align 8
  %b0 = load double, double* getelementptr inbounds ([4 x double], [4 x double]* @b, i32 0, i32 0), align 8
  %add0 = fadd double %a0, %b0
  %a1 = load double, double* getelementptr inbounds ([4 x double], [4 x double]* @a, i32 0, i32 1), align 8
  %b1 = load double, double* getelementptr inbounds ([4 x double], [4 x double]* @b, i32 0, i32 1), align 8
  %add1 = fadd double %a1, %b1
  %add2 = fadd double %add0, %add1
  ret double %add2
}

; double hadd(double *x) {
;   return ((x[0] + x[2]) + (x[1] + x[3]));
; }

define double @return2(double* nocapture readonly %x) {
; CHECK-LABEL: @return2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds double, double* [[X:%.*]], i32 2
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast double* [[X]] to <2 x double>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double* [[ARRAYIDX1]] to <2 x double>*
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x double>, <2 x double>* [[TMP2]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = fadd <2 x double> [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <2 x double> [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP4]], i32 1
; CHECK-NEXT:    [[ADD5:%.*]] = fadd double [[TMP5]], [[TMP6]]
; CHECK-NEXT:    ret double [[ADD5]]
;
entry:
  %x0 = load double, double* %x, align 4
  %arrayidx1 = getelementptr inbounds double, double* %x, i32 2
  %x2 = load double, double* %arrayidx1, align 4
  %add3 = fadd double %x0, %x2
  %arrayidx2 = getelementptr inbounds double, double* %x, i32 1
  %x1 = load double, double* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds double, double* %x, i32 3
  %x3 = load double, double* %arrayidx3, align 4
  %add4 = fadd double %x1, %x3
  %add5 = fadd double %add3, %add4
  ret double %add5
}