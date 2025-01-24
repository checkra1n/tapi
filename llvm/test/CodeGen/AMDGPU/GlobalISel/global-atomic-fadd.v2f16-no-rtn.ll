; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx908 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX908 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX90A_GFX940 %s

define amdgpu_ps void @global_atomic_fadd_v2f16_no_rtn_intrinsic(ptr addrspace(1) %ptr, <2 x half> %data) {
  ; GFX908-LABEL: name: global_atomic_fadd_v2f16_no_rtn_intrinsic
  ; GFX908: bb.1 (%ir-block.0):
  ; GFX908-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX908-NEXT: {{  $}}
  ; GFX908-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX908-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX908-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX908-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16 [[REG_SEQUENCE]], [[COPY2]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX908-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_no_rtn_intrinsic
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16 [[REG_SEQUENCE]], [[COPY2]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1) %ptr, <2 x half> %data)
  ret void
}

define amdgpu_ps void @global_atomic_fadd_v2f16_saddr_no_rtn_intrinsic(ptr addrspace(1) inreg %ptr, <2 x half> %data) {
  ; GFX908-LABEL: name: global_atomic_fadd_v2f16_saddr_no_rtn_intrinsic
  ; GFX908: bb.1 (%ir-block.0):
  ; GFX908-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX908-NEXT: {{  $}}
  ; GFX908-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX908-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX908-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16_SADDR [[V_MOV_B32_e32_]], [[COPY2]], [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX908-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_saddr_no_rtn_intrinsic
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16_SADDR [[V_MOV_B32_e32_]], [[COPY2]], [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1) %ptr, <2 x half> %data)
  ret void
}

define amdgpu_ps void @global_atomic_fadd_v2f16_no_rtn_flat_intrinsic(ptr addrspace(1) %ptr, <2 x half> %data) {
  ; GFX908-LABEL: name: global_atomic_fadd_v2f16_no_rtn_flat_intrinsic
  ; GFX908: bb.1 (%ir-block.0):
  ; GFX908-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX908-NEXT: {{  $}}
  ; GFX908-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX908-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX908-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX908-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16 [[REG_SEQUENCE]], [[COPY2]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX908-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_no_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16 [[REG_SEQUENCE]], [[COPY2]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1) %ptr, <2 x half> %data)
  ret void
}

define amdgpu_ps void @global_atomic_fadd_v2f16_saddr_no_rtn_flat_intrinsic(ptr addrspace(1) inreg %ptr, <2 x half> %data) {
  ; GFX908-LABEL: name: global_atomic_fadd_v2f16_saddr_no_rtn_flat_intrinsic
  ; GFX908: bb.1 (%ir-block.0):
  ; GFX908-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX908-NEXT: {{  $}}
  ; GFX908-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX908-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX908-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX908-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX908-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX908-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16_SADDR [[V_MOV_B32_e32_]], [[COPY2]], [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX908-NEXT:   S_ENDPGM 0
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_v2f16_saddr_no_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.1 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_PK_ADD_F16_SADDR [[V_MOV_B32_e32_]], [[COPY2]], [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1) %ptr, <2 x half> %data)
  ret void
}

declare <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1), <2 x half>)
declare <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1.v2f16(ptr addrspace(1), <2 x half>)
