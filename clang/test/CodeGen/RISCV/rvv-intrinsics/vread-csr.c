// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -disable-O0-optnone -emit-llvm %s -o - \
// RUN:     | opt -S -O2 | FileCheck  %s

#include <riscv_vector.h>

// CHECK-LABEL: @vread_csr_vstart(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i64 asm sideeffect "csrr\09$0, vstart", "=r,~{memory}"() #[[ATTR1:[0-9]+]], !srcloc !4
// CHECK-NEXT:    ret i64 [[TMP0]]
//
unsigned long vread_csr_vstart(void) {
  return vread_csr(RVV_VSTART);
}

// CHECK-LABEL: @vread_csr_vxsat(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i64 asm sideeffect "csrr\09$0, vxsat", "=r,~{memory}"() #[[ATTR1]], !srcloc !5
// CHECK-NEXT:    ret i64 [[TMP0]]
//
unsigned long vread_csr_vxsat(void) {
  return vread_csr(RVV_VXSAT);
}

// CHECK-LABEL: @vread_csr_vxrm(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i64 asm sideeffect "csrr\09$0, vxrm", "=r,~{memory}"() #[[ATTR1]], !srcloc !6
// CHECK-NEXT:    ret i64 [[TMP0]]
//
unsigned long vread_csr_vxrm(void) {
  return vread_csr(RVV_VXRM);
}

// CHECK-LABEL: @vread_csr_vcsr(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i64 asm sideeffect "csrr\09$0, vcsr", "=r,~{memory}"() #[[ATTR1]], !srcloc !7
// CHECK-NEXT:    ret i64 [[TMP0]]
//
unsigned long vread_csr_vcsr(void) {
  return vread_csr(RVV_VCSR);
}
