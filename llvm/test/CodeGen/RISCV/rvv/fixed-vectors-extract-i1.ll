; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+experimental-zvfh,+f,+d,+zbs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32ZBS
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+experimental-zvfh,+f,+d,+zbs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64ZBS

define i1 @extractelt_v1i1(<1 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vi v0, v8, 0
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vslidedown.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %a = load <1 x i8>, <1 x i8>* %x
  %b = icmp eq <1 x i8> %a, zeroinitializer
  %c = extractelement <1 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v2i1(<2 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vi v0, v8, 0
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %a = load <2 x i8>, <2 x i8>* %x
  %b = icmp eq <2 x i8> %a, zeroinitializer
  %c = extractelement <2 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v4i1(<4 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vi v0, v8, 0
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %a = load <4 x i8>, <4 x i8>* %x
  %b = icmp eq <4 x i8> %a, zeroinitializer
  %c = extractelement <4 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v8i1(<8 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v8i1:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vle8.v v8, (a0)
; RV32-NEXT:    vmseq.vi v8, v8, 0
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    srl a0, a0, a1
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v8i1:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vle8.v v8, (a0)
; RV64-NEXT:    vmseq.vi v8, v8, 0
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v8i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32ZBS-NEXT:    vle8.v v8, (a0)
; RV32ZBS-NEXT:    vmseq.vi v8, v8, 0
; RV32ZBS-NEXT:    vmv.x.s a0, v8
; RV32ZBS-NEXT:    bext a0, a0, a1
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v8i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64ZBS-NEXT:    vle8.v v8, (a0)
; RV64ZBS-NEXT:    vmseq.vi v8, v8, 0
; RV64ZBS-NEXT:    vmv.x.s a0, v8
; RV64ZBS-NEXT:    bext a0, a0, a1
; RV64ZBS-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = icmp eq <8 x i8> %a, zeroinitializer
  %c = extractelement <8 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v16i1(<16 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v16i1:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-NEXT:    vle8.v v8, (a0)
; RV32-NEXT:    vmseq.vi v8, v8, 0
; RV32-NEXT:    vsetivli zero, 0, e16, mf4, ta, ma
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    srl a0, a0, a1
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v16i1:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-NEXT:    vle8.v v8, (a0)
; RV64-NEXT:    vmseq.vi v8, v8, 0
; RV64-NEXT:    vsetivli zero, 0, e16, mf4, ta, ma
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v16i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32ZBS-NEXT:    vle8.v v8, (a0)
; RV32ZBS-NEXT:    vmseq.vi v8, v8, 0
; RV32ZBS-NEXT:    vsetivli zero, 0, e16, mf4, ta, ma
; RV32ZBS-NEXT:    vmv.x.s a0, v8
; RV32ZBS-NEXT:    bext a0, a0, a1
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v16i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64ZBS-NEXT:    vle8.v v8, (a0)
; RV64ZBS-NEXT:    vmseq.vi v8, v8, 0
; RV64ZBS-NEXT:    vsetivli zero, 0, e16, mf4, ta, ma
; RV64ZBS-NEXT:    vmv.x.s a0, v8
; RV64ZBS-NEXT:    bext a0, a0, a1
; RV64ZBS-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = icmp eq <16 x i8> %a, zeroinitializer
  %c = extractelement <16 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v32i1(<32 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v32i1:
; RV32:       # %bb.0:
; RV32-NEXT:    li a2, 32
; RV32-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; RV32-NEXT:    vle8.v v8, (a0)
; RV32-NEXT:    vmseq.vi v10, v8, 0
; RV32-NEXT:    vsetivli zero, 0, e32, mf2, ta, ma
; RV32-NEXT:    vmv.x.s a0, v10
; RV32-NEXT:    srl a0, a0, a1
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v32i1:
; RV64:       # %bb.0:
; RV64-NEXT:    li a2, 32
; RV64-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; RV64-NEXT:    vle8.v v8, (a0)
; RV64-NEXT:    vmseq.vi v10, v8, 0
; RV64-NEXT:    vsetivli zero, 0, e32, mf2, ta, ma
; RV64-NEXT:    vmv.x.s a0, v10
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v32i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    li a2, 32
; RV32ZBS-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; RV32ZBS-NEXT:    vle8.v v8, (a0)
; RV32ZBS-NEXT:    vmseq.vi v10, v8, 0
; RV32ZBS-NEXT:    vsetivli zero, 0, e32, mf2, ta, ma
; RV32ZBS-NEXT:    vmv.x.s a0, v10
; RV32ZBS-NEXT:    bext a0, a0, a1
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v32i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    li a2, 32
; RV64ZBS-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; RV64ZBS-NEXT:    vle8.v v8, (a0)
; RV64ZBS-NEXT:    vmseq.vi v10, v8, 0
; RV64ZBS-NEXT:    vsetivli zero, 0, e32, mf2, ta, ma
; RV64ZBS-NEXT:    vmv.x.s a0, v10
; RV64ZBS-NEXT:    bext a0, a0, a1
; RV64ZBS-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = icmp eq <32 x i8> %a, zeroinitializer
  %c = extractelement <32 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v64i1(<64 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v64i1:
; RV32:       # %bb.0:
; RV32-NEXT:    li a2, 64
; RV32-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; RV32-NEXT:    vle8.v v8, (a0)
; RV32-NEXT:    vmseq.vi v12, v8, 0
; RV32-NEXT:    srli a0, a1, 5
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vslidedown.vx v8, v12, a0
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    srl a0, a0, a1
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v64i1:
; RV64:       # %bb.0:
; RV64-NEXT:    li a2, 64
; RV64-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; RV64-NEXT:    vle8.v v8, (a0)
; RV64-NEXT:    vmseq.vi v12, v8, 0
; RV64-NEXT:    vsetivli zero, 0, e64, m1, ta, ma
; RV64-NEXT:    vmv.x.s a0, v12
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v64i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    li a2, 64
; RV32ZBS-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; RV32ZBS-NEXT:    vle8.v v8, (a0)
; RV32ZBS-NEXT:    vmseq.vi v12, v8, 0
; RV32ZBS-NEXT:    srli a0, a1, 5
; RV32ZBS-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32ZBS-NEXT:    vslidedown.vx v8, v12, a0
; RV32ZBS-NEXT:    vmv.x.s a0, v8
; RV32ZBS-NEXT:    bext a0, a0, a1
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v64i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    li a2, 64
; RV64ZBS-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; RV64ZBS-NEXT:    vle8.v v8, (a0)
; RV64ZBS-NEXT:    vmseq.vi v12, v8, 0
; RV64ZBS-NEXT:    vsetivli zero, 0, e64, m1, ta, ma
; RV64ZBS-NEXT:    vmv.x.s a0, v12
; RV64ZBS-NEXT:    bext a0, a0, a1
; RV64ZBS-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = icmp eq <64 x i8> %a, zeroinitializer
  %c = extractelement <64 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v128i1(<128 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v128i1:
; RV32:       # %bb.0:
; RV32-NEXT:    li a2, 128
; RV32-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV32-NEXT:    vle8.v v8, (a0)
; RV32-NEXT:    vmseq.vi v16, v8, 0
; RV32-NEXT:    srli a0, a1, 5
; RV32-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32-NEXT:    vslidedown.vx v8, v16, a0
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    srl a0, a0, a1
; RV32-NEXT:    andi a0, a0, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v128i1:
; RV64:       # %bb.0:
; RV64-NEXT:    li a2, 128
; RV64-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV64-NEXT:    vle8.v v8, (a0)
; RV64-NEXT:    vmseq.vi v16, v8, 0
; RV64-NEXT:    srli a0, a1, 6
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vx v8, v16, a0
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    andi a0, a0, 1
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v128i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    li a2, 128
; RV32ZBS-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV32ZBS-NEXT:    vle8.v v8, (a0)
; RV32ZBS-NEXT:    vmseq.vi v16, v8, 0
; RV32ZBS-NEXT:    srli a0, a1, 5
; RV32ZBS-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32ZBS-NEXT:    vslidedown.vx v8, v16, a0
; RV32ZBS-NEXT:    vmv.x.s a0, v8
; RV32ZBS-NEXT:    bext a0, a0, a1
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v128i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    li a2, 128
; RV64ZBS-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV64ZBS-NEXT:    vle8.v v8, (a0)
; RV64ZBS-NEXT:    vmseq.vi v16, v8, 0
; RV64ZBS-NEXT:    srli a0, a1, 6
; RV64ZBS-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64ZBS-NEXT:    vslidedown.vx v8, v16, a0
; RV64ZBS-NEXT:    vmv.x.s a0, v8
; RV64ZBS-NEXT:    bext a0, a0, a1
; RV64ZBS-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = icmp eq <128 x i8> %a, zeroinitializer
  %c = extractelement <128 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_v256i1(<256 x i8>* %x, i64 %idx) nounwind {
; RV32-LABEL: extractelt_v256i1:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -384
; RV32-NEXT:    sw ra, 380(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 376(sp) # 4-byte Folded Spill
; RV32-NEXT:    addi s0, sp, 384
; RV32-NEXT:    andi sp, sp, -128
; RV32-NEXT:    andi a1, a1, 255
; RV32-NEXT:    li a2, 128
; RV32-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV32-NEXT:    addi a2, a0, 128
; RV32-NEXT:    vle8.v v16, (a2)
; RV32-NEXT:    vle8.v v24, (a0)
; RV32-NEXT:    mv a0, sp
; RV32-NEXT:    add a1, a0, a1
; RV32-NEXT:    vmseq.vi v8, v16, 0
; RV32-NEXT:    vmseq.vi v0, v24, 0
; RV32-NEXT:    vmv.v.i v16, 0
; RV32-NEXT:    vmerge.vim v24, v16, 1, v0
; RV32-NEXT:    vse8.v v24, (a0)
; RV32-NEXT:    vmv1r.v v0, v8
; RV32-NEXT:    vmerge.vim v8, v16, 1, v0
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    vse8.v v8, (a0)
; RV32-NEXT:    lb a0, 0(a1)
; RV32-NEXT:    addi sp, s0, -384
; RV32-NEXT:    lw ra, 380(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 376(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 384
; RV32-NEXT:    ret
;
; RV64-LABEL: extractelt_v256i1:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -384
; RV64-NEXT:    sd ra, 376(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 368(sp) # 8-byte Folded Spill
; RV64-NEXT:    addi s0, sp, 384
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    andi a1, a1, 255
; RV64-NEXT:    li a2, 128
; RV64-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV64-NEXT:    addi a2, a0, 128
; RV64-NEXT:    vle8.v v16, (a2)
; RV64-NEXT:    vle8.v v24, (a0)
; RV64-NEXT:    mv a0, sp
; RV64-NEXT:    add a1, a0, a1
; RV64-NEXT:    vmseq.vi v8, v16, 0
; RV64-NEXT:    vmseq.vi v0, v24, 0
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    vmerge.vim v24, v16, 1, v0
; RV64-NEXT:    vse8.v v24, (a0)
; RV64-NEXT:    vmv1r.v v0, v8
; RV64-NEXT:    vmerge.vim v8, v16, 1, v0
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    vse8.v v8, (a0)
; RV64-NEXT:    lb a0, 0(a1)
; RV64-NEXT:    addi sp, s0, -384
; RV64-NEXT:    ld ra, 376(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 368(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 384
; RV64-NEXT:    ret
;
; RV32ZBS-LABEL: extractelt_v256i1:
; RV32ZBS:       # %bb.0:
; RV32ZBS-NEXT:    addi sp, sp, -384
; RV32ZBS-NEXT:    sw ra, 380(sp) # 4-byte Folded Spill
; RV32ZBS-NEXT:    sw s0, 376(sp) # 4-byte Folded Spill
; RV32ZBS-NEXT:    addi s0, sp, 384
; RV32ZBS-NEXT:    andi sp, sp, -128
; RV32ZBS-NEXT:    andi a1, a1, 255
; RV32ZBS-NEXT:    li a2, 128
; RV32ZBS-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV32ZBS-NEXT:    addi a2, a0, 128
; RV32ZBS-NEXT:    vle8.v v16, (a2)
; RV32ZBS-NEXT:    vle8.v v24, (a0)
; RV32ZBS-NEXT:    mv a0, sp
; RV32ZBS-NEXT:    add a1, a0, a1
; RV32ZBS-NEXT:    vmseq.vi v8, v16, 0
; RV32ZBS-NEXT:    vmseq.vi v0, v24, 0
; RV32ZBS-NEXT:    vmv.v.i v16, 0
; RV32ZBS-NEXT:    vmerge.vim v24, v16, 1, v0
; RV32ZBS-NEXT:    vse8.v v24, (a0)
; RV32ZBS-NEXT:    vmv1r.v v0, v8
; RV32ZBS-NEXT:    vmerge.vim v8, v16, 1, v0
; RV32ZBS-NEXT:    addi a0, sp, 128
; RV32ZBS-NEXT:    vse8.v v8, (a0)
; RV32ZBS-NEXT:    lb a0, 0(a1)
; RV32ZBS-NEXT:    addi sp, s0, -384
; RV32ZBS-NEXT:    lw ra, 380(sp) # 4-byte Folded Reload
; RV32ZBS-NEXT:    lw s0, 376(sp) # 4-byte Folded Reload
; RV32ZBS-NEXT:    addi sp, sp, 384
; RV32ZBS-NEXT:    ret
;
; RV64ZBS-LABEL: extractelt_v256i1:
; RV64ZBS:       # %bb.0:
; RV64ZBS-NEXT:    addi sp, sp, -384
; RV64ZBS-NEXT:    sd ra, 376(sp) # 8-byte Folded Spill
; RV64ZBS-NEXT:    sd s0, 368(sp) # 8-byte Folded Spill
; RV64ZBS-NEXT:    addi s0, sp, 384
; RV64ZBS-NEXT:    andi sp, sp, -128
; RV64ZBS-NEXT:    andi a1, a1, 255
; RV64ZBS-NEXT:    li a2, 128
; RV64ZBS-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; RV64ZBS-NEXT:    addi a2, a0, 128
; RV64ZBS-NEXT:    vle8.v v16, (a2)
; RV64ZBS-NEXT:    vle8.v v24, (a0)
; RV64ZBS-NEXT:    mv a0, sp
; RV64ZBS-NEXT:    add a1, a0, a1
; RV64ZBS-NEXT:    vmseq.vi v8, v16, 0
; RV64ZBS-NEXT:    vmseq.vi v0, v24, 0
; RV64ZBS-NEXT:    vmv.v.i v16, 0
; RV64ZBS-NEXT:    vmerge.vim v24, v16, 1, v0
; RV64ZBS-NEXT:    vse8.v v24, (a0)
; RV64ZBS-NEXT:    vmv1r.v v0, v8
; RV64ZBS-NEXT:    vmerge.vim v8, v16, 1, v0
; RV64ZBS-NEXT:    addi a0, sp, 128
; RV64ZBS-NEXT:    vse8.v v8, (a0)
; RV64ZBS-NEXT:    lb a0, 0(a1)
; RV64ZBS-NEXT:    addi sp, s0, -384
; RV64ZBS-NEXT:    ld ra, 376(sp) # 8-byte Folded Reload
; RV64ZBS-NEXT:    ld s0, 368(sp) # 8-byte Folded Reload
; RV64ZBS-NEXT:    addi sp, sp, 384
; RV64ZBS-NEXT:    ret
  %a = load <256 x i8>, <256 x i8>* %x
  %b = icmp eq <256 x i8> %a, zeroinitializer
  %c = extractelement <256 x i1> %b, i64 %idx
  ret i1 %c
}
