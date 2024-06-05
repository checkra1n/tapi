; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

; See PR26774

define i32 @baz() {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@baz
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    ret i32 10
;
  ret i32 10
}

; We can const-prop @baz's return value *into* @foo, but cannot
; constprop @foo's return value into bar.

define linkonce_odr i32 @foo() {
; TUNIT-LABEL: define {{[^@]+}}@foo() {
; TUNIT-NEXT:    ret i32 10
;
; CGSCC-LABEL: define {{[^@]+}}@foo() {
; CGSCC-NEXT:    [[VAL:%.*]] = call i32 @baz()
; CGSCC-NEXT:    ret i32 [[VAL]]
;

  %val = call i32 @baz()
  ret i32 %val
}

define i32 @bar() {
; TUNIT: Function Attrs: norecurse
; TUNIT-LABEL: define {{[^@]+}}@bar
; TUNIT-SAME: () #[[ATTR1:[0-9]+]] {
; TUNIT-NEXT:    [[VAL:%.*]] = call i32 @foo()
; TUNIT-NEXT:    ret i32 [[VAL]]
;
; CGSCC-LABEL: define {{[^@]+}}@bar() {
; CGSCC-NEXT:    [[VAL:%.*]] = call i32 @foo()
; CGSCC-NEXT:    ret i32 [[VAL]]
;

  %val = call i32 @foo()
  ret i32 %val
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; TUNIT: attributes #[[ATTR1]] = { norecurse }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
;.
