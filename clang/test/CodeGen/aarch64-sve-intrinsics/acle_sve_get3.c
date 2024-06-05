// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svget3_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv48i8(<vscale x 48 x i8> [[TUPLE:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svget3_s810svint8x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv48i8(<vscale x 48 x i8> [[TUPLE:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svget3_s8(svint8x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_s8,,)(tuple, 0);
}

// CHECK-LABEL: @test_svget3_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv24i16(<vscale x 24 x i16> [[TUPLE:%.*]], i64 16)
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_s1611svint16x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv24i16(<vscale x 24 x i16> [[TUPLE:%.*]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svget3_s16(svint16x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_s16,,)(tuple, 2);
}

// CHECK-LABEL: @test_svget3_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv12i32(<vscale x 12 x i32> [[TUPLE:%.*]], i64 4)
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_s3211svint32x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv12i32(<vscale x 12 x i32> [[TUPLE:%.*]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svget3_s32(svint32x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_s32,,)(tuple, 1);
}

// CHECK-LABEL: @test_svget3_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.vector.extract.nxv2i64.nxv6i64(<vscale x 6 x i64> [[TUPLE:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_s6411svint64x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.vector.extract.nxv2i64.nxv6i64(<vscale x 6 x i64> [[TUPLE:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t test_svget3_s64(svint64x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_s64,,)(tuple, 0);
}

// CHECK-LABEL: @test_svget3_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv48i8(<vscale x 48 x i8> [[TUPLE:%.*]], i64 32)
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svget3_u811svuint8x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv48i8(<vscale x 48 x i8> [[TUPLE:%.*]], i64 32)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svget3_u8(svuint8x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_u8,,)(tuple, 2);
}

// CHECK-LABEL: @test_svget3_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv24i16(<vscale x 24 x i16> [[TUPLE:%.*]], i64 8)
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_u1612svuint16x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv24i16(<vscale x 24 x i16> [[TUPLE:%.*]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svget3_u16(svuint16x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_u16,,)(tuple, 1);
}

// CHECK-LABEL: @test_svget3_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv12i32(<vscale x 12 x i32> [[TUPLE:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_u3212svuint32x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.vector.extract.nxv4i32.nxv12i32(<vscale x 12 x i32> [[TUPLE:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svget3_u32(svuint32x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_u32,,)(tuple, 0);
}

// CHECK-LABEL: @test_svget3_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.vector.extract.nxv2i64.nxv6i64(<vscale x 6 x i64> [[TUPLE:%.*]], i64 4)
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_u6412svuint64x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.vector.extract.nxv2i64.nxv6i64(<vscale x 6 x i64> [[TUPLE:%.*]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svuint64_t test_svget3_u64(svuint64x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_u64,,)(tuple, 2);
}

// CHECK-LABEL: @test_svget3_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv24f16(<vscale x 24 x half> [[TUPLE:%.*]], i64 8)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_f1613svfloat16x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv24f16(<vscale x 24 x half> [[TUPLE:%.*]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svget3_f16(svfloat16x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_f16,,)(tuple, 1);
}

// CHECK-LABEL: @test_svget3_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.vector.extract.nxv4f32.nxv12f32(<vscale x 12 x float> [[TUPLE:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_f3213svfloat32x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.vector.extract.nxv4f32.nxv12f32(<vscale x 12 x float> [[TUPLE:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svget3_f32(svfloat32x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_f32,,)(tuple, 0);
}

// CHECK-LABEL: @test_svget3_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.vector.extract.nxv2f64.nxv6f64(<vscale x 6 x double> [[TUPLE:%.*]], i64 4)
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget3_f6413svfloat64x3_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.vector.extract.nxv2f64.nxv6f64(<vscale x 6 x double> [[TUPLE:%.*]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svget3_f64(svfloat64x3_t tuple)
{
  return SVE_ACLE_FUNC(svget3,_f64,,)(tuple, 2);
}
