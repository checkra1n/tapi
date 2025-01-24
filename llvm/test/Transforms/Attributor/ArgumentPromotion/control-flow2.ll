; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

define internal i32 @callee(i1 %C, ptr %P) {
; CGSCC: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
; CGSCC-LABEL: define {{[^@]+}}@callee
; CGSCC-SAME: (i32 [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:    [[P_PRIV:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 [[TMP0]], ptr [[P_PRIV]], align 4
; CGSCC-NEXT:    br label [[F:%.*]]
; CGSCC:       T:
; CGSCC-NEXT:    unreachable
; CGSCC:       F:
; CGSCC-NEXT:    [[X:%.*]] = load i32, ptr [[P_PRIV]], align 4
; CGSCC-NEXT:    ret i32 [[X]]
;
  br i1 %C, label %T, label %F

T:              ; preds = %0
  ret i32 17

F:              ; preds = %0
  %X = load i32, ptr %P               ; <i32> [#uses=1]
  ret i32 %X
}

define i32 @foo() {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@foo
; TUNIT-SAME: () #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:    [[A:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    ret i32 17
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@foo
; CGSCC-SAME: () #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[X:%.*]] = call i32 @callee(i32 noundef 17) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[X]]
;
  %A = alloca i32         ; <ptr> [#uses=2]
  store i32 17, ptr %A
  %X = call i32 @callee( i1 false, ptr %A )              ; <i32> [#uses=1]
  ret i32 %X
}

;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { nofree willreturn memory(read) }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
