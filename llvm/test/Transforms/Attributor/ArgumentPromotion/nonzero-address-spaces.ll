; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

; ArgumentPromotion should preserve the default function address space
; from the data layout.

target datalayout = "e-P1-p:16:8-i8:8-i16:8-i32:8-i64:8-f32:8-f64:8-n8-a:8"

@g = common global i32 0, align 4

;.
; CHECK: @[[G:[a-zA-Z0-9_$"\\.-]+]] = common global i32 0, align 4
;.
define i32 @bar() {
; CHECK-LABEL: define {{[^@]+}}@bar() addrspace(1) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call addrspace(1) i32 @foo() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    unreachable
;

entry:
  %call = call i32 @foo(i32* @g)
  ret i32 %call
}

define internal i32 @foo(i32*) {
; CHECK: Function Attrs: noreturn
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: () addrspace(1) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call addrspace(0) void asm sideeffect "ldr r0, [r0] \0Abx lr \0A", ""()
; CHECK-NEXT:    unreachable
;
entry:
  %retval = alloca i32, align 4
  call void asm sideeffect "ldr r0, [r0] \0Abx lr        \0A", ""()
  unreachable
}

;.
; CHECK: attributes #[[ATTR0]] = { noreturn }
;.
