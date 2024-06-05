; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -early-cse -earlycse-debug-hash | FileCheck %s
; RUN: opt < %s -S -passes='early-cse<memssa>' | FileCheck %s

; Test use of constrained floating point intrinsics in the default
; floating point environment.

define double @multiple_fadd(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fadd(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fadd_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fadd_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fsub(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fsub(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fsub_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fsub_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fmul(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fmul(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fmul_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fmul_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fdiv(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fdiv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_fdiv_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fdiv_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_frem(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_frem(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @multiple_frem_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_frem_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define i32 @multiple_fptoui(double %a) #0 {
; CHECK-LABEL: @multiple_fptoui(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @multiple_fptoui_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fptoui_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @multiple_uitofp(i32 %a) #0 {
; CHECK-LABEL: @multiple_uitofp(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @multiple_uitofp_split(i32 %a) #0 {
; CHECK-LABEL: @multiple_uitofp_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i32 @multiple_fptosi(double %a) #0 {
; CHECK-LABEL: @multiple_fptosi(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @multiple_fptosi_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fptosi_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @multiple_sitofp(i32 %a) #0 {
; CHECK-LABEL: @multiple_sitofp(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @multiple_sitofp_split(i32 %a) #0 {
; CHECK-LABEL: @multiple_sitofp_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i1 @multiple_fcmp(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fcmp(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @multiple_fcmp_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fcmp_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @multiple_fcmps(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fcmps(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @multiple_fcmps_split(double %a, double %b) #0 {
; CHECK-LABEL: @multiple_fcmps_split(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    call void @arbitraryfunc() #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  call void @arbitraryfunc() #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

attributes #0 = { strictfp }

declare void @arbitraryfunc() #0
declare double @foo.f64(double, double) #0
declare i32 @bar.i32(i32, i32) #0

declare double @llvm.experimental.constrained.fadd.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fsub.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fmul.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fdiv.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.frem.f64(double, double, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptoui.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.uitofp.f64.i32(i32, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptosi.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.sitofp.f64.i32(i32, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmp.i1.f64(double, double, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmps.i1.f64(double, double, metadata, metadata)