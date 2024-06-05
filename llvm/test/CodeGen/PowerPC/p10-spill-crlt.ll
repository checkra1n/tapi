; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s --check-prefix=CHECK-BE

; This test case tests spilling the CR LT bit on Power10. On Power10, this is
; achieved by setb %reg, %CRREG (lt bit) -> stw %reg, $FI instead of:
; mfocrf %reg, %CRREG -> rlwinm %reg1, %reg, $SH, 0, 0 -> stw %reg1, $FI.

; Without fine-grained control over clobbering individual CR bits,
; it is difficult to produce a concise test case that will ensure a specific
; bit of any CR field is spilled. We need to test the spilling of a CR bit
; other than the LT bit. Hence this test case is rather complex.

%0 = type { %1 }
%1 = type { ptr, ptr, ptr, i32 }

@call_1 = external dso_local unnamed_addr global i32, align 4
declare ptr @call_2() local_unnamed_addr
declare i32 @call_3() local_unnamed_addr
declare void @call_4() local_unnamed_addr

define dso_local void @P10_Spill_CR_LT() local_unnamed_addr {
; CHECK-LABEL: P10_Spill_CR_LT:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    mfcr r12
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stw r12, 8(r1)
; CHECK-NEXT:    stdu r1, -80(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    .cfi_offset cr2, 8
; CHECK-NEXT:    .cfi_offset cr3, 8
; CHECK-NEXT:    .cfi_offset cr4, 8
; CHECK-NEXT:    std r30, 64(r1) # 8-byte Folded Spill
; CHECK-NEXT:    bl call_2@notoc
; CHECK-NEXT:    bc 12, 4*cr5+lt, .LBB0_13
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    bc 4, 4*cr5+lt, .LBB0_14
; CHECK-NEXT:  # %bb.2: # %bb4
; CHECK-NEXT:    cmpdi cr3, r3, 0
; CHECK-NEXT:    # implicit-def: $r30
; CHECK-NEXT:    crnot 4*cr5+lt, 4*cr3+eq
; CHECK-NEXT:    setnbc r3, 4*cr5+lt
; CHECK-NEXT:    stw r3, 60(r1)
; CHECK-NEXT:    lwz r3, 0(r3)
; CHECK-NEXT:    cmpwi cr4, r3, 0
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_3: # %bb12
; CHECK-NEXT:    #
; CHECK-NEXT:    bl call_3@notoc
; CHECK-NEXT:    cmpwi r3, 1
; CHECK-NEXT:    crnand 4*cr5+lt, eq, 4*cr4+gt
; CHECK-NEXT:    bc 4, 4*cr5+lt, .LBB0_8
; CHECK-NEXT:  # %bb.4: # %bb23
; CHECK-NEXT:    #
; CHECK-NEXT:    plwz r3, call_1@PCREL(0), 1
; CHECK-NEXT:    cmplwi r3, 0
; CHECK-NEXT:    bne- cr0, .LBB0_10
; CHECK-NEXT:  # %bb.5: # %bb30
; CHECK-NEXT:    #
; CHECK-NEXT:    bc 12, 4*cr3+eq, .LBB0_9
; CHECK-NEXT:  # %bb.6: # %bb32
; CHECK-NEXT:    #
; CHECK-NEXT:    rlwinm r30, r30, 0, 24, 22
; CHECK-NEXT:    andi. r3, r30, 2
; CHECK-NEXT:    mcrf cr2, cr0
; CHECK-NEXT:    bl call_4@notoc
; CHECK-NEXT:    beq+ cr2, .LBB0_3
; CHECK-NEXT:  # %bb.7: # %bb37
; CHECK-NEXT:  .LBB0_8: # %bb22
; CHECK-NEXT:  .LBB0_9: # %bb35
; CHECK-NEXT:  .LBB0_10: # %bb27
; CHECK-NEXT:    lwz r4, 60(r1)
; CHECK-NEXT:    # implicit-def: $cr5lt
; CHECK-NEXT:    mfocrf r3, 4
; CHECK-NEXT:    rlwimi r3, r4, 12, 20, 20
; CHECK-NEXT:    mtocrf 4, r3
; CHECK-NEXT:    bc 4, 4*cr5+lt, .LBB0_12
; CHECK-NEXT:  # %bb.11: # %bb28
; CHECK-NEXT:  .LBB0_12: # %bb29
; CHECK-NEXT:  .LBB0_13: # %bb3
; CHECK-NEXT:  .LBB0_14: # %bb2
;
; CHECK-BE-LABEL: P10_Spill_CR_LT:
; CHECK-BE:       # %bb.0: # %bb
; CHECK-BE-NEXT:    mfcr r12
; CHECK-BE-NEXT:    mflr r0
; CHECK-BE-NEXT:    std r0, 16(r1)
; CHECK-BE-NEXT:    stw r12, 8(r1)
; CHECK-BE-NEXT:    stdu r1, -160(r1)
; CHECK-BE-NEXT:    .cfi_def_cfa_offset 160
; CHECK-BE-NEXT:    .cfi_offset lr, 16
; CHECK-BE-NEXT:    .cfi_offset r29, -24
; CHECK-BE-NEXT:    .cfi_offset r30, -16
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    std r29, 136(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    std r30, 144(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    bl call_2
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    bc 12, 4*cr5+lt, .LBB0_13
; CHECK-BE-NEXT:  # %bb.1: # %bb
; CHECK-BE-NEXT:    bc 4, 4*cr5+lt, .LBB0_14
; CHECK-BE-NEXT:  # %bb.2: # %bb4
; CHECK-BE-NEXT:    cmpdi cr3, r3, 0
; CHECK-BE-NEXT:    addis r30, r2, call_1@toc@ha
; CHECK-BE-NEXT:    # implicit-def: $r29
; CHECK-BE-NEXT:    crnot 4*cr5+lt, 4*cr3+eq
; CHECK-BE-NEXT:    setnbc r3, 4*cr5+lt
; CHECK-BE-NEXT:    stw r3, 132(r1)
; CHECK-BE-NEXT:    lwz r3, 0(r3)
; CHECK-BE-NEXT:    cmpwi cr4, r3, 0
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_3: # %bb12
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    bl call_3
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    cmpwi r3, 1
; CHECK-BE-NEXT:    crnand 4*cr5+lt, eq, 4*cr4+gt
; CHECK-BE-NEXT:    bc 4, 4*cr5+lt, .LBB0_8
; CHECK-BE-NEXT:  # %bb.4: # %bb23
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    lwz r3, call_1@toc@l(r30)
; CHECK-BE-NEXT:    cmplwi r3, 0
; CHECK-BE-NEXT:    bne- cr0, .LBB0_10
; CHECK-BE-NEXT:  # %bb.5: # %bb30
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    bc 12, 4*cr3+eq, .LBB0_9
; CHECK-BE-NEXT:  # %bb.6: # %bb32
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    rlwinm r29, r29, 0, 24, 22
; CHECK-BE-NEXT:    andi. r3, r29, 2
; CHECK-BE-NEXT:    mcrf cr2, cr0
; CHECK-BE-NEXT:    bl call_4
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    beq+ cr2, .LBB0_3
; CHECK-BE-NEXT:  # %bb.7: # %bb37
; CHECK-BE-NEXT:  .LBB0_8: # %bb22
; CHECK-BE-NEXT:  .LBB0_9: # %bb35
; CHECK-BE-NEXT:  .LBB0_10: # %bb27
; CHECK-BE-NEXT:    lwz r4, 132(r1)
; CHECK-BE-NEXT:    # implicit-def: $cr5lt
; CHECK-BE-NEXT:    mfocrf r3, 4
; CHECK-BE-NEXT:    rlwimi r3, r4, 12, 20, 20
; CHECK-BE-NEXT:    mtocrf 4, r3
; CHECK-BE-NEXT:    bc 4, 4*cr5+lt, .LBB0_12
; CHECK-BE-NEXT:  # %bb.11: # %bb28
; CHECK-BE-NEXT:  .LBB0_12: # %bb29
; CHECK-BE-NEXT:  .LBB0_13: # %bb3
; CHECK-BE-NEXT:  .LBB0_14: # %bb2
bb:
  %tmp = tail call ptr @call_2()
  %tmp1 = icmp ne ptr %tmp, null
  switch i32 undef, label %bb4 [
    i32 3, label %bb2
    i32 2, label %bb3
  ]

bb2:                                              ; preds = %bb
  unreachable

bb3:                                              ; preds = %bb
  unreachable

bb4:                                              ; preds = %bb
  %tmp5 = load i64, ptr undef, align 8
  %tmp6 = trunc i64 %tmp5 to i32
  %tmp7 = add i32 0, %tmp6
  %tmp8 = icmp sgt i32 %tmp7, 0
  %tmp9 = icmp eq i8 0, 0
  %tmp10 = zext i1 %tmp9 to i32
  %tmp11 = icmp eq ptr %tmp, null
  br label %bb12

bb12:                                             ; preds = %bb38, %bb4
  %tmp13 = phi i32 [ %tmp10, %bb4 ], [ undef, %bb38 ]
  %tmp14 = phi i32 [ undef, %bb4 ], [ %tmp17, %bb38 ]
  %tmp15 = icmp ne i32 %tmp13, 0
  %tmp16 = and i32 %tmp14, -257
  %tmp17 = select i1 %tmp15, i32 %tmp16, i32 undef
  br label %bb18

bb18:                                             ; preds = %bb12
  %tmp19 = call zeroext i32 @call_3()
  %tmp20 = icmp eq i32 %tmp19, 1
  %tmp21 = and i1 %tmp8, %tmp20
  br i1 %tmp21, label %bb22, label %bb23

bb22:                                             ; preds = %bb18
  unreachable

bb23:                                             ; preds = %bb18
  br label %bb24

bb24:                                             ; preds = %bb23
  %tmp25 = load i32, ptr @call_1, align 4
  %tmp26 = icmp eq i32 %tmp25, 0
  br i1 %tmp26, label %bb30, label %bb27

bb27:                                             ; preds = %bb24
  br i1 %tmp1, label %bb28, label %bb29

bb28:                                             ; preds = %bb27
  unreachable

bb29:                                             ; preds = %bb27
  unreachable

bb30:                                             ; preds = %bb24
  br label %bb31

bb31:                                             ; preds = %bb30
  br i1 %tmp11, label %bb35, label %bb32

bb32:                                             ; preds = %bb31
  %tmp33 = and i32 %tmp17, 2
  %tmp34 = icmp eq i32 %tmp33, 0
  call void @call_4()
  br label %bb36

bb35:                                             ; preds = %bb31
  unreachable

bb36:                                             ; preds = %bb32
  br i1 %tmp34, label %bb38, label %bb37

bb37:                                             ; preds = %bb36
  unreachable

bb38:                                             ; preds = %bb36
  br label %bb12
}

