; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "amdgcn-amd-amdhsa"

@G = external dso_local addrspace(4) global i32, align 4

declare ptr @ptr() memory(none)
declare ptr addrspace(4) @ptr_to_const() memory(none)
declare ptr addrspace(3) @ptr_to_shared() memory(none)

; Should be memory(none)
;.
; CHECK: @[[G:[a-zA-Z0-9_$"\\.-]+]] = external dso_local addrspace(4) global i32, align 4
;.
define i32 @test_const_as_global1() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@test_const_as_global1
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr addrspace(4) @G, align 4
; CHECK-NEXT:    ret i32 [[L1]]
;
  %l1 = load i32, ptr addrspace(4) @G
  ret i32 %l1
}
; Should be memory(none)
define i32 @test_const_as_global2() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@test_const_as_global2
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr addrspace(4) @G, align 4
; CHECK-NEXT:    ret i32 [[L2]]
;
  %l2 = load i32, ptr addrspacecast (ptr addrspace(4) @G to ptr)
  ret i32 %l2
}
; Should be memory(none)
define i32 @test_const_as_call1() {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@test_const_as_call1
; CHECK-SAME: () #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    [[P1:%.*]] = call ptr addrspace(4) @ptr_to_const()
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr addrspace(4) [[P1]], align 4
; CHECK-NEXT:    ret i32 [[L1]]
;
  %p1 = call ptr addrspace(4) @ptr_to_const()
  %c1 = addrspacecast ptr addrspace(4) %p1 to ptr
  %l1 = load i32, ptr %c1
  ret i32 %l1
}
; Should be memory(none)
define i32 @test_const_as_call2() {
; CHECK: Function Attrs: nosync memory(none)
; CHECK-LABEL: define {{[^@]+}}@test_const_as_call2
; CHECK-SAME: () #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    [[P2:%.*]] = call ptr @ptr()
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr [[P2]], align 4
; CHECK-NEXT:    ret i32 [[L2]]
;
  %p2 = call ptr @ptr()
  %c2 = addrspacecast ptr %p2 to ptr addrspace(4)
  %l2 = load i32, ptr addrspace(4) %c2
  ret i32 %l2
}

; Should be memory(read)
define i32 @test_shared_as_call1() {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@test_shared_as_call1
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:    [[P1:%.*]] = call ptr addrspace(3) @ptr_to_shared()
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr addrspace(3) [[P1]], align 4
; CHECK-NEXT:    ret i32 [[L1]]
;
  %p1 = call ptr addrspace(3) @ptr_to_shared()
  %c1 = addrspacecast ptr addrspace(3) %p1 to ptr
  %l1 = load i32, ptr %c1
  ret i32 %l1
}
; Should be memory(read)
define i32 @test_shared_as_call2() {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@test_shared_as_call2
; CHECK-SAME: () #[[ATTR2]] {
; CHECK-NEXT:    [[P2:%.*]] = call ptr @ptr()
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr [[P2]], align 4
; CHECK-NEXT:    ret i32 [[L2]]
;
  %p2 = call ptr @ptr()
  %c2 = addrspacecast ptr %p2 to ptr addrspace(3)
  %l2 = load i32, ptr addrspace(3) %c2
  ret i32 %l2
}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { memory(none) }
; CHECK: attributes #[[ATTR1]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR2]] = { nosync memory(read) }
; CHECK: attributes #[[ATTR3]] = { nosync memory(none) }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CGSCC: {{.*}}
; TUNIT: {{.*}}
