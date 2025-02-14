; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -o - -mtriple=arm64e-apple-macosx -min-jump-table-entries=2 %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

define swifttailcc void @test_async_with_jumptable_x16_clobbered(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_x16_clobbered:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x0, x16
; CHECK-NEXT:    ldr x16, [x22]
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh0:
; CHECK-NEXT:    adrp x17, LJTI0_0@PAGE
; CHECK-NEXT:  Lloh1:
; CHECK-NEXT:    add x17, x17, LJTI0_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp0:
; CHECK-NEXT:    adr x17, Ltmp0
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB0_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB0_3
; CHECK-NEXT:  LBB0_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB0_3: ; %exit
; CHECK-NEXT:    mov x16, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh0, Lloh1
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI0_0:
; CHECK-NEXT:    .long LBB0_3-Ltmp0
; CHECK-NEXT:    .long LBB0_1-Ltmp0
; CHECK-NEXT:    .long LBB0_1-Ltmp0
; CHECK-NEXT:    .long LBB0_2-Ltmp0
entry:
  %x16 = tail call i64 asm "", "={x16}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x16}"(i64 %x16)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

define swifttailcc void @test_async_with_jumptable_x17_clobbered(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_x17_clobbered:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ldr x16, [x0]
; CHECK-NEXT:    mov x0, x17
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh2:
; CHECK-NEXT:    adrp x17, LJTI1_0@PAGE
; CHECK-NEXT:  Lloh3:
; CHECK-NEXT:    add x17, x17, LJTI1_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp1:
; CHECK-NEXT:    adr x17, Ltmp1
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB1_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB1_3
; CHECK-NEXT:  LBB1_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB1_3: ; %exit
; CHECK-NEXT:    mov x17, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh2, Lloh3
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI1_0:
; CHECK-NEXT:    .long LBB1_3-Ltmp1
; CHECK-NEXT:    .long LBB1_1-Ltmp1
; CHECK-NEXT:    .long LBB1_1-Ltmp1
; CHECK-NEXT:    .long LBB1_2-Ltmp1
entry:
  %x17 = tail call i64 asm "", "={x17}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x17}"(i64 %x17)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

define swifttailcc void @test_async_with_jumptable_x1_clobbered(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_x1_clobbered:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ldr x16, [x0]
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh4:
; CHECK-NEXT:    adrp x17, LJTI2_0@PAGE
; CHECK-NEXT:  Lloh5:
; CHECK-NEXT:    add x17, x17, LJTI2_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp2:
; CHECK-NEXT:    adr x17, Ltmp2
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB2_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB2_3
; CHECK-NEXT:  LBB2_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB2_3: ; %exit
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh4, Lloh5
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI2_0:
; CHECK-NEXT:    .long LBB2_3-Ltmp2
; CHECK-NEXT:    .long LBB2_1-Ltmp2
; CHECK-NEXT:    .long LBB2_1-Ltmp2
; CHECK-NEXT:    .long LBB2_2-Ltmp2
entry:
  %x1 = tail call i64 asm "", "={x1}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x1}"(i64 %x1)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

define swifttailcc void @test_async_with_jumptable_x1_x9_clobbered(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_x1_x9_clobbered:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ldr x16, [x0]
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh6:
; CHECK-NEXT:    adrp x17, LJTI3_0@PAGE
; CHECK-NEXT:  Lloh7:
; CHECK-NEXT:    add x17, x17, LJTI3_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp3:
; CHECK-NEXT:    adr x17, Ltmp3
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB3_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB3_3
; CHECK-NEXT:  LBB3_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB3_3: ; %exit
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh6, Lloh7
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI3_0:
; CHECK-NEXT:    .long LBB3_3-Ltmp3
; CHECK-NEXT:    .long LBB3_1-Ltmp3
; CHECK-NEXT:    .long LBB3_1-Ltmp3
; CHECK-NEXT:    .long LBB3_2-Ltmp3
entry:
  %x1 = tail call i64 asm "", "={x1}"()
  %x9 = tail call i64 asm "", "={x9}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x1}"(i64 %x1)
  tail call void asm sideeffect "", "{x9}"(i64 %x9)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

; There are 2 available scratch registers left, shrink-wrapping can happen.
define swifttailcc void @test_async_with_jumptable_2_available_regs_left(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_2_available_regs_left:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x0, x16
; CHECK-NEXT:    ldr x16, [x22]
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh8:
; CHECK-NEXT:    adrp x17, LJTI4_0@PAGE
; CHECK-NEXT:  Lloh9:
; CHECK-NEXT:    add x17, x17, LJTI4_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp4:
; CHECK-NEXT:    adr x17, Ltmp4
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB4_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB4_3
; CHECK-NEXT:  LBB4_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB4_3: ; %exit
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x16, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh8, Lloh9
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI4_0:
; CHECK-NEXT:    .long LBB4_3-Ltmp4
; CHECK-NEXT:    .long LBB4_1-Ltmp4
; CHECK-NEXT:    .long LBB4_1-Ltmp4
; CHECK-NEXT:    .long LBB4_2-Ltmp4
entry:
  %x1 = tail call i64 asm "", "={x1}"()
  %x2 = tail call i64 asm "", "={x2}"()
  %x3 = tail call i64 asm "", "={x3}"()
  %x4 = tail call i64 asm "", "={x4}"()
  %x5 = tail call i64 asm "", "={x5}"()
  %x6 = tail call i64 asm "", "={x6}"()
  %x7 = tail call i64 asm "", "={x7}"()
  %x8 = tail call i64 asm "", "={x8}"()
  %x9 = tail call i64 asm "", "={x9}"()
  %x11 = tail call i64 asm "", "={x11}"()
  %x12 = tail call i64 asm "", "={x12}"()
  %x13 = tail call i64 asm "", "={x13}"()
  %x14 = tail call i64 asm "", "={x14}"()
  %x15 = tail call i64 asm "", "={x15}"()
  %x16 = tail call i64 asm "", "={x16}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x1}"(i64 %x1)
  tail call void asm sideeffect "", "{x2}"(i64 %x2)
  tail call void asm sideeffect "", "{x3}"(i64 %x3)
  tail call void asm sideeffect "", "{x4}"(i64 %x4)
  tail call void asm sideeffect "", "{x5}"(i64 %x5)
  tail call void asm sideeffect "", "{x6}"(i64 %x6)
  tail call void asm sideeffect "", "{x7}"(i64 %x7)
  tail call void asm sideeffect "", "{x8}"(i64 %x8)
  tail call void asm sideeffect "", "{x9}"(i64 %x9)
  tail call void asm sideeffect "", "{x11}"(i64 %x11)
  tail call void asm sideeffect "", "{x12}"(i64 %x12)
  tail call void asm sideeffect "", "{x13}"(i64 %x13)
  tail call void asm sideeffect "", "{x14}"(i64 %x14)
  tail call void asm sideeffect "", "{x15}"(i64 %x15)
  tail call void asm sideeffect "", "{x16}"(i64 %x16)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

; There is only 1 available scratch registers left, shrink-wrapping cannot
; happen because StoreSwiftAsyncContext needs 2 free scratch registers.
define swifttailcc void @test_async_with_jumptable_1_available_reg_left(ptr %src, ptr swiftasync %as) #0 {
; CHECK-LABEL: test_async_with_jumptable_1_available_reg_left:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    orr x29, x29, #0x1000000000000000
; CHECK-NEXT:    str x19, [sp, #-32]! ; 8-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #16] ; 16-byte Folded Spill
; CHECK-NEXT:    add x16, sp, #8
; CHECK-NEXT:    movk x16, #49946, lsl #48
; CHECK-NEXT:    mov x17, x22
; CHECK-NEXT:    pacdb x17, x16
; CHECK-NEXT:    str x17, [sp, #8]
; CHECK-NEXT:    add x29, sp, #16
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset w19, -32
; CHECK-NEXT:    mov x20, x22
; CHECK-NEXT:    mov x22, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x0, x16
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ldr x16, [x22]
; CHECK-NEXT:    mov x10, x17
; CHECK-NEXT:    mov x19, x20
; CHECK-NEXT:    cmp x16, #3
; CHECK-NEXT:    csel x16, x16, xzr, ls
; CHECK-NEXT:  Lloh10:
; CHECK-NEXT:    adrp x17, LJTI5_0@PAGE
; CHECK-NEXT:  Lloh11:
; CHECK-NEXT:    add x17, x17, LJTI5_0@PAGEOFF
; CHECK-NEXT:    ldrsw x16, [x17, x16, lsl #2]
; CHECK-NEXT:  Ltmp5:
; CHECK-NEXT:    adr x17, Ltmp5
; CHECK-NEXT:    add x16, x17, x16
; CHECK-NEXT:    br x16
; CHECK-NEXT:  LBB5_1: ; %then.2
; CHECK-NEXT:    mov x19, #0 ; =0x0
; CHECK-NEXT:    b LBB5_3
; CHECK-NEXT:  LBB5_2: ; %then.3
; CHECK-NEXT:    mov x19, x22
; CHECK-NEXT:  LBB5_3: ; %exit
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x16, x0
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    mov x17, x10
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    bl _foo
; CHECK-NEXT:    mov x2, x0
; CHECK-NEXT:    mov x0, x19
; CHECK-NEXT:    mov x1, x20
; CHECK-NEXT:    ldp x29, x30, [sp, #16] ; 16-byte Folded Reload
; CHECK-NEXT:    ldr x19, [sp], #32 ; 8-byte Folded Reload
; CHECK-NEXT:    and x29, x29, #0xefffffffffffffff
; CHECK-NEXT:    br x2
; CHECK-NEXT:    .loh AdrpAdd Lloh10, Lloh11
; CHECK-NEXT:    .cfi_endproc
; CHECK-NEXT:    .section __TEXT,__const
; CHECK-NEXT:    .p2align 2, 0x0
; CHECK-NEXT:  LJTI5_0:
; CHECK-NEXT:    .long LBB5_3-Ltmp5
; CHECK-NEXT:    .long LBB5_1-Ltmp5
; CHECK-NEXT:    .long LBB5_1-Ltmp5
; CHECK-NEXT:    .long LBB5_2-Ltmp5
entry:
  %x1 = tail call i64 asm "", "={x1}"()
  %x2 = tail call i64 asm "", "={x2}"()
  %x3 = tail call i64 asm "", "={x3}"()
  %x4 = tail call i64 asm "", "={x4}"()
  %x5 = tail call i64 asm "", "={x5}"()
  %x6 = tail call i64 asm "", "={x6}"()
  %x7 = tail call i64 asm "", "={x7}"()
  %x8 = tail call i64 asm "", "={x8}"()
  %x9 = tail call i64 asm "", "={x9}"()
  %x11 = tail call i64 asm "", "={x11}"()
  %x12 = tail call i64 asm "", "={x12}"()
  %x13 = tail call i64 asm "", "={x13}"()
  %x14 = tail call i64 asm "", "={x14}"()
  %x15 = tail call i64 asm "", "={x15}"()
  %x16 = tail call i64 asm "", "={x16}"()
  %x17 = tail call i64 asm "", "={x17}"()
  %l = load i64, ptr %src, align 8
  switch i64 %l, label %dead [
    i64 0, label %exit
    i64 1, label %then.1
    i64 2, label %then.2
    i64 3, label %then.3
  ]

then.1:
  br label %exit

then.2:
  br label %exit

then.3:
  br label %exit

dead:                                                ; preds = %entryresume.5
  unreachable

exit:
  %p = phi ptr [ %src, %then.3 ], [ null, %then.2 ], [ %as, %entry ], [ null, %then.1 ]
  tail call void asm sideeffect "", "{x1}"(i64 %x1)
  tail call void asm sideeffect "", "{x2}"(i64 %x2)
  tail call void asm sideeffect "", "{x3}"(i64 %x3)
  tail call void asm sideeffect "", "{x4}"(i64 %x4)
  tail call void asm sideeffect "", "{x5}"(i64 %x5)
  tail call void asm sideeffect "", "{x6}"(i64 %x6)
  tail call void asm sideeffect "", "{x7}"(i64 %x7)
  tail call void asm sideeffect "", "{x8}"(i64 %x8)
  tail call void asm sideeffect "", "{x9}"(i64 %x9)
  tail call void asm sideeffect "", "{x11}"(i64 %x11)
  tail call void asm sideeffect "", "{x12}"(i64 %x12)
  tail call void asm sideeffect "", "{x13}"(i64 %x13)
  tail call void asm sideeffect "", "{x14}"(i64 %x14)
  tail call void asm sideeffect "", "{x15}"(i64 %x15)
  tail call void asm sideeffect "", "{x16}"(i64 %x16)
  tail call void asm sideeffect "", "{x17}"(i64 %x17)
  %r = call i64 @foo()
  %fn = inttoptr i64 %r to ptr
  musttail call swifttailcc void %fn(ptr swiftasync %src, ptr %p, ptr %as)
  ret void
}

declare i64 @foo()

attributes #0 = { "frame-pointer"="non-leaf" }
