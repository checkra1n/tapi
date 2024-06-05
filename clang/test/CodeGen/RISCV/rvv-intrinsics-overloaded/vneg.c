// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vneg_v_i8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vrsub.nxv1i8.i8.i64(<vscale x 1 x i8> poison, <vscale x 1 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vint8mf8_t test_vneg_v_i8mf8 (vint8mf8_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vrsub.nxv2i8.i8.i64(<vscale x 2 x i8> poison, <vscale x 2 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vint8mf4_t test_vneg_v_i8mf4 (vint8mf4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vrsub.nxv4i8.i8.i64(<vscale x 4 x i8> poison, <vscale x 4 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vint8mf2_t test_vneg_v_i8mf2 (vint8mf2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vrsub.nxv8i8.i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vneg_v_i8m1 (vint8m1_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vrsub.nxv16i8.i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vneg_v_i8m2 (vint8m2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vrsub.nxv32i8.i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vneg_v_i8m4 (vint8m4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vrsub.nxv64i8.i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i8> [[OP1:%.*]], i8 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vneg_v_i8m8 (vint8m8_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vrsub.nxv1i16.i16.i64(<vscale x 1 x i16> poison, <vscale x 1 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vint16mf4_t test_vneg_v_i16mf4 (vint16mf4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vrsub.nxv2i16.i16.i64(<vscale x 2 x i16> poison, <vscale x 2 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vint16mf2_t test_vneg_v_i16mf2 (vint16mf2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vrsub.nxv4i16.i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vneg_v_i16m1 (vint16m1_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vrsub.nxv8i16.i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vneg_v_i16m2 (vint16m2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vrsub.nxv16i16.i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vneg_v_i16m4 (vint16m4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vrsub.nxv32i16.i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i16> [[OP1:%.*]], i16 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vneg_v_i16m8 (vint16m8_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.nxv1i32.i32.i64(<vscale x 1 x i32> poison, <vscale x 1 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2 (vint32mf2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vrsub.nxv2i32.i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vneg_v_i32m1 (vint32m1_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vrsub.nxv4i32.i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vneg_v_i32m2 (vint32m2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vrsub.nxv8i32.i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vneg_v_i32m4 (vint32m4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vrsub.nxv16i32.i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vneg_v_i32m8 (vint32m8_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vrsub.nxv1i64.i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> [[OP1:%.*]], i64 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vneg_v_i64m1 (vint64m1_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vrsub.nxv2i64.i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> [[OP1:%.*]], i64 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vneg_v_i64m2 (vint64m2_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vrsub.nxv4i64.i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> [[OP1:%.*]], i64 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vneg_v_i64m4 (vint64m4_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vrsub.nxv8i64.i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i64> [[OP1:%.*]], i64 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vneg_v_i64m8 (vint64m8_t op1, size_t vl) {
  return vneg(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8mf8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vrsub.mask.nxv1i8.i8.i64(<vscale x 1 x i8> [[MASKEDOFF:%.*]], <vscale x 1 x i8> [[OP1:%.*]], i8 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vint8mf8_t test_vneg_v_i8mf8_m (vbool64_t mask, vint8mf8_t maskedoff, vint8mf8_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vrsub.mask.nxv2i8.i8.i64(<vscale x 2 x i8> [[MASKEDOFF:%.*]], <vscale x 2 x i8> [[OP1:%.*]], i8 0, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vint8mf4_t test_vneg_v_i8mf4_m (vbool32_t mask, vint8mf4_t maskedoff, vint8mf4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vrsub.mask.nxv4i8.i8.i64(<vscale x 4 x i8> [[MASKEDOFF:%.*]], <vscale x 4 x i8> [[OP1:%.*]], i8 0, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vint8mf2_t test_vneg_v_i8mf2_m (vbool16_t mask, vint8mf2_t maskedoff, vint8mf2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vrsub.mask.nxv8i8.i8.i64(<vscale x 8 x i8> [[MASKEDOFF:%.*]], <vscale x 8 x i8> [[OP1:%.*]], i8 0, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vneg_v_i8m1_m (vbool8_t mask, vint8m1_t maskedoff, vint8m1_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vrsub.mask.nxv16i8.i8.i64(<vscale x 16 x i8> [[MASKEDOFF:%.*]], <vscale x 16 x i8> [[OP1:%.*]], i8 0, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vneg_v_i8m2_m (vbool4_t mask, vint8m2_t maskedoff, vint8m2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vrsub.mask.nxv32i8.i8.i64(<vscale x 32 x i8> [[MASKEDOFF:%.*]], <vscale x 32 x i8> [[OP1:%.*]], i8 0, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vneg_v_i8m4_m (vbool2_t mask, vint8m4_t maskedoff, vint8m4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i8m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.vrsub.mask.nxv64i8.i8.i64(<vscale x 64 x i8> [[MASKEDOFF:%.*]], <vscale x 64 x i8> [[OP1:%.*]], i8 0, <vscale x 64 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vneg_v_i8m8_m (vbool1_t mask, vint8m8_t maskedoff, vint8m8_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vrsub.mask.nxv1i16.i16.i64(<vscale x 1 x i16> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], i16 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vint16mf4_t test_vneg_v_i16mf4_m (vbool64_t mask, vint16mf4_t maskedoff, vint16mf4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vrsub.mask.nxv2i16.i16.i64(<vscale x 2 x i16> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], i16 0, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vint16mf2_t test_vneg_v_i16mf2_m (vbool32_t mask, vint16mf2_t maskedoff, vint16mf2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vrsub.mask.nxv4i16.i16.i64(<vscale x 4 x i16> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i16 0, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vneg_v_i16m1_m (vbool16_t mask, vint16m1_t maskedoff, vint16m1_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vrsub.mask.nxv8i16.i16.i64(<vscale x 8 x i16> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i16 0, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vneg_v_i16m2_m (vbool8_t mask, vint16m2_t maskedoff, vint16m2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vrsub.mask.nxv16i16.i16.i64(<vscale x 16 x i16> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i16 0, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vneg_v_i16m4_m (vbool4_t mask, vint16m4_t maskedoff, vint16m4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i16m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.vrsub.mask.nxv32i16.i16.i64(<vscale x 32 x i16> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i16 0, <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vneg_v_i16m8_m (vbool2_t mask, vint16m8_t maskedoff, vint16m8_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_m (vbool64_t mask, vint32mf2_t maskedoff, vint32mf2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vrsub.mask.nxv2i32.i32.i64(<vscale x 2 x i32> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i32 0, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vneg_v_i32m1_m (vbool32_t mask, vint32m1_t maskedoff, vint32m1_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vrsub.mask.nxv4i32.i32.i64(<vscale x 4 x i32> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i32 0, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vneg_v_i32m2_m (vbool16_t mask, vint32m2_t maskedoff, vint32m2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vrsub.mask.nxv8i32.i32.i64(<vscale x 8 x i32> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i32 0, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vneg_v_i32m4_m (vbool8_t mask, vint32m4_t maskedoff, vint32m4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.vrsub.mask.nxv16i32.i32.i64(<vscale x 16 x i32> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i32 0, <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vneg_v_i32m8_m (vbool4_t mask, vint32m8_t maskedoff, vint32m8_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.vrsub.mask.nxv1i64.i64.i64(<vscale x 1 x i64> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vneg_v_i64m1_m (vbool64_t mask, vint64m1_t maskedoff, vint64m1_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.vrsub.mask.nxv2i64.i64.i64(<vscale x 2 x i64> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 0, <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vneg_v_i64m2_m (vbool32_t mask, vint64m2_t maskedoff, vint64m2_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.vrsub.mask.nxv4i64.i64.i64(<vscale x 4 x i64> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 0, <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vneg_v_i64m4_m (vbool16_t mask, vint64m4_t maskedoff, vint64m4_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i64m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.vrsub.mask.nxv8i64.i64.i64(<vscale x 8 x i64> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 0, <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vneg_v_i64m8_m (vbool8_t mask, vint64m8_t maskedoff, vint64m8_t op1, size_t vl) {
  return vneg(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_tu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.nxv1i32.i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_tu(vint32mf2_t merge, vint32mf2_t op1, size_t vl) {
  return vneg_tu(merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_ta(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.nxv1i32.i32.i64(<vscale x 1 x i32> poison, <vscale x 1 x i32> [[OP1:%.*]], i32 0, i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_ta(vint32mf2_t op1, size_t vl) {
  return vneg_ta(op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_tuma(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 2)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_tuma(vbool64_t mask, vint32mf2_t merge, vint32mf2_t op1, size_t vl) {
  return vneg_tuma(mask, merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_tumu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_tumu(vbool64_t mask, vint32mf2_t merge, vint32mf2_t op1, size_t vl) {
  return vneg_tumu(mask, merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_tama(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.mask.nxv1i32.i32.i64(<vscale x 1 x i32> poison, <vscale x 1 x i32> [[OP1:%.*]], i32 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_tama(vbool64_t mask, vint32mf2_t op1, size_t vl) {
  return vneg_tama(mask, op1, vl);
}

// CHECK-RV64-LABEL: @test_vneg_v_i32mf2_tamu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vrsub.mask.nxv1i32.i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 0, <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 1)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vint32mf2_t test_vneg_v_i32mf2_tamu(vbool64_t mask, vint32mf2_t merge, vint32mf2_t op1, size_t vl) {
  return vneg_tamu(mask, merge, op1, vl);
}
