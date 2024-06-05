; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=amdgcn-amd-amdhsa --amdhsa-code-object-version=5 -S -opaque-pointers -passes=amdgpu-lower-kernel-attributes,instcombine %s | FileCheck -enable-var-scope -check-prefix=GCN %s

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define amdgpu_kernel void @get_local_size_x_opaque_pointer(i16 addrspace(1)* %out) #0 {
; GCN-LABEL: @get_local_size_x_opaque_pointer(
; GCN-NEXT:    [[IMPLICITARG_PTR:%.*]] = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; GCN-NEXT:    [[GEP_LOCAL_SIZE:%.*]] = getelementptr inbounds i8, ptr addrspace(4) [[IMPLICITARG_PTR]], i64 12
; GCN-NEXT:    [[LOCAL_SIZE:%.*]] = load i16, ptr addrspace(4) [[GEP_LOCAL_SIZE]], align 4
; GCN-NEXT:    store i16 [[LOCAL_SIZE]], ptr addrspace(1) [[OUT:%.*]], align 2
; GCN-NEXT:    ret void
;
  %group.id = tail call i32 @llvm.amdgcn.workgroup.id.x()
  %implicitarg.ptr = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
  %block.count.x = load i32, ptr addrspace(4) %implicitarg.ptr, align 4
  %cmp.id.count = icmp ult i32 %group.id, %block.count.x
  %local.size.offset = select i1 %cmp.id.count, i64 12, i64 18
  %gep.local.size = getelementptr inbounds i8, ptr addrspace(4) %implicitarg.ptr, i64 %local.size.offset
  %local.size = load i16, ptr addrspace(4) %gep.local.size, align 2
  store i16 %local.size, i16 addrspace(1)* %out
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define amdgpu_kernel void @get_local_size_y_opaque_pointer(i16 addrspace(1)* %out) #0 {
; GCN-LABEL: @get_local_size_y_opaque_pointer(
; GCN-NEXT:    [[IMPLICITARG_PTR:%.*]] = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; GCN-NEXT:    [[GEP_LOCAL_SIZE:%.*]] = getelementptr inbounds i8, ptr addrspace(4) [[IMPLICITARG_PTR]], i64 14
; GCN-NEXT:    [[LOCAL_SIZE:%.*]] = load i16, ptr addrspace(4) [[GEP_LOCAL_SIZE]], align 2
; GCN-NEXT:    store i16 [[LOCAL_SIZE]], ptr addrspace(1) [[OUT:%.*]], align 2
; GCN-NEXT:    ret void
;
  %group.id = tail call i32 @llvm.amdgcn.workgroup.id.y()
  %implicitarg.ptr = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
  %gep.block.count.y = getelementptr inbounds i8, ptr addrspace(4) %implicitarg.ptr, i64 4
  %block.count.y = load i32, ptr addrspace(4) %gep.block.count.y, align 4
  %cmp.id.count = icmp ult i32 %group.id, %block.count.y
  %local.size.offset = select i1 %cmp.id.count, i64 14, i64 20
  %gep.local.size = getelementptr inbounds i8, ptr addrspace(4) %implicitarg.ptr, i64 %local.size.offset
  %local.size = load i16, ptr addrspace(4) %gep.local.size, align 2
  store i16 %local.size, i16 addrspace(1)* %out
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define amdgpu_kernel void @get_local_size_z_opaque_pointer(i16 addrspace(1)* %out) #0 {
; GCN-LABEL: @get_local_size_z_opaque_pointer(
; GCN-NEXT:    [[IMPLICITARG_PTR:%.*]] = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
; GCN-NEXT:    [[GEP_LOCAL_SIZE:%.*]] = getelementptr inbounds i8, ptr addrspace(4) [[IMPLICITARG_PTR]], i64 16
; GCN-NEXT:    [[LOCAL_SIZE:%.*]] = load i16, ptr addrspace(4) [[GEP_LOCAL_SIZE]], align 4
; GCN-NEXT:    store i16 [[LOCAL_SIZE]], ptr addrspace(1) [[OUT:%.*]], align 2
; GCN-NEXT:    ret void
;
  %group.id = tail call i32 @llvm.amdgcn.workgroup.id.z()
  %implicitarg.ptr = tail call ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr()
  %gep.block.count.z = getelementptr inbounds i8, ptr addrspace(4) %implicitarg.ptr, i64 8
  %block.count.z = load i32, ptr addrspace(4) %gep.block.count.z, align 4
  %cmp.id.count = icmp ult i32 %group.id, %block.count.z
  %local.size.offset = select i1 %cmp.id.count, i64 16, i64 22
  %gep.local.size = getelementptr inbounds i8, ptr addrspace(4) %implicitarg.ptr, i64 %local.size.offset
  %local.size = load i16, ptr addrspace(4) %gep.local.size, align 2
  store i16 %local.size, i16 addrspace(1)* %out
  ret void
}

declare ptr addrspace(4) @llvm.amdgcn.implicitarg.ptr() #1
declare i32 @llvm.amdgcn.workgroup.id.x() #1
declare i32 @llvm.amdgcn.workgroup.id.y() #1
declare i32 @llvm.amdgcn.workgroup.id.z() #1

!llvm.module.flags = !{!1}

attributes #0 = { nounwind "uniform-work-group-size"="true" }
attributes #1 = { nounwind readnone speculatable }
!0 = !{i32 8, i32 16, i32 2}
!1 = !{i32 1, !"amdgpu_code_object_version", i32 500}
