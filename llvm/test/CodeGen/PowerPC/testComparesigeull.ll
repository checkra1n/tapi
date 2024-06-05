; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

@glob = dso_local local_unnamed_addr global i64 0, align 8

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeull(i64 %a, i64 %b) {
; CHECK-LABEL: test_igeull:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    subfe r3, r4, r4
; CHECK-NEXT:    addi r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeull_sext(i64 %a, i64 %b) {
; CHECK-LABEL: test_igeull_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    subfe r3, r4, r4
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeull_z(i64 %a) {
; CHECK-LABEL: test_igeull_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, 1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, 0
  %sub = zext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind readnone
define dso_local signext i32 @test_igeull_sext_z(i64 %a) {
; CHECK-LABEL: test_igeull_sext_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, -1
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, 0
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeull_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_igeull_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subfe r3, r4, r4
; CHECK-NEXT:    addi r3, r3, 1
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, ptr @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeull_sext_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_igeull_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subc r3, r3, r4
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subfe r3, r4, r4
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeull_z_store(i64 %a) {
; CHECK-LABEL: test_igeull_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, glob@toc@ha
; CHECK-NEXT:    li r4, 1
; CHECK-NEXT:    std r4, glob@toc@l(r3)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, 0
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, ptr @glob
  ret void
}

; Function Attrs: norecurse nounwind
define dso_local void @test_igeull_sext_z_store(i64 %a) {
; CHECK-LABEL: test_igeull_sext_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, glob@toc@ha
; CHECK-NEXT:    li r4, -1
; CHECK-NEXT:    std r4, glob@toc@l(r3)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, 0
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, ptr @glob
  ret void
}
