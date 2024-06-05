; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -early-cse -earlycse-debug-hash | FileCheck %s
; RUN: opt < %s -S -passes='early-cse<memssa>' | FileCheck %s

define i32 @test12(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[LOAD0:%.*]] = load i32, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i32, ptr [[P2:%.*]] seq_cst, align 4
; CHECK-NEXT:    [[LOAD1:%.*]] = load i32, ptr [[P1]], align 4
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[B:%.*]], i32 [[LOAD0]], i32 [[LOAD1]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %load0 = load i32, ptr %P1
  %1 = load atomic i32, ptr %P2 seq_cst, align 4
  %load1 = load i32, ptr %P1
  %sel = select i1 %B, i32 %load0, i32 %load1
  ret i32 %sel
}

; atomic to non-atomic forwarding is legal
define i32 @test13(i1 %B, ptr %P1) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    [[A:%.*]] = load atomic i32, ptr [[P1:%.*]] seq_cst, align 4
; CHECK-NEXT:    ret i32 0
;
  %a = load atomic i32, ptr %P1 seq_cst, align 4
  %b = load i32, ptr %P1
  %res = sub i32 %a, %b
  ret i32 %res
}

; atomic to unordered atomic forwarding is legal
define i32 @test14(i1 %B, ptr %P1) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:    [[A:%.*]] = load atomic i32, ptr [[P1:%.*]] seq_cst, align 4
; CHECK-NEXT:    ret i32 0
;
  %a = load atomic i32, ptr %P1 seq_cst, align 4
  %b = load atomic i32, ptr %P1 unordered, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; implementation restriction: can't forward to stonger
; than unordered
define i32 @test15(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test15(
; CHECK-NEXT:    [[A:%.*]] = load atomic i32, ptr [[P1:%.*]] seq_cst, align 4
; CHECK-NEXT:    [[B:%.*]] = load atomic i32, ptr [[P1]] seq_cst, align 4
; CHECK-NEXT:    [[RES:%.*]] = sub i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %a = load atomic i32, ptr %P1 seq_cst, align 4
  %b = load atomic i32, ptr %P1 seq_cst, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; forwarding non-atomic to atomic is wrong! (However,
; it would be legal to use the later value in place of the
; former in this particular example.  We just don't
; do that right now.)
define i32 @test16(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test16(
; CHECK-NEXT:    [[A:%.*]] = load i32, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    [[B:%.*]] = load atomic i32, ptr [[P1]] unordered, align 4
; CHECK-NEXT:    [[RES:%.*]] = sub i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %a = load i32, ptr %P1, align 4
  %b = load atomic i32, ptr %P1 unordered, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; Can't DSE across a full fence
define void @fence_seq_cst_store(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @fence_seq_cst_store(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    store atomic i32 0, ptr [[P2:%.*]] seq_cst, align 4
; CHECK-NEXT:    store i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  store atomic i32 0, ptr %P2 seq_cst, align 4
  store i32 0, ptr %P1, align 4
  ret void
}

; Can't DSE across a full fence
define void @fence_seq_cst(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @fence_seq_cst(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    fence seq_cst
; CHECK-NEXT:    store i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  fence seq_cst
  store i32 0, ptr %P1, align 4
  ret void
}

; Can't DSE across a full fence
define void @fence_asm_sideeffect(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @fence_asm_sideeffect(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    call void asm sideeffect "", ""()
; CHECK-NEXT:    store i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  call void asm sideeffect "", ""()
  store i32 0, ptr %P1, align 4
  ret void
}

; Can't DSE across a full fence
define void @fence_asm_memory(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @fence_asm_memory(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    call void asm "", "~{memory}"()
; CHECK-NEXT:    store i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  call void asm "", "~{memory}"()
  store i32 0, ptr %P1, align 4
  ret void
}

; Can't remove a volatile load
define i32 @volatile_load(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @volatile_load(
; CHECK-NEXT:    [[A:%.*]] = load i32, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    [[B:%.*]] = load volatile i32, ptr [[P1]], align 4
; CHECK-NEXT:    [[RES:%.*]] = sub i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %a = load i32, ptr %P1, align 4
  %b = load volatile i32, ptr %P1, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; Can't remove redundant volatile loads
define i32 @redundant_volatile_load(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @redundant_volatile_load(
; CHECK-NEXT:    [[A:%.*]] = load volatile i32, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    [[B:%.*]] = load volatile i32, ptr [[P1]], align 4
; CHECK-NEXT:    [[RES:%.*]] = sub i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %a = load volatile i32, ptr %P1, align 4
  %b = load volatile i32, ptr %P1, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; Can't DSE a volatile store
define void @volatile_store(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @volatile_store(
; CHECK-NEXT:    store volatile i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    store i32 3, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store volatile i32 0, ptr %P1, align 4
  store i32 3, ptr %P1, align 4
  ret void
}

; Can't DSE a redundant volatile store
define void @redundant_volatile_store(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @redundant_volatile_store(
; CHECK-NEXT:    store volatile i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    store volatile i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store volatile i32 0, ptr %P1, align 4
  store volatile i32 0, ptr %P1, align 4
  ret void
}

; Can value forward from volatiles
define i32 @test20(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test20(
; CHECK-NEXT:    [[A:%.*]] = load volatile i32, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    ret i32 0
;
  %a = load volatile i32, ptr %P1, align 4
  %b = load i32, ptr %P1, align 4
  %res = sub i32 %a, %b
  ret i32 %res
}

; Can DSE a non-volatile store in favor of a volatile one
; currently a missed optimization
define void @test21(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test21(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    store volatile i32 3, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  store volatile i32 3, ptr %P1, align 4
  ret void
}

; Can DSE a normal store in favor of a unordered one
define void @test22(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test22(
; CHECK-NEXT:    store atomic i32 3, ptr [[P1:%.*]] unordered, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr %P1, align 4
  store atomic i32 3, ptr %P1 unordered, align 4
  ret void
}

; Can also DSE a unordered store in favor of a normal one
define void @test23(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test23(
; CHECK-NEXT:    store i32 0, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 3, ptr %P1 unordered, align 4
  store i32 0, ptr %P1, align 4
  ret void
}

; As an implementation limitation, can't remove ordered stores
; Note that we could remove the earlier store if we could
; represent the required ordering.
define void @test24(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test24(
; CHECK-NEXT:    store atomic i32 3, ptr [[P1:%.*]] release, align 4
; CHECK-NEXT:    store i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 3, ptr %P1 release, align 4
  store i32 0, ptr %P1, align 4
  ret void
}

; Can't remove volatile stores - each is independently observable and
; the count of such stores is an observable program side effect.
define void @test25(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test25(
; CHECK-NEXT:    store volatile i32 3, ptr [[P1:%.*]], align 4
; CHECK-NEXT:    store volatile i32 0, ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  store volatile i32 3, ptr %P1, align 4
  store volatile i32 0, ptr %P1, align 4
  ret void
}

; Can DSE a unordered store in favor of a unordered one
define void @test26(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test26(
; CHECK-NEXT:    store atomic i32 3, ptr [[P1:%.*]] unordered, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 0, ptr %P1 unordered, align 4
  store atomic i32 3, ptr %P1 unordered, align 4
  ret void
}

; Can DSE a unordered store in favor of a ordered one,
; but current don't due to implementation limits
define void @test27(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test27(
; CHECK-NEXT:    store atomic i32 0, ptr [[P1:%.*]] unordered, align 4
; CHECK-NEXT:    store atomic i32 3, ptr [[P1]] release, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 0, ptr %P1 unordered, align 4
  store atomic i32 3, ptr %P1 release, align 4
  ret void
}

; Can DSE an unordered atomic store in favor of an
; ordered one, but current don't due to implementation limits
define void @test28(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test28(
; CHECK-NEXT:    store atomic i32 0, ptr [[P1:%.*]] unordered, align 4
; CHECK-NEXT:    store atomic i32 3, ptr [[P1]] release, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 0, ptr %P1 unordered, align 4
  store atomic i32 3, ptr %P1 release, align 4
  ret void
}

; As an implementation limitation, can't remove ordered stores
; see also: @test24
define void @test29(i1 %B, ptr %P1, ptr %P2) {
; CHECK-LABEL: @test29(
; CHECK-NEXT:    store atomic i32 3, ptr [[P1:%.*]] release, align 4
; CHECK-NEXT:    store atomic i32 0, ptr [[P1]] unordered, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 3, ptr %P1 release, align 4
  store atomic i32 0, ptr %P1 unordered, align 4
  ret void
}
