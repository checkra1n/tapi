; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define internal i32 @testf(i1 %c) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@testf
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    br i1 [[C]], label [[IF_COND:%.*]], label [[IF_END:%.*]]
; CGSCC:       if.cond:
; CGSCC-NEXT:    unreachable
; CGSCC:       if.then:
; CGSCC-NEXT:    unreachable
; CGSCC:       if.end:
; CGSCC-NEXT:    ret i32 10
;
entry:
  br i1 %c, label %if.cond, label %if.end

if.cond:
  br i1 undef, label %if.then, label %if.end

if.then:                                          ; preds = %entry, %if.then
  ret i32 11

if.end:                                          ; preds = %if.then1, %entry
  ret i32 10
}

define internal i32 @test1(i1 %c) {
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@test1
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    br label [[IF_THEN:%.*]]
; CGSCC:       if.then:
; CGSCC-NEXT:    [[CALL:%.*]] = call i32 @testf(i1 [[C]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    [[RES:%.*]] = icmp eq i32 [[CALL]], 10
; CGSCC-NEXT:    br i1 [[RES]], label [[RET1:%.*]], label [[RET2:%.*]]
; CGSCC:       ret1:
; CGSCC-NEXT:    ret i32 99
; CGSCC:       ret2:
; CGSCC-NEXT:    ret i32 0
;
entry:
  br label %if.then

if.then:                                          ; preds = %entry, %if.then
  %call = call i32 @testf(i1 %c)
  %res = icmp eq i32 %call, 10
  br i1 %res, label %ret1, label %ret2

ret1:                                           ; preds = %if.then, %entry
  ret i32 99

ret2:                                           ; preds = %if.then, %entry
  ret i32 0
}

define i32 @main(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@main
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:    ret i32 99
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@main
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[RES:%.*]] = call noundef i32 @test1(i1 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    ret i32 [[RES]]
;
  %res = call i32 @test1(i1 %c)
  ret i32 %res
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR1]] = { nofree nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR2]] = { readnone willreturn }
;.
