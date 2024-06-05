// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d \
// RUN:   -target-feature +v -target-feature +zfh -target-feature +experimental-zvfh \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfmerge.nxv1f32.f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfmerge_vfm_f32mf2(vbool64_t mask, vfloat32mf2_t op1,
                                      float op2, size_t vl) {
  return vfmerge_vfm_f32mf2(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x float> @llvm.riscv.vfmerge.nxv2f32.f32.i64(<vscale x 2 x float> poison, <vscale x 2 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> [[TMP0]]
//
vfloat32m1_t test_vfmerge_vfm_f32m1(vbool32_t mask, vfloat32m1_t op1, float op2,
                                    size_t vl) {
  return vfmerge_vfm_f32m1(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.riscv.vfmerge.nxv4f32.f32.i64(<vscale x 4 x float> poison, <vscale x 4 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
vfloat32m2_t test_vfmerge_vfm_f32m2(vbool16_t mask, vfloat32m2_t op1, float op2,
                                    size_t vl) {
  return vfmerge_vfm_f32m2(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x float> @llvm.riscv.vfmerge.nxv8f32.f32.i64(<vscale x 8 x float> poison, <vscale x 8 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> [[TMP0]]
//
vfloat32m4_t test_vfmerge_vfm_f32m4(vbool8_t mask, vfloat32m4_t op1, float op2,
                                    size_t vl) {
  return vfmerge_vfm_f32m4(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x float> @llvm.riscv.vfmerge.nxv16f32.f32.i64(<vscale x 16 x float> poison, <vscale x 16 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> [[TMP0]]
//
vfloat32m8_t test_vfmerge_vfm_f32m8(vbool4_t mask, vfloat32m8_t op1, float op2,
                                    size_t vl) {
  return vfmerge_vfm_f32m8(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x double> @llvm.riscv.vfmerge.nxv1f64.f64.i64(<vscale x 1 x double> poison, <vscale x 1 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x double> [[TMP0]]
//
vfloat64m1_t test_vfmerge_vfm_f64m1(vbool64_t mask, vfloat64m1_t op1,
                                    double op2, size_t vl) {
  return vfmerge_vfm_f64m1(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.riscv.vfmerge.nxv2f64.f64.i64(<vscale x 2 x double> poison, <vscale x 2 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
vfloat64m2_t test_vfmerge_vfm_f64m2(vbool32_t mask, vfloat64m2_t op1,
                                    double op2, size_t vl) {
  return vfmerge_vfm_f64m2(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x double> @llvm.riscv.vfmerge.nxv4f64.f64.i64(<vscale x 4 x double> poison, <vscale x 4 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x double> [[TMP0]]
//
vfloat64m4_t test_vfmerge_vfm_f64m4(vbool16_t mask, vfloat64m4_t op1,
                                    double op2, size_t vl) {
  return vfmerge_vfm_f64m4(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x double> @llvm.riscv.vfmerge.nxv8f64.f64.i64(<vscale x 8 x double> poison, <vscale x 8 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x double> [[TMP0]]
//
vfloat64m8_t test_vfmerge_vfm_f64m8(vbool8_t mask, vfloat64m8_t op1, double op2,
                                    size_t vl) {
  return vfmerge_vfm_f64m8(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x half> @llvm.riscv.vfmerge.nxv1f16.f16.i64(<vscale x 1 x half> poison, <vscale x 1 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x half> [[TMP0]]
//
vfloat16mf4_t test_vfmerge_vfm_f16mf4(vbool64_t mask, vfloat16mf4_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16mf4(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x half> @llvm.riscv.vfmerge.nxv2f16.f16.i64(<vscale x 2 x half> poison, <vscale x 2 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x half> [[TMP0]]
//
vfloat16mf2_t test_vfmerge_vfm_f16mf2(vbool32_t mask, vfloat16mf2_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16mf2(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x half> @llvm.riscv.vfmerge.nxv4f16.f16.i64(<vscale x 4 x half> poison, <vscale x 4 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> [[TMP0]]
//
vfloat16m1_t test_vfmerge_vfm_f16m1(vbool16_t mask, vfloat16m1_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16m1(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.riscv.vfmerge.nxv8f16.f16.i64(<vscale x 8 x half> poison, <vscale x 8 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
vfloat16m2_t test_vfmerge_vfm_f16m2(vbool8_t mask, vfloat16m2_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16m2(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x half> @llvm.riscv.vfmerge.nxv16f16.f16.i64(<vscale x 16 x half> poison, <vscale x 16 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> [[TMP0]]
//
vfloat16m4_t test_vfmerge_vfm_f16m4(vbool4_t mask, vfloat16m4_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16m4(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x half> @llvm.riscv.vfmerge.nxv32f16.f16.i64(<vscale x 32 x half> poison, <vscale x 32 x half> [[OP1:%.*]], half [[OP2:%.*]], <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x half> [[TMP0]]
//
vfloat16m8_t test_vfmerge_vfm_f16m8(vbool2_t mask, vfloat16m8_t op1, _Float16 op2, size_t vl) {
  return vfmerge_vfm_f16m8(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32mf2_tu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfmerge.nxv1f32.f32.i64(<vscale x 1 x float> [[MERGE:%.*]], <vscale x 1 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfmerge_vfm_f32mf2_tu(vbool64_t mask, vfloat32mf2_t merge, vfloat32mf2_t op1, float op2, size_t vl) {
  return vfmerge_vfm_f32mf2_tu(mask, merge, op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vfmerge_vfm_f32mf2_ta(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfmerge.nxv1f32.f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfmerge_vfm_f32mf2_ta(vbool64_t mask, vfloat32mf2_t op1, float op2, size_t vl) {
  return vfmerge_vfm_f32mf2_ta(mask, op1, op2, vl);
}