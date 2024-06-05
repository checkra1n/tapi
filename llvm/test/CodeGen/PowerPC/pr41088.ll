; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -ppc-asm-full-reg-names \
; RUN:   -mtriple=powerpc64le-unknown-unknown -verify-machineinstrs < %s | \
; RUN:   FileCheck %s

%0 = type { [0 x i64], %1, [0 x i64], { i64, ptr }, [0 x i64] }
%1 = type { [0 x i64], %2, [0 x i64], ptr, [0 x i64] }
%2 = type { [0 x i64], %3, [0 x i64], %4, [0 x i8], i8, [7 x i8] }
%3 = type { [0 x i64], { ptr, ptr }, [0 x i64], ptr, [0 x i8], i8, [7 x i8] }
%4 = type { [0 x i64], { ptr, ptr }, [0 x i64], %5, [0 x i64] }
%5 = type { [0 x i64], { ptr, ptr }, [0 x i64], ptr, [0 x i64] }
%6 = type { [0 x i64], i64, [2 x i64] }
%7 = type { [0 x i64], { ptr, ptr }, [0 x i64], %8, [0 x i64] }
%8 = type { [0 x i64], ptr, [0 x i32], { i32, i32 }, [0 x i8], i8, [7 x i8] }
%9 = type { [0 x i64], i64, [0 x i64], [0 x %10], [0 x i8], %11 }
%10 = type { [0 x i8], i8, [31 x i8] }
%11 = type {}
%12 = type { [0 x i64], %13, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%13 = type { [0 x i8], i8, [23 x i8] }
%14 = type { [0 x i64], i64, [0 x i64], %15, [0 x i32], i32, [0 x i8], i8, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [0 x i8], { i8, i8 }, [7 x i8] }
%15 = type { [0 x i64], { ptr, i64 }, [0 x i64], i64, [0 x i64] }
%16 = type { [0 x i64], %17, [0 x i64], %18, [0 x i64], %19, [0 x i64], i64, [0 x i8], { i8, i8 }, [6 x i8] }
%17 = type { [0 x i32], i32, [27 x i32] }
%18 = type { [0 x i64], i64, [6 x i64] }
%19 = type { [0 x i8], i8, [103 x i8] }
%20 = type { [0 x i64], ptr, [0 x i64], ptr, [0 x i64], ptr, [0 x i64] }
%21 = type { [0 x i64], i64, [0 x i64], ptr, [0 x i64], [2 x i64], [0 x i64] }
%22 = type { [0 x i8] }

@var = external dso_local unnamed_addr constant <{ ptr, [8 x i8], ptr, [16 x i8] }>, align 8

declare dso_local fastcc { ptr, ptr } @test2(ptr) unnamed_addr

define void @test(ptr %arg, ptr %arg1, ptr %arg2) unnamed_addr personality ptr @personality {
; CHECK-LABEL: test:
; CHECK:         .cfi_personality 148, DW.ref.personality
; CHECK-NEXT:    .cfi_lsda 20, .Lexception0
; CHECK-NEXT:  .Lfunc_gep0:
; CHECK-NEXT:    addis r2, r12, .TOC.-.Lfunc_gep0@ha
; CHECK-NEXT:    addi r2, r2, .TOC.-.Lfunc_gep0@l
; CHECK-NEXT:  .Lfunc_lep0:
; CHECK-NEXT:    .localentry test, .Lfunc_lep0-.Lfunc_gep0
; CHECK-NEXT:  # %bb.0: # %bb
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -32(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:  # %bb.1: # %bb9
; CHECK-NEXT:    bl test5
; CHECK-NEXT:    nop
; CHECK-NEXT:    rlwinm r4, r3, 8, 16, 23
; CHECK-NEXT:  # %bb.2: # %bb12
; CHECK-NEXT:    bl test3
; CHECK-NEXT:    nop
; CHECK-NEXT:    addi r1, r1, 32
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
bb:
  switch i64 undef, label %bb21 [
    i64 3, label %bb3
  ]

bb3:                                              ; preds = %bb
  switch i3 undef, label %bb4 [
    i3 0, label %bb9
    i3 1, label %bb12
  ]

bb4:                                              ; preds = %bb3
  unreachable

bb5:                                              ; No predecessors!
  br label %bb12

bb6:                                              ; No predecessors!
  br label %bb12

bb7:                                              ; No predecessors!
  br label %bb12

bb8:                                              ; No predecessors!
  br label %bb12

bb9:                                              ; preds = %bb3
  %tmp = call i8 @test5(ptr noalias nonnull readonly align 8 dereferenceable(64) undef), !range !0
  %tmp10 = zext i8 %tmp to i24
  %tmp11 = shl nuw nsw i24 %tmp10, 8
  br label %bb12

bb12:                                             ; preds = %bb9, %bb8, %bb7, %bb6, %bb5, %bb3
  %tmp13 = phi i24 [ 1024, %bb8 ], [ 768, %bb7 ], [ 512, %bb6 ], [ 256, %bb5 ], [ %tmp11, %bb9 ], [ 0, %bb3 ]
  %tmp14 = call fastcc align 8 dereferenceable(288) ptr @test3(ptr noalias nonnull readonly align 8 dereferenceable(24) undef, i24 %tmp13)
  br label %bb22

bb15:                                             ; No predecessors!
  %tmp16 = invoke fastcc { ptr, ptr } @test2(ptr nonnull align 8 dereferenceable(8) undef)
          to label %bb17 unwind label %bb18

bb17:                                             ; preds = %bb15
  invoke void @test4(ptr noalias readonly align 8 dereferenceable(40) @var)
          to label %bb23 unwind label %bb25

bb18:                                             ; preds = %bb15
  %tmp19 = landingpad { ptr, i32 }
          cleanup
  resume { ptr, i32 } undef

bb20:                                             ; No predecessors!
  invoke void @test4(ptr noalias readonly align 8 dereferenceable(40) @var)
          to label %bb24 unwind label %bb25

bb21:                                             ; preds = %bb
  unreachable

bb22:                                             ; preds = %bb12
  ret void

bb23:                                             ; preds = %bb17
  unreachable

bb24:                                             ; preds = %bb20
  unreachable

bb25:                                             ; preds = %bb20, %bb17
  %tmp26 = landingpad { ptr, i32 }
          cleanup
  resume { ptr, i32 } undef
}

declare dso_local fastcc ptr @test3(ptr, i24) unnamed_addr

declare i32 @personality(i32, i32, i64, ptr, ptr) unnamed_addr

declare void @test4(ptr) unnamed_addr

declare i8 @test5(ptr) unnamed_addr

!0 = !{i8 0, i8 5}
