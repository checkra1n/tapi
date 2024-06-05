// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svld3_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.ld3.sret.nxv8bf16(<vscale x 8 x i1> [[TMP0]], bfloat* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> poison, <vscale x 8 x bfloat> [[TMP2]], i64 0)
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 1
// CHECK-NEXT:    [[TMP5:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP3]], <vscale x 8 x bfloat> [[TMP4]], i64 8)
// CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 2
// CHECK-NEXT:    [[TMP7:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP5]], <vscale x 8 x bfloat> [[TMP6]], i64 16)
// CHECK-NEXT:    ret <vscale x 24 x bfloat> [[TMP7]]
//
// CPP-CHECK-LABEL: @_Z15test_svld3_bf16u10__SVBool_tPKu6__bf16(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.ld3.sret.nxv8bf16(<vscale x 8 x i1> [[TMP0]], bfloat* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> poison, <vscale x 8 x bfloat> [[TMP2]], i64 0)
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 1
// CPP-CHECK-NEXT:    [[TMP5:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP3]], <vscale x 8 x bfloat> [[TMP4]], i64 8)
// CPP-CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP1]], 2
// CPP-CHECK-NEXT:    [[TMP7:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP5]], <vscale x 8 x bfloat> [[TMP6]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 24 x bfloat> [[TMP7]]
//
svbfloat16x3_t test_svld3_bf16(svbool_t pg, const bfloat16_t *base)
{
  return SVE_ACLE_FUNC(svld3,_bf16,,)(pg, base);
}

// CHECK-LABEL: @test_svld3_vnum_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.ld3.sret.nxv8bf16(<vscale x 8 x i1> [[TMP0]], bfloat* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 0
// CHECK-NEXT:    [[TMP5:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> poison, <vscale x 8 x bfloat> [[TMP4]], i64 0)
// CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 1
// CHECK-NEXT:    [[TMP7:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP5]], <vscale x 8 x bfloat> [[TMP6]], i64 8)
// CHECK-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 2
// CHECK-NEXT:    [[TMP9:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP7]], <vscale x 8 x bfloat> [[TMP8]], i64 16)
// CHECK-NEXT:    ret <vscale x 24 x bfloat> [[TMP9]]
//
// CPP-CHECK-LABEL: @_Z20test_svld3_vnum_bf16u10__SVBool_tPKu6__bf16l(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sve.ld3.sret.nxv8bf16(<vscale x 8 x i1> [[TMP0]], bfloat* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 0
// CPP-CHECK-NEXT:    [[TMP5:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> poison, <vscale x 8 x bfloat> [[TMP4]], i64 0)
// CPP-CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 1
// CPP-CHECK-NEXT:    [[TMP7:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP5]], <vscale x 8 x bfloat> [[TMP6]], i64 8)
// CPP-CHECK-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP3]], 2
// CPP-CHECK-NEXT:    [[TMP9:%.*]] = tail call <vscale x 24 x bfloat> @llvm.vector.insert.nxv24bf16.nxv8bf16(<vscale x 24 x bfloat> [[TMP7]], <vscale x 8 x bfloat> [[TMP8]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 24 x bfloat> [[TMP9]]
//
svbfloat16x3_t test_svld3_vnum_bf16(svbool_t pg, const bfloat16_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svld3_vnum,_bf16,,)(pg, base, vnum);
}
