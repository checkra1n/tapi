; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 < %s | FileCheck -check-prefix=RV32 %s
; RUN: llc -mtriple=riscv64 < %s | FileCheck -check-prefix=RV64 %s

define void @dwarf() {
; RV32-LABEL: dwarf:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    addi a0, sp, 16
; RV32-NEXT:    call foo@plt
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: dwarf:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    addi a0, sp, 16
; RV64-NEXT:    call foo@plt
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
entry:
  %0 = call i8* @llvm.eh.dwarf.cfa(i32 0)
  call void @foo(i8* %0)
  ret void
}

declare void @foo(i8*)

declare i8* @llvm.eh.dwarf.cfa(i32) nounwind
