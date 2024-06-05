// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +zkne -emit-llvm %s -o - \
// RUN:     | FileCheck %s  -check-prefix=RV64ZKNE


// RV64ZKNE-LABEL: @aes64es(
// RV64ZKNE-NEXT:  entry:
// RV64ZKNE-NEXT:    [[RS1_ADDR:%.*]] = alloca i32, align 4
// RV64ZKNE-NEXT:    [[RS2_ADDR:%.*]] = alloca i32, align 4
// RV64ZKNE-NEXT:    store i32 [[RS1:%.*]], ptr [[RS1_ADDR]], align 4
// RV64ZKNE-NEXT:    store i32 [[RS2:%.*]], ptr [[RS2_ADDR]], align 4
// RV64ZKNE-NEXT:    [[TMP0:%.*]] = load i32, ptr [[RS1_ADDR]], align 4
// RV64ZKNE-NEXT:    [[CONV:%.*]] = sext i32 [[TMP0]] to i64
// RV64ZKNE-NEXT:    [[TMP1:%.*]] = load i32, ptr [[RS2_ADDR]], align 4
// RV64ZKNE-NEXT:    [[CONV1:%.*]] = sext i32 [[TMP1]] to i64
// RV64ZKNE-NEXT:    [[TMP2:%.*]] = call i64 @llvm.riscv.aes64es(i64 [[CONV]], i64 [[CONV1]])
// RV64ZKNE-NEXT:    [[CONV2:%.*]] = trunc i64 [[TMP2]] to i32
// RV64ZKNE-NEXT:    ret i32 [[CONV2]]
//
int aes64es(int rs1, int rs2) {
  return __builtin_riscv_aes64es_64(rs1, rs2);
}


// RV64ZKNE-LABEL: @aes64esm(
// RV64ZKNE-NEXT:  entry:
// RV64ZKNE-NEXT:    [[RS1_ADDR:%.*]] = alloca i32, align 4
// RV64ZKNE-NEXT:    [[RS2_ADDR:%.*]] = alloca i32, align 4
// RV64ZKNE-NEXT:    store i32 [[RS1:%.*]], ptr [[RS1_ADDR]], align 4
// RV64ZKNE-NEXT:    store i32 [[RS2:%.*]], ptr [[RS2_ADDR]], align 4
// RV64ZKNE-NEXT:    [[TMP0:%.*]] = load i32, ptr [[RS1_ADDR]], align 4
// RV64ZKNE-NEXT:    [[CONV:%.*]] = sext i32 [[TMP0]] to i64
// RV64ZKNE-NEXT:    [[TMP1:%.*]] = load i32, ptr [[RS2_ADDR]], align 4
// RV64ZKNE-NEXT:    [[CONV1:%.*]] = sext i32 [[TMP1]] to i64
// RV64ZKNE-NEXT:    [[TMP2:%.*]] = call i64 @llvm.riscv.aes64esm(i64 [[CONV]], i64 [[CONV1]])
// RV64ZKNE-NEXT:    [[CONV2:%.*]] = trunc i64 [[TMP2]] to i32
// RV64ZKNE-NEXT:    ret i32 [[CONV2]]
//
int aes64esm(int rs1, int rs2) {
  return __builtin_riscv_aes64esm_64(rs1, rs2);
}
