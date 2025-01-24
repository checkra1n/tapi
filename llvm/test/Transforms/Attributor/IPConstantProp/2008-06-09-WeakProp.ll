; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

; Should not propagate the result of a weak function.
; PR2411

define weak i32 @foo() nounwind  {
; CHECK: Function Attrs: nounwind
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 1
;
entry:
  ret i32 1
}

define i32 @main() nounwind  {
; CHECK: Function Attrs: nounwind
; CHECK-LABEL: define {{[^@]+}}@main
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[R:%.*]] = call i32 @foo() #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[R]]
;
entry:
  %r = call i32 @foo( ) nounwind
  ret i32 %r
}

;.
; CHECK: attributes #[[ATTR0]] = { nounwind }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CGSCC: {{.*}}
; TUNIT: {{.*}}
