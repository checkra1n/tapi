; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IM %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IM %s

define i32 @udiv(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: udiv:
; RV32I:       # %bb.0:
; RV32I-NEXT:    tail __udivsi3@plt
;
; RV32IM-LABEL: udiv:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    divu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    slli a1, a1, 32
; RV64I-NEXT:    srli a1, a1, 32
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @udiv_constant(i32 %a) nounwind {
; RV32I-LABEL: udiv_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    tail __udivsi3@plt
;
; RV32IM-LABEL: udiv_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lui a1, 838861
; RV32IM-NEXT:    addi a1, a1, -819
; RV32IM-NEXT:    mulhu a0, a0, a1
; RV32IM-NEXT:    srli a0, a0, 2
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    lui a1, 838861
; RV64IM-NEXT:    addiw a1, a1, -819
; RV64IM-NEXT:    slli a1, a1, 32
; RV64IM-NEXT:    mulhu a0, a0, a1
; RV64IM-NEXT:    srli a0, a0, 34
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, 5
  ret i32 %1
}

define i32 @udiv_pow2(i32 %a) nounwind {
; RV32I-LABEL: udiv_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 3
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    srli a0, a0, 3
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srliw a0, a0, 3
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    srliw a0, a0, 3
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, 8
  ret i32 %1
}

define i32 @udiv_constant_lhs(i32 %a) nounwind {
; RV32I-LABEL: udiv_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    li a0, 10
; RV32I-NEXT:    tail __udivsi3@plt
;
; RV32IM-LABEL: udiv_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    li a1, 10
; RV32IM-NEXT:    divu a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a1, a0, 32
; RV64I-NEXT:    li a0, 10
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    li a1, 10
; RV64IM-NEXT:    divuw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = udiv i32 10, %a
  ret i32 %1
}

define i64 @udiv64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: udiv64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __udivdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv64:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    call __udivdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    tail __udivdi3@plt
;
; RV64IM-LABEL: udiv64:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divu a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i64 %a, %b
  ret i64 %1
}

define i64 @udiv64_constant(i64 %a) nounwind {
; RV32I-LABEL: udiv64_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    li a2, 5
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __udivdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv64_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    add a2, a0, a1
; RV32IM-NEXT:    sltu a3, a2, a0
; RV32IM-NEXT:    add a2, a2, a3
; RV32IM-NEXT:    lui a3, 838861
; RV32IM-NEXT:    addi a4, a3, -819
; RV32IM-NEXT:    mulhu a5, a2, a4
; RV32IM-NEXT:    srli a6, a5, 2
; RV32IM-NEXT:    andi a5, a5, -4
; RV32IM-NEXT:    add a5, a5, a6
; RV32IM-NEXT:    sub a2, a2, a5
; RV32IM-NEXT:    sub a5, a0, a2
; RV32IM-NEXT:    addi a3, a3, -820
; RV32IM-NEXT:    mul a3, a5, a3
; RV32IM-NEXT:    mulhu a6, a5, a4
; RV32IM-NEXT:    add a3, a6, a3
; RV32IM-NEXT:    sltu a0, a0, a2
; RV32IM-NEXT:    sub a0, a1, a0
; RV32IM-NEXT:    mul a0, a0, a4
; RV32IM-NEXT:    add a1, a3, a0
; RV32IM-NEXT:    mul a0, a5, a4
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv64_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    tail __udivdi3@plt
;
; RV64IM-LABEL: udiv64_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lui a1, %hi(.LCPI5_0)
; RV64IM-NEXT:    ld a1, %lo(.LCPI5_0)(a1)
; RV64IM-NEXT:    mulhu a0, a0, a1
; RV64IM-NEXT:    srli a0, a0, 2
; RV64IM-NEXT:    ret
  %1 = udiv i64 %a, 5
  ret i64 %1
}

define i64 @udiv64_constant_lhs(i64 %a) nounwind {
; RV32I-LABEL: udiv64_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    li a0, 10
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    call __udivdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv64_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    mv a3, a1
; RV32IM-NEXT:    mv a2, a0
; RV32IM-NEXT:    li a0, 10
; RV32IM-NEXT:    li a1, 0
; RV32IM-NEXT:    call __udivdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv64_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:    li a0, 10
; RV64I-NEXT:    tail __udivdi3@plt
;
; RV64IM-LABEL: udiv64_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    li a1, 10
; RV64IM-NEXT:    divu a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = udiv i64 10, %a
  ret i64 %1
}

define i8 @udiv8(i8 %a, i8 %b) nounwind {
; RV32I-LABEL: udiv8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    andi a1, a1, 255
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv8:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    andi a1, a1, 255
; RV32IM-NEXT:    andi a0, a0, 255
; RV32IM-NEXT:    divu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    andi a1, a1, 255
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    andi a1, a1, 255
; RV64IM-NEXT:    andi a0, a0, 255
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i8 %a, %b
  ret i8 %1
}

define i8 @udiv8_constant(i8 %a) nounwind {
; RV32I-LABEL: udiv8_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv8_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    andi a0, a0, 255
; RV32IM-NEXT:    li a1, 205
; RV32IM-NEXT:    mul a0, a0, a1
; RV32IM-NEXT:    srli a0, a0, 10
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv8_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv8_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    andi a0, a0, 255
; RV64IM-NEXT:    li a1, 205
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    srli a0, a0, 10
; RV64IM-NEXT:    ret
  %1 = udiv i8 %a, 5
  ret i8 %1
}

define i8 @udiv8_pow2(i8 %a) nounwind {
; RV32I-LABEL: udiv8_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv8_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srli a0, a0, 27
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv8_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srli a0, a0, 59
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv8_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srli a0, a0, 59
; RV64IM-NEXT:    ret
  %1 = udiv i8 %a, 8
  ret i8 %1
}

define i8 @udiv8_constant_lhs(i8 %a) nounwind {
; RV32I-LABEL: udiv8_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    andi a1, a0, 255
; RV32I-NEXT:    li a0, 10
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv8_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    andi a0, a0, 255
; RV32IM-NEXT:    li a1, 10
; RV32IM-NEXT:    divu a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv8_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    andi a1, a0, 255
; RV64I-NEXT:    li a0, 10
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv8_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    andi a0, a0, 255
; RV64IM-NEXT:    li a1, 10
; RV64IM-NEXT:    divuw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = udiv i8 10, %a
  ret i8 %1
}

define i16 @udiv16(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: udiv16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv16:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lui a2, 16
; RV32IM-NEXT:    addi a2, a2, -1
; RV32IM-NEXT:    and a1, a1, a2
; RV32IM-NEXT:    and a0, a0, a2
; RV32IM-NEXT:    divu a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lui a2, 16
; RV64I-NEXT:    addiw a2, a2, -1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lui a2, 16
; RV64IM-NEXT:    addiw a2, a2, -1
; RV64IM-NEXT:    and a1, a1, a2
; RV64IM-NEXT:    and a0, a0, a2
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i16 %a, %b
  ret i16 %1
}

define i16 @udiv16_constant(i16 %a) nounwind {
; RV32I-LABEL: udiv16_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 16
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv16_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    lui a1, 838864
; RV32IM-NEXT:    mulhu a0, a0, a1
; RV32IM-NEXT:    srli a0, a0, 18
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv16_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv16_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lui a1, 52429
; RV64IM-NEXT:    slli a1, a1, 4
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    mulhu a0, a0, a1
; RV64IM-NEXT:    srli a0, a0, 18
; RV64IM-NEXT:    ret
  %1 = udiv i16 %a, 5
  ret i16 %1
}

define i16 @udiv16_pow2(i16 %a) nounwind {
; RV32I-LABEL: udiv16_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 19
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv16_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srli a0, a0, 19
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv16_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 51
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv16_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srli a0, a0, 51
; RV64IM-NEXT:    ret
  %1 = udiv i16 %a, 8
  ret i16 %1
}

define i16 @udiv16_constant_lhs(i16 %a) nounwind {
; RV32I-LABEL: udiv16_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    li a0, 10
; RV32I-NEXT:    call __udivsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: udiv16_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srli a0, a0, 16
; RV32IM-NEXT:    li a1, 10
; RV32IM-NEXT:    divu a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: udiv16_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a1, a0, 48
; RV64I-NEXT:    li a0, 10
; RV64I-NEXT:    call __udivdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: udiv16_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srli a0, a0, 48
; RV64IM-NEXT:    li a1, 10
; RV64IM-NEXT:    divuw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = udiv i16 10, %a
  ret i16 %1
}

define i32 @sdiv(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sdiv:
; RV32I:       # %bb.0:
; RV32I-NEXT:    tail __divsi3@plt
;
; RV32IM-LABEL: sdiv:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    div a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @sdiv_constant(i32 %a) nounwind {
; RV32I-LABEL: sdiv_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    tail __divsi3@plt
;
; RV32IM-LABEL: sdiv_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    lui a1, 419430
; RV32IM-NEXT:    addi a1, a1, 1639
; RV32IM-NEXT:    mulh a0, a0, a1
; RV32IM-NEXT:    srli a1, a0, 31
; RV32IM-NEXT:    srai a0, a0, 1
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    sext.w a0, a0
; RV64IM-NEXT:    lui a1, 419430
; RV64IM-NEXT:    addiw a1, a1, 1639
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    srli a1, a0, 63
; RV64IM-NEXT:    srai a0, a0, 33
; RV64IM-NEXT:    add a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, 5
  ret i32 %1
}

define i32 @sdiv_pow2(i32 %a) nounwind {
; RV32I-LABEL: sdiv_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 29
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 3
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    srai a1, a0, 31
; RV32IM-NEXT:    srli a1, a1, 29
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    srai a0, a0, 3
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 29
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 3
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    sraiw a1, a0, 31
; RV64IM-NEXT:    srliw a1, a1, 29
; RV64IM-NEXT:    addw a0, a0, a1
; RV64IM-NEXT:    sraiw a0, a0, 3
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, 8
  ret i32 %1
}

define i32 @sdiv_pow2_2(i32 %a) nounwind {
; RV32I-LABEL: sdiv_pow2_2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srli a1, a1, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv_pow2_2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    srai a1, a0, 31
; RV32IM-NEXT:    srli a1, a1, 16
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    srai a0, a0, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv_pow2_2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    srliw a1, a1, 16
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    sraiw a0, a0, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv_pow2_2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    sraiw a1, a0, 31
; RV64IM-NEXT:    srliw a1, a1, 16
; RV64IM-NEXT:    addw a0, a0, a1
; RV64IM-NEXT:    sraiw a0, a0, 16
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, 65536
  ret i32 %1
}

define i32 @sdiv_constant_lhs(i32 %a) nounwind {
; RV32I-LABEL: sdiv_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    li a0, -10
; RV32I-NEXT:    tail __divsi3@plt
;
; RV32IM-LABEL: sdiv_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    li a1, -10
; RV32IM-NEXT:    div a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a1, a0
; RV64I-NEXT:    li a0, -10
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    li a1, -10
; RV64IM-NEXT:    divw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = sdiv i32 -10, %a
  ret i32 %1
}

define i64 @sdiv64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: sdiv64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __divdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv64:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    call __divdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    tail __divdi3@plt
;
; RV64IM-LABEL: sdiv64:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    div a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i64 %a, %b
  ret i64 %1
}

define i64 @sdiv64_constant(i64 %a) nounwind {
; RV32I-LABEL: sdiv64_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    li a2, 5
; RV32I-NEXT:    li a3, 0
; RV32I-NEXT:    call __divdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv64_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    li a2, 5
; RV32IM-NEXT:    li a3, 0
; RV32IM-NEXT:    call __divdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv64_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    tail __divdi3@plt
;
; RV64IM-LABEL: sdiv64_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    lui a1, %hi(.LCPI21_0)
; RV64IM-NEXT:    ld a1, %lo(.LCPI21_0)(a1)
; RV64IM-NEXT:    mulh a0, a0, a1
; RV64IM-NEXT:    srli a1, a0, 63
; RV64IM-NEXT:    srai a0, a0, 1
; RV64IM-NEXT:    add a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i64 %a, 5
  ret i64 %1
}

define i64 @sdiv64_constant_lhs(i64 %a) nounwind {
; RV32I-LABEL: sdiv64_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    li a0, 10
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    call __divdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv64_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    mv a3, a1
; RV32IM-NEXT:    mv a2, a0
; RV32IM-NEXT:    li a0, 10
; RV32IM-NEXT:    li a1, 0
; RV32IM-NEXT:    call __divdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv64_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:    li a0, 10
; RV64I-NEXT:    tail __divdi3@plt
;
; RV64IM-LABEL: sdiv64_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    li a1, 10
; RV64IM-NEXT:    div a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = sdiv i64 10, %a
  ret i64 %1
}

; Although this sdiv has two sexti32 operands, it shouldn't compile to divw on
; RV64M as that wouldn't produce the correct result for e.g. INT_MIN/-1.

define i64 @sdiv64_sext_operands(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sdiv64_sext_operands:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    srai a3, a2, 31
; RV32I-NEXT:    call __divdi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv64_sext_operands:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    addi sp, sp, -16
; RV32IM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IM-NEXT:    mv a2, a1
; RV32IM-NEXT:    srai a1, a0, 31
; RV32IM-NEXT:    srai a3, a2, 31
; RV32IM-NEXT:    call __divdi3@plt
; RV32IM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IM-NEXT:    addi sp, sp, 16
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv64_sext_operands:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    tail __divdi3@plt
;
; RV64IM-LABEL: sdiv64_sext_operands:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    sext.w a0, a0
; RV64IM-NEXT:    sext.w a1, a1
; RV64IM-NEXT:    div a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sext i32 %a to i64
  %2 = sext i32 %b to i64
  %3 = sdiv i64 %1, %2
  ret i64 %3
}

define i8 @sdiv8(i8 %a, i8 %b) nounwind {
; RV32I-LABEL: sdiv8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    srai a1, a1, 24
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv8:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a1, 24
; RV32IM-NEXT:    srai a1, a1, 24
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srai a0, a0, 24
; RV32IM-NEXT:    div a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    slli a1, a1, 56
; RV64I-NEXT:    srai a1, a1, 56
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a1, 56
; RV64IM-NEXT:    srai a1, a1, 56
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i8 %a, %b
  ret i8 %1
}

define i8 @sdiv8_constant(i8 %a) nounwind {
; RV32I-LABEL: sdiv8_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv8_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srai a0, a0, 24
; RV32IM-NEXT:    li a1, 103
; RV32IM-NEXT:    mul a0, a0, a1
; RV32IM-NEXT:    srai a1, a0, 9
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srli a0, a0, 31
; RV32IM-NEXT:    add a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv8_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv8_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    li a1, 103
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    srai a1, a0, 9
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srli a0, a0, 63
; RV64IM-NEXT:    add a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = sdiv i8 %a, 5
  ret i8 %1
}

define i8 @sdiv8_pow2(i8 %a) nounwind {
; RV32I-LABEL: sdiv8_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srai a1, a1, 24
; RV32I-NEXT:    slli a1, a1, 17
; RV32I-NEXT:    srli a1, a1, 29
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 27
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv8_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a0, 24
; RV32IM-NEXT:    srai a1, a1, 24
; RV32IM-NEXT:    slli a1, a1, 17
; RV32IM-NEXT:    srli a1, a1, 29
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srai a0, a0, 27
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv8_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a1, a0, 56
; RV64I-NEXT:    srai a1, a1, 56
; RV64I-NEXT:    slli a1, a1, 49
; RV64I-NEXT:    srli a1, a1, 61
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 59
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv8_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a0, 56
; RV64IM-NEXT:    srai a1, a1, 56
; RV64IM-NEXT:    slli a1, a1, 49
; RV64IM-NEXT:    srli a1, a1, 61
; RV64IM-NEXT:    addw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 59
; RV64IM-NEXT:    ret
  %1 = sdiv i8 %a, 8
  ret i8 %1
}

define i8 @sdiv8_constant_lhs(i8 %a) nounwind {
; RV32I-LABEL: sdiv8_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a1, a0, 24
; RV32I-NEXT:    li a0, -10
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv8_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 24
; RV32IM-NEXT:    srai a0, a0, 24
; RV32IM-NEXT:    li a1, -10
; RV32IM-NEXT:    div a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv8_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a1, a0, 56
; RV64I-NEXT:    li a0, -10
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv8_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    li a1, -10
; RV64IM-NEXT:    divw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = sdiv i8 -10, %a
  ret i8 %1
}

define i16 @sdiv16(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: sdiv16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    slli a1, a1, 16
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv16:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a1, 16
; RV32IM-NEXT:    srai a1, a1, 16
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srai a0, a0, 16
; RV32IM-NEXT:    div a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    slli a1, a1, 48
; RV64I-NEXT:    srai a1, a1, 48
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a1, 48
; RV64IM-NEXT:    srai a1, a1, 48
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i16 %a, %b
  ret i16 %1
}

define i16 @sdiv16_constant(i16 %a) nounwind {
; RV32I-LABEL: sdiv16_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    li a1, 5
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv16_constant:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srai a0, a0, 16
; RV32IM-NEXT:    lui a1, 6
; RV32IM-NEXT:    addi a1, a1, 1639
; RV32IM-NEXT:    mul a0, a0, a1
; RV32IM-NEXT:    srli a1, a0, 31
; RV32IM-NEXT:    srai a0, a0, 17
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv16_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    li a1, 5
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv16_constant:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    lui a1, 6
; RV64IM-NEXT:    addiw a1, a1, 1639
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    srliw a1, a0, 31
; RV64IM-NEXT:    srai a0, a0, 17
; RV64IM-NEXT:    add a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i16 %a, 5
  ret i16 %1
}

define i16 @sdiv16_pow2(i16 %a) nounwind {
; RV32I-LABEL: sdiv16_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    srli a1, a1, 29
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 19
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv16_pow2:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a1, a0, 16
; RV32IM-NEXT:    srai a1, a1, 16
; RV32IM-NEXT:    slli a1, a1, 1
; RV32IM-NEXT:    srli a1, a1, 29
; RV32IM-NEXT:    add a0, a0, a1
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srai a0, a0, 19
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv16_pow2:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a1, a0, 48
; RV64I-NEXT:    srai a1, a1, 48
; RV64I-NEXT:    slli a1, a1, 33
; RV64I-NEXT:    srli a1, a1, 61
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 51
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv16_pow2:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a1, a0, 48
; RV64IM-NEXT:    srai a1, a1, 48
; RV64IM-NEXT:    slli a1, a1, 33
; RV64IM-NEXT:    srli a1, a1, 61
; RV64IM-NEXT:    addw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 51
; RV64IM-NEXT:    ret
  %1 = sdiv i16 %a, 8
  ret i16 %1
}

define i16 @sdiv16_constant_lhs(i16 %a) nounwind {
; RV32I-LABEL: sdiv16_constant_lhs:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a1, a0, 16
; RV32I-NEXT:    li a0, -10
; RV32I-NEXT:    call __divsi3@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IM-LABEL: sdiv16_constant_lhs:
; RV32IM:       # %bb.0:
; RV32IM-NEXT:    slli a0, a0, 16
; RV32IM-NEXT:    srai a0, a0, 16
; RV32IM-NEXT:    li a1, -10
; RV32IM-NEXT:    div a0, a1, a0
; RV32IM-NEXT:    ret
;
; RV64I-LABEL: sdiv16_constant_lhs:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a1, a0, 48
; RV64I-NEXT:    li a0, -10
; RV64I-NEXT:    call __divdi3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IM-LABEL: sdiv16_constant_lhs:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    li a1, -10
; RV64IM-NEXT:    divw a0, a1, a0
; RV64IM-NEXT:    ret
  %1 = sdiv i16 -10, %a
  ret i16 %1
}
