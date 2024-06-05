; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -amdhsa-code-object-version=3 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx803 < %s | FileCheck -check-prefixes=FIXEDABI,FIXEDABI-SDAG %s
; RUN: llc -global-isel -amdhsa-code-object-version=3 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx803 < %s | FileCheck -check-prefixes=FIXEDABI,FIXEDABI-GISEL %s

; Test with gfx803 so that
; addrspacecast/llvm.amdgcn.is.shared/llvm.amdgcn.is.private require
; the queue ptr.  Tests with code object v3 to test
; llvm.trap/llvm.debugtrap that require the queue ptr.


declare hidden void @requires_all_inputs()

; This function incorrectly is marked with the hints that the callee
; does not require the implicit arguments to the function. Make sure
; we do not crash.
define void @parent_func_missing_inputs() #0 {
; FIXEDABI-LABEL: parent_func_missing_inputs:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    s_or_saveexec_b64 s[16:17], -1
; FIXEDABI-NEXT:    buffer_store_dword v40, off, s[0:3], s32 ; 4-byte Folded Spill
; FIXEDABI-NEXT:    s_mov_b64 exec, s[16:17]
; FIXEDABI-NEXT:    v_writelane_b32 v40, s33, 2
; FIXEDABI-NEXT:    s_mov_b32 s33, s32
; FIXEDABI-NEXT:    s_addk_i32 s32, 0x400
; FIXEDABI-NEXT:    v_writelane_b32 v40, s30, 0
; FIXEDABI-NEXT:    v_writelane_b32 v40, s31, 1
; FIXEDABI-NEXT:    s_getpc_b64 s[16:17]
; FIXEDABI-NEXT:    s_add_u32 s16, s16, requires_all_inputs@rel32@lo+4
; FIXEDABI-NEXT:    s_addc_u32 s17, s17, requires_all_inputs@rel32@hi+12
; FIXEDABI-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; FIXEDABI-NEXT:    v_readlane_b32 s31, v40, 1
; FIXEDABI-NEXT:    v_readlane_b32 s30, v40, 0
; FIXEDABI-NEXT:    s_addk_i32 s32, 0xfc00
; FIXEDABI-NEXT:    v_readlane_b32 s33, v40, 2
; FIXEDABI-NEXT:    s_or_saveexec_b64 s[4:5], -1
; FIXEDABI-NEXT:    buffer_load_dword v40, off, s[0:3], s32 ; 4-byte Folded Reload
; FIXEDABI-NEXT:    s_mov_b64 exec, s[4:5]
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_setpc_b64 s[30:31]
  call void @requires_all_inputs()
  ret void
}

define amdgpu_kernel void @parent_kernel_missing_inputs() #0 {
; FIXEDABI-SDAG-LABEL: parent_kernel_missing_inputs:
; FIXEDABI-SDAG:       ; %bb.0:
; FIXEDABI-SDAG-NEXT:    s_add_i32 s4, s4, s9
; FIXEDABI-SDAG-NEXT:    s_lshr_b32 flat_scratch_hi, s4, 8
; FIXEDABI-SDAG-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; FIXEDABI-SDAG-NEXT:    s_add_u32 s0, s0, s9
; FIXEDABI-SDAG-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; FIXEDABI-SDAG-NEXT:    v_or_b32_e32 v0, v0, v1
; FIXEDABI-SDAG-NEXT:    s_addc_u32 s1, s1, 0
; FIXEDABI-SDAG-NEXT:    s_mov_b32 s14, s8
; FIXEDABI-SDAG-NEXT:    v_or_b32_e32 v31, v0, v2
; FIXEDABI-SDAG-NEXT:    s_mov_b64 s[8:9], 0
; FIXEDABI-SDAG-NEXT:    s_mov_b32 s12, s6
; FIXEDABI-SDAG-NEXT:    s_mov_b32 s13, s7
; FIXEDABI-SDAG-NEXT:    s_mov_b32 s32, 0
; FIXEDABI-SDAG-NEXT:    s_mov_b32 flat_scratch_lo, s5
; FIXEDABI-SDAG-NEXT:    s_getpc_b64 s[4:5]
; FIXEDABI-SDAG-NEXT:    s_add_u32 s4, s4, requires_all_inputs@rel32@lo+4
; FIXEDABI-SDAG-NEXT:    s_addc_u32 s5, s5, requires_all_inputs@rel32@hi+12
; FIXEDABI-SDAG-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; FIXEDABI-SDAG-NEXT:    s_endpgm
;
; FIXEDABI-GISEL-LABEL: parent_kernel_missing_inputs:
; FIXEDABI-GISEL:       ; %bb.0:
; FIXEDABI-GISEL-NEXT:    s_add_i32 s4, s4, s9
; FIXEDABI-GISEL-NEXT:    s_lshr_b32 flat_scratch_hi, s4, 8
; FIXEDABI-GISEL-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; FIXEDABI-GISEL-NEXT:    s_add_u32 s0, s0, s9
; FIXEDABI-GISEL-NEXT:    v_or_b32_e32 v0, v0, v1
; FIXEDABI-GISEL-NEXT:    v_lshlrev_b32_e32 v1, 20, v2
; FIXEDABI-GISEL-NEXT:    s_addc_u32 s1, s1, 0
; FIXEDABI-GISEL-NEXT:    s_mov_b32 s14, s8
; FIXEDABI-GISEL-NEXT:    v_or_b32_e32 v31, v0, v1
; FIXEDABI-GISEL-NEXT:    s_mov_b64 s[8:9], 0
; FIXEDABI-GISEL-NEXT:    s_mov_b32 s12, s6
; FIXEDABI-GISEL-NEXT:    s_mov_b32 s13, s7
; FIXEDABI-GISEL-NEXT:    s_mov_b32 s32, 0
; FIXEDABI-GISEL-NEXT:    s_mov_b32 flat_scratch_lo, s5
; FIXEDABI-GISEL-NEXT:    s_getpc_b64 s[4:5]
; FIXEDABI-GISEL-NEXT:    s_add_u32 s4, s4, requires_all_inputs@rel32@lo+4
; FIXEDABI-GISEL-NEXT:    s_addc_u32 s5, s5, requires_all_inputs@rel32@hi+12
; FIXEDABI-GISEL-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; FIXEDABI-GISEL-NEXT:    s_endpgm
  call void @requires_all_inputs()
  ret void
}

; Function is marked with amdgpu-no-workitem-id-* but uses them anyway
define void @marked_func_use_workitem_id(i32 addrspace(1)* %ptr) #0 {
; FIXEDABI-SDAG-LABEL: marked_func_use_workitem_id:
; FIXEDABI-SDAG:       ; %bb.0:
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-SDAG-NEXT:    v_and_b32_e32 v2, 0x3ff, v31
; FIXEDABI-SDAG-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-SDAG-NEXT:    v_bfe_u32 v2, v31, 10, 10
; FIXEDABI-SDAG-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-SDAG-NEXT:    v_bfe_u32 v2, v31, 20, 10
; FIXEDABI-SDAG-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; FIXEDABI-GISEL-LABEL: marked_func_use_workitem_id:
; FIXEDABI-GISEL:       ; %bb.0:
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-GISEL-NEXT:    v_and_b32_e32 v2, 0x3ff, v31
; FIXEDABI-GISEL-NEXT:    v_bfe_u32 v3, v31, 10, 10
; FIXEDABI-GISEL-NEXT:    v_bfe_u32 v4, v31, 20, 10
; FIXEDABI-GISEL-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-GISEL-NEXT:    flat_store_dword v[0:1], v3
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-GISEL-NEXT:    flat_store_dword v[0:1], v4
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %id.x = call i32 @llvm.amdgcn.workitem.id.x()
  %id.y = call i32 @llvm.amdgcn.workitem.id.y()
  %id.z = call i32 @llvm.amdgcn.workitem.id.z()
  store volatile i32 %id.x, i32 addrspace(1)* %ptr
  store volatile i32 %id.y, i32 addrspace(1)* %ptr
  store volatile i32 %id.z, i32 addrspace(1)* %ptr
  ret void
}

; Function is marked with amdgpu-no-workitem-id-* but uses them anyway
define amdgpu_kernel void @marked_kernel_use_workitem_id(i32 addrspace(1)* %ptr) #0 {
; FIXEDABI-LABEL: marked_kernel_use_workitem_id:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; FIXEDABI-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v4, s1
; FIXEDABI-NEXT:    v_mov_b32_e32 v3, s0
; FIXEDABI-NEXT:    flat_store_dword v[3:4], v0
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    flat_store_dword v[3:4], v1
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    flat_store_dword v[3:4], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_endpgm
  %id.x = call i32 @llvm.amdgcn.workitem.id.x()
  %id.y = call i32 @llvm.amdgcn.workitem.id.y()
  %id.z = call i32 @llvm.amdgcn.workitem.id.z()
  store volatile i32 %id.x, i32 addrspace(1)* %ptr
  store volatile i32 %id.y, i32 addrspace(1)* %ptr
  store volatile i32 %id.z, i32 addrspace(1)* %ptr
  ret void
}

define void @marked_func_use_workgroup_id(i32 addrspace(1)* %ptr) #0 {
; FIXEDABI-LABEL: marked_func_use_workgroup_id:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s12
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s13
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s14
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_setpc_b64 s[30:31]
  %id.x = call i32 @llvm.amdgcn.workgroup.id.x()
  %id.y = call i32 @llvm.amdgcn.workgroup.id.y()
  %id.z = call i32 @llvm.amdgcn.workgroup.id.z()
  store volatile i32 %id.x, i32 addrspace(1)* %ptr
  store volatile i32 %id.y, i32 addrspace(1)* %ptr
  store volatile i32 %id.z, i32 addrspace(1)* %ptr
  ret void
}

define amdgpu_kernel void @marked_kernel_use_workgroup_id(i32 addrspace(1)* %ptr) #0 {
; FIXEDABI-LABEL: marked_kernel_use_workgroup_id:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s6
; FIXEDABI-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v0, s0
; FIXEDABI-NEXT:    v_mov_b32_e32 v1, s1
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s7
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s8
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_endpgm
  %id.x = call i32 @llvm.amdgcn.workgroup.id.x()
  %id.y = call i32 @llvm.amdgcn.workgroup.id.y()
  %id.z = call i32 @llvm.amdgcn.workgroup.id.z()
  store volatile i32 %id.x, i32 addrspace(1)* %ptr
  store volatile i32 %id.y, i32 addrspace(1)* %ptr
  store volatile i32 %id.z, i32 addrspace(1)* %ptr
  ret void
}

define void @marked_func_use_other_sgpr(i64 addrspace(1)* %ptr) #0 {
; FIXEDABI-LABEL: marked_func_use_other_sgpr:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s6
; FIXEDABI-NEXT:    v_mov_b32_e32 v3, s7
; FIXEDABI-NEXT:    flat_load_ubyte v2, v[2:3] glc
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s8
; FIXEDABI-NEXT:    v_mov_b32_e32 v3, s9
; FIXEDABI-NEXT:    flat_load_ubyte v2, v[2:3] glc
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s4
; FIXEDABI-NEXT:    v_mov_b32_e32 v3, s5
; FIXEDABI-NEXT:    flat_load_ubyte v2, v[2:3] glc
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v2, s10
; FIXEDABI-NEXT:    v_mov_b32_e32 v3, s11
; FIXEDABI-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_setpc_b64 s[30:31]
  %queue.ptr = call i8 addrspace(4)* @llvm.amdgcn.queue.ptr()
  %implicitarg.ptr = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %dispatch.ptr = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
  %dispatch.id = call i64 @llvm.amdgcn.dispatch.id()
  %queue.load = load volatile i8, i8 addrspace(4)* %queue.ptr
  %implicitarg.load = load volatile i8, i8 addrspace(4)* %implicitarg.ptr
  %dispatch.load = load volatile i8, i8 addrspace(4)* %dispatch.ptr
  store volatile i64 %dispatch.id, i64 addrspace(1)* %ptr
  ret void
}

define amdgpu_kernel void @marked_kernel_use_other_sgpr(i64 addrspace(1)* %ptr) #0 {
; FIXEDABI-LABEL: marked_kernel_use_other_sgpr:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_add_u32 s0, s4, 8
; FIXEDABI-NEXT:    flat_load_ubyte v0, v[0:1] glc
; FIXEDABI-NEXT:    s_addc_u32 s1, s5, 0
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    v_mov_b32_e32 v0, s0
; FIXEDABI-NEXT:    v_mov_b32_e32 v1, s1
; FIXEDABI-NEXT:    flat_load_ubyte v0, v[0:1] glc
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    flat_load_ubyte v0, v[0:1] glc
; FIXEDABI-NEXT:    s_endpgm
  %queue.ptr = call i8 addrspace(4)* @llvm.amdgcn.queue.ptr()
  %implicitarg.ptr = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %dispatch.ptr = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
  %dispatch.id = call i64 @llvm.amdgcn.dispatch.id()
  %queue.load = load volatile i8, i8 addrspace(4)* %queue.ptr
  %implicitarg.load = load volatile i8, i8 addrspace(4)* %implicitarg.ptr
  %dispatch.load = load volatile i8, i8 addrspace(4)* %dispatch.ptr
  store volatile i64 %dispatch.id, i64 addrspace(1)* %ptr
  ret void
}

define amdgpu_kernel void @marked_kernel_nokernargs_implicitarg_ptr() #0 {
; FIXEDABI-LABEL: marked_kernel_nokernargs_implicitarg_ptr:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    v_mov_b32_e32 v0, 0
; FIXEDABI-NEXT:    v_mov_b32_e32 v1, 0
; FIXEDABI-NEXT:    flat_load_ubyte v0, v[0:1] glc
; FIXEDABI-NEXT:    s_endpgm
  %implicitarg.ptr = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  %implicitarg.load = load volatile i8, i8 addrspace(4)* %implicitarg.ptr
  ret void
}

; On gfx8, the queue ptr is required for this addrspacecast.
define void @addrspacecast_requires_queue_ptr(i32 addrspace(5)* %ptr.private, i32 addrspace(3)* %ptr.local) #0 {
; FIXEDABI-SDAG-LABEL: addrspacecast_requires_queue_ptr:
; FIXEDABI-SDAG:       ; %bb.0:
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-SDAG-NEXT:    s_load_dwordx2 s[4:5], s[6:7], 0x40
; FIXEDABI-SDAG-NEXT:    v_cmp_ne_u32_e32 vcc, -1, v0
; FIXEDABI-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-SDAG-NEXT:    v_mov_b32_e32 v2, s5
; FIXEDABI-SDAG-NEXT:    v_cndmask_b32_e32 v3, 0, v2, vcc
; FIXEDABI-SDAG-NEXT:    v_cndmask_b32_e32 v2, 0, v0, vcc
; FIXEDABI-SDAG-NEXT:    v_mov_b32_e32 v0, s4
; FIXEDABI-SDAG-NEXT:    v_cmp_ne_u32_e32 vcc, -1, v1
; FIXEDABI-SDAG-NEXT:    v_cndmask_b32_e32 v5, 0, v0, vcc
; FIXEDABI-SDAG-NEXT:    v_mov_b32_e32 v0, 1
; FIXEDABI-SDAG-NEXT:    v_cndmask_b32_e32 v4, 0, v1, vcc
; FIXEDABI-SDAG-NEXT:    flat_store_dword v[2:3], v0
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-SDAG-NEXT:    v_mov_b32_e32 v0, 2
; FIXEDABI-SDAG-NEXT:    flat_store_dword v[4:5], v0
; FIXEDABI-SDAG-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; FIXEDABI-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; FIXEDABI-GISEL-LABEL: addrspacecast_requires_queue_ptr:
; FIXEDABI-GISEL:       ; %bb.0:
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-GISEL-NEXT:    s_load_dwordx2 s[4:5], s[6:7], 0x40
; FIXEDABI-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, -1, v0
; FIXEDABI-GISEL-NEXT:    v_cndmask_b32_e32 v2, 0, v0, vcc
; FIXEDABI-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-GISEL-NEXT:    v_mov_b32_e32 v0, s5
; FIXEDABI-GISEL-NEXT:    v_cndmask_b32_e32 v3, 0, v0, vcc
; FIXEDABI-GISEL-NEXT:    v_mov_b32_e32 v4, s4
; FIXEDABI-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, -1, v1
; FIXEDABI-GISEL-NEXT:    v_cndmask_b32_e32 v0, 0, v1, vcc
; FIXEDABI-GISEL-NEXT:    v_cndmask_b32_e32 v1, 0, v4, vcc
; FIXEDABI-GISEL-NEXT:    v_mov_b32_e32 v4, 1
; FIXEDABI-GISEL-NEXT:    flat_store_dword v[2:3], v4
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-GISEL-NEXT:    v_mov_b32_e32 v2, 2
; FIXEDABI-GISEL-NEXT:    flat_store_dword v[0:1], v2
; FIXEDABI-GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; FIXEDABI-GISEL-NEXT:    s_setpc_b64 s[30:31]
  %flat.private = addrspacecast i32 addrspace(5)* %ptr.private to i32*
  %flat.local = addrspacecast i32 addrspace(3)* %ptr.local to i32*
  store volatile i32 1, i32* %flat.private
  store volatile i32 2, i32* %flat.local
  ret void
}

define void @is_shared_requires_queue_ptr(i8* %ptr) #0 {
; FIXEDABI-LABEL: is_shared_requires_queue_ptr:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    s_load_dword s4, s[6:7], 0x40
; FIXEDABI-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-NEXT:    v_cmp_eq_u32_e32 vcc, s4, v1
; FIXEDABI-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v0
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_setpc_b64 s[30:31]
  %is.shared = call i1 @llvm.amdgcn.is.shared(i8* %ptr)
  %zext = zext i1 %is.shared to i32
  store volatile i32 %zext, i32 addrspace(1)* undef
  ret void
}

define void @is_private_requires_queue_ptr(i8* %ptr) #0 {
; FIXEDABI-LABEL: is_private_requires_queue_ptr:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    s_load_dword s4, s[6:7], 0x44
; FIXEDABI-NEXT:    s_waitcnt lgkmcnt(0)
; FIXEDABI-NEXT:    v_cmp_eq_u32_e32 vcc, s4, v1
; FIXEDABI-NEXT:    v_cndmask_b32_e64 v0, 0, 1, vcc
; FIXEDABI-NEXT:    flat_store_dword v[0:1], v0
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0)
; FIXEDABI-NEXT:    s_setpc_b64 s[30:31]
  %is.private = call i1 @llvm.amdgcn.is.private(i8* %ptr)
  %zext = zext i1 %is.private to i32
  store volatile i32 %zext, i32 addrspace(1)* undef
  ret void
}

define void @trap_requires_queue() #0 {
; FIXEDABI-LABEL: trap_requires_queue:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    s_mov_b64 s[0:1], s[6:7]
; FIXEDABI-NEXT:    s_trap 2
  call void @llvm.trap()
  unreachable
}

define void @debugtrap_requires_queue() #0 {
; FIXEDABI-LABEL: debugtrap_requires_queue:
; FIXEDABI:       ; %bb.0:
; FIXEDABI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; FIXEDABI-NEXT:    s_trap 3
  call void @llvm.debugtrap()
  unreachable
}

declare i32 @llvm.amdgcn.workitem.id.x()
declare i32 @llvm.amdgcn.workitem.id.y()
declare i32 @llvm.amdgcn.workitem.id.z()
declare i32 @llvm.amdgcn.workgroup.id.x()
declare i32 @llvm.amdgcn.workgroup.id.y()
declare i32 @llvm.amdgcn.workgroup.id.z()
declare noalias i8 addrspace(4)* @llvm.amdgcn.queue.ptr()
declare noalias i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
declare i64 @llvm.amdgcn.dispatch.id()
declare noalias i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
declare i1 @llvm.amdgcn.is.shared(i8*)
declare i1 @llvm.amdgcn.is.private(i8*)
declare void @llvm.trap()
declare void @llvm.debugtrap()

attributes #0 = { "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-queue-ptr" "amdgpu-no-work-group-id-x" "amdgpu-no-work-group-id-y" "amdgpu-no-work-group-id-z" "amdgpu-no-work-item-id-x" "amdgpu-no-work-item-id-y" "amdgpu-no-work-item-id-z" }
