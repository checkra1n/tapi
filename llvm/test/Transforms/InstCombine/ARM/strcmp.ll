; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the strcmp library call simplifier works correctly.
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

@hello = constant [6 x i8] c"hello\00"
@hell = constant [5 x i8] c"hell\00"
@bell = constant [5 x i8] c"bell\00"
@null = constant [1 x i8] zeroinitializer

declare i32 @strcmp(i8*, i8*)

; strcmp("", x) -> -*x
define arm_aapcscc i32 @test1(i8* %str2) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, i8* [[STR2:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub nsw i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;

  %str1 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_apcscc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1

}

; strcmp(x, "") -> *x
define arm_aapcscc i32 @test2(i8* %str1) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, i8* [[STR1:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;

  %str2 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_aapcscc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

; strcmp(x, y)  -> cnst
define arm_aapcscc i32 @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    ret i32 -1
;

  %str1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %str2 = getelementptr inbounds [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %temp1 = call arm_aapcscc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

define arm_aapcscc i32 @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    ret i32 1
;

  %str1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %str2 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_aapcscc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

; strcmp(x, y)   -> memcmp(x, y, <known length>)
; (This transform is rather difficult to trigger in a useful manner)
define arm_aapcscc i32 @test5(i1 %b) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[STR2:%.*]] = select i1 [[B:%.*]], i8* getelementptr inbounds ([5 x i8], [5 x i8]* @hell, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @bell, i32 0, i32 0)
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(i8* noundef nonnull dereferenceable(5) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i32 0, i32 0), i8* noundef nonnull dereferenceable(5) [[STR2]], i32 5)
; CHECK-NEXT:    ret i32 [[MEMCMP]]
;

  %str1 = getelementptr inbounds [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %temp1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %temp2 = getelementptr inbounds [5 x i8], [5 x i8]* @bell, i32 0, i32 0
  %str2 = select i1 %b, i8* %temp1, i8* %temp2
  %temp3 = call arm_aapcscc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp3
}

; strcmp(x,x)  -> 0
define arm_aapcscc i32 @test6(i8* %str) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret i32 0
;

  %temp1 = call arm_aapcscc i32 @strcmp(i8* %str, i8* %str)
  ret i32 %temp1
}

; strcmp("", x) -> -*x
define arm_aapcs_vfpcc i32 @test1_vfp(i8* %str2) {
; CHECK-LABEL: @test1_vfp(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, i8* [[STR2:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = sub nsw i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;

  %str1 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1

}

; strcmp(x, "") -> *x
define arm_aapcs_vfpcc i32 @test2_vfp(i8* %str1) {
; CHECK-LABEL: @test2_vfp(
; CHECK-NEXT:    [[STRCMPLOAD:%.*]] = load i8, i8* [[STR1:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[STRCMPLOAD]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;

  %str2 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

; strcmp(x, y)  -> cnst
define arm_aapcs_vfpcc i32 @test3_vfp() {
; CHECK-LABEL: @test3_vfp(
; CHECK-NEXT:    ret i32 -1
;

  %str1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %str2 = getelementptr inbounds [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

define arm_aapcs_vfpcc i32 @test4_vfp() {
; CHECK-LABEL: @test4_vfp(
; CHECK-NEXT:    ret i32 1
;

  %str1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %str2 = getelementptr inbounds [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp1
}

; strcmp(x, y)   -> memcmp(x, y, <known length>)
; (This transform is rather difficult to trigger in a useful manner)
define arm_aapcs_vfpcc i32 @test5_vfp(i1 %b) {
; CHECK-LABEL: @test5_vfp(
; CHECK-NEXT:    [[STR2:%.*]] = select i1 [[B:%.*]], i8* getelementptr inbounds ([5 x i8], [5 x i8]* @hell, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @bell, i32 0, i32 0)
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(i8* noundef nonnull dereferenceable(5) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i32 0, i32 0), i8* noundef nonnull dereferenceable(5) [[STR2]], i32 5)
; CHECK-NEXT:    ret i32 [[MEMCMP]]
;

  %str1 = getelementptr inbounds [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %temp1 = getelementptr inbounds [5 x i8], [5 x i8]* @hell, i32 0, i32 0
  %temp2 = getelementptr inbounds [5 x i8], [5 x i8]* @bell, i32 0, i32 0
  %str2 = select i1 %b, i8* %temp1, i8* %temp2
  %temp3 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str1, i8* %str2)
  ret i32 %temp3
}

; strcmp(x,x)  -> 0
define arm_aapcs_vfpcc i32 @test6_vfp(i8* %str) {
; CHECK-LABEL: @test6_vfp(
; CHECK-NEXT:    ret i32 0
;

  %temp1 = call arm_aapcs_vfpcc i32 @strcmp(i8* %str, i8* %str)
  ret i32 %temp1
}
