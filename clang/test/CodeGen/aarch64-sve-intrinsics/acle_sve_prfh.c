// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svprfh(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z11test_svprfhu10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 1)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_1u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 1)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_1(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL1STRM);
}

// CHECK-LABEL: @test_svprfh_2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 2)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_2u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 2)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_2(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL2KEEP);
}

// CHECK-LABEL: @test_svprfh_3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_3u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_3(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL2STRM);
}

// CHECK-LABEL: @test_svprfh_4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 4)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_4u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 4)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_4(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL3KEEP);
}

// CHECK-LABEL: @test_svprfh_5(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 5)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_5u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 5)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_5(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PLDL3STRM);
}

// CHECK-LABEL: @test_svprfh_6(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 8)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_6u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 8)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_6(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL1KEEP);
}

// CHECK-LABEL: @test_svprfh_7(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 9)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_7u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 9)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_7(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL1STRM);
}

// CHECK-LABEL: @test_svprfh_8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 10)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_8u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 10)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_8(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL2KEEP);
}

// CHECK-LABEL: @test_svprfh_9(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 11)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z13test_svprfh_9u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 11)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_9(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL2STRM);
}

// CHECK-LABEL: @test_svprfh_10(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 12)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z14test_svprfh_10u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 12)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_10(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL3KEEP);
}

// CHECK-LABEL: @test_svprfh_11(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 13)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z14test_svprfh_11u10__SVBool_tPKv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]], i32 13)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_11(svbool_t pg, const void *base)
{
  return svprfh(pg, base, SV_PSTL3STRM);
}

// CHECK-LABEL: @test_svprfh_vnum(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[TMP2]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z16test_svprfh_vnumu10__SVBool_tPKvl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prf.nxv8i1(<vscale x 8 x i1> [[TMP0]], ptr [[TMP2]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_vnum(svbool_t pg, const void *base, int64_t vnum)
{
  return svprfh_vnum(pg, base, vnum, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u32base(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0, i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z26test_svprfh_gather_u32baseu10__SVBool_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0, i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u32base(svbool_t pg, svuint32_t bases)
{
  return SVE_ACLE_FUNC(svprfh_gather,_u32base,,)(pg, bases, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u64base(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0, i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z26test_svprfh_gather_u64baseu10__SVBool_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0, i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u64base(svbool_t pg, svuint64_t bases)
{
  return SVE_ACLE_FUNC(svprfh_gather,_u64base,,)(pg, bases, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_s32index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.sxtw.index.nxv4i32(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[INDICES:%.*]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z27test_svprfh_gather_s32indexu10__SVBool_tPKvu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.sxtw.index.nxv4i32(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[INDICES:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_s32index(svbool_t pg, const void *base, svint32_t indices)
{
  return SVE_ACLE_FUNC(svprfh_gather_,s32,index,)(pg, base, indices, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_s64index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.index.nxv2i64(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[INDICES:%.*]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z27test_svprfh_gather_s64indexu10__SVBool_tPKvu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.index.nxv2i64(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[INDICES:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_s64index(svbool_t pg, const void *base, svint64_t indices)
{
  return SVE_ACLE_FUNC(svprfh_gather_,s64,index,)(pg, base, indices, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u32index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.uxtw.index.nxv4i32(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[INDICES:%.*]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z27test_svprfh_gather_u32indexu10__SVBool_tPKvu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.uxtw.index.nxv4i32(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[INDICES:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u32index(svbool_t pg, const void *base, svuint32_t indices)
{
  return SVE_ACLE_FUNC(svprfh_gather_,u32,index,)(pg, base, indices, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u64index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.index.nxv2i64(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[INDICES:%.*]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z27test_svprfh_gather_u64indexu10__SVBool_tPKvu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.index.nxv2i64(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[INDICES:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u64index(svbool_t pg, const void *base, svuint64_t indices)
{
  return SVE_ACLE_FUNC(svprfh_gather_,u64,index,)(pg, base, indices, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u32base_index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[INDEX:%.*]], 1
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[TMP1]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z32test_svprfh_gather_u32base_indexu10__SVBool_tu12__SVUint32_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[INDEX:%.*]], 1
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[TMP1]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u32base_index(svbool_t pg, svuint32_t bases, int64_t index)
{
  return SVE_ACLE_FUNC(svprfh_gather,_u32base,_index,)(pg, bases, index, SV_PLDL1KEEP);
}

// CHECK-LABEL: @test_svprfh_gather_u64base_index(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[INDEX:%.*]], 1
// CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[TMP1]], i32 0)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z32test_svprfh_gather_u64base_indexu10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[INDEX:%.*]], 1
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sve.prfh.gather.scalar.offset.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[TMP1]], i32 0)
// CPP-CHECK-NEXT:    ret void
//
void test_svprfh_gather_u64base_index(svbool_t pg, svuint64_t bases, int64_t index)
{
  return SVE_ACLE_FUNC(svprfh_gather,_u64base,_index,)(pg, bases, index, SV_PLDL1KEEP);
}
