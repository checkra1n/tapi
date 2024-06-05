// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs
// RUN: %clang_cc1 -fopenmp-enable-irbuilder -verify -fopenmp -fopenmp-version=51 -x c -triple x86_64-unknown-unknown -emit-llvm %s -o - | FileCheck %s
// expected-no-diagnostics

#ifndef HEADER
#define HEADER

// CHECK-LABEL: define {{.*}}@unroll_partial_factor(
// CHECK-NEXT:  [[ENTRY:.*]]:
// CHECK-NEXT:    %[[A_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[B_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[C_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[D_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[I:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[AGG_CAPTURED:.+]] = alloca %struct.anon, align 8
// CHECK-NEXT:    %[[AGG_CAPTURED1:.+]] = alloca %struct.anon.0, align 4
// CHECK-NEXT:    %[[DOTCOUNT_ADDR:.+]] = alloca i32, align 4
// CHECK-NEXT:    store ptr %[[A:.+]], ptr %[[A_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[B:.+]], ptr %[[B_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[C:.+]], ptr %[[C_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[D:.+]], ptr %[[D_ADDR]], align 8
// CHECK-NEXT:    store i32 0, ptr %[[I]], align 4
// CHECK-NEXT:    %[[TMP0:.+]] = getelementptr inbounds %struct.anon, ptr %[[AGG_CAPTURED]], i32 0, i32 0
// CHECK-NEXT:    store ptr %[[I]], ptr %[[TMP0]], align 8
// CHECK-NEXT:    %[[TMP1:.+]] = getelementptr inbounds %struct.anon.0, ptr %[[AGG_CAPTURED1]], i32 0, i32 0
// CHECK-NEXT:    %[[TMP2:.+]] = load i32, ptr %[[I]], align 4
// CHECK-NEXT:    store i32 %[[TMP2]], ptr %[[TMP1]], align 4
// CHECK-NEXT:    call void @__captured_stmt(ptr %[[DOTCOUNT_ADDR]], ptr %[[AGG_CAPTURED]])
// CHECK-NEXT:    %[[DOTCOUNT:.+]] = load i32, ptr %[[DOTCOUNT_ADDR]], align 4
// CHECK-NEXT:    br label %[[OMP_LOOP_PREHEADER:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_PREHEADER]]:
// CHECK-NEXT:    br label %[[OMP_LOOP_HEADER:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_HEADER]]:
// CHECK-NEXT:    %[[OMP_LOOP_IV:.+]] = phi i32 [ 0, %[[OMP_LOOP_PREHEADER]] ], [ %[[OMP_LOOP_NEXT:.+]], %[[OMP_LOOP_INC:.+]] ]
// CHECK-NEXT:    br label %[[OMP_LOOP_COND:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_COND]]:
// CHECK-NEXT:    %[[OMP_LOOP_CMP:.+]] = icmp ult i32 %[[OMP_LOOP_IV]], %[[DOTCOUNT]]
// CHECK-NEXT:    br i1 %[[OMP_LOOP_CMP]], label %[[OMP_LOOP_BODY:.+]], label %[[OMP_LOOP_EXIT:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_BODY]]:
// CHECK-NEXT:    call void @__captured_stmt.1(ptr %[[I]], i32 %[[OMP_LOOP_IV]], ptr %[[AGG_CAPTURED1]])
// CHECK-NEXT:    %[[TMP3:.+]] = load ptr, ptr %[[B_ADDR]], align 8
// CHECK-NEXT:    %[[TMP4:.+]] = load i32, ptr %[[I]], align 4
// CHECK-NEXT:    %[[IDXPROM:.+]] = sext i32 %[[TMP4]] to i64
// CHECK-NEXT:    %[[ARRAYIDX:.+]] = getelementptr inbounds float, ptr %[[TMP3]], i64 %[[IDXPROM]]
// CHECK-NEXT:    %[[TMP5:.+]] = load float, ptr %[[ARRAYIDX]], align 4
// CHECK-NEXT:    %[[TMP6:.+]] = load ptr, ptr %[[C_ADDR]], align 8
// CHECK-NEXT:    %[[TMP7:.+]] = load i32, ptr %[[I]], align 4
// CHECK-NEXT:    %[[IDXPROM2:.+]] = sext i32 %[[TMP7]] to i64
// CHECK-NEXT:    %[[ARRAYIDX3:.+]] = getelementptr inbounds float, ptr %[[TMP6]], i64 %[[IDXPROM2]]
// CHECK-NEXT:    %[[TMP8:.+]] = load float, ptr %[[ARRAYIDX3]], align 4
// CHECK-NEXT:    %[[MUL:.+]] = fmul float %[[TMP5]], %[[TMP8]]
// CHECK-NEXT:    %[[TMP9:.+]] = load ptr, ptr %[[D_ADDR]], align 8
// CHECK-NEXT:    %[[TMP10:.+]] = load i32, ptr %[[I]], align 4
// CHECK-NEXT:    %[[IDXPROM4:.+]] = sext i32 %[[TMP10]] to i64
// CHECK-NEXT:    %[[ARRAYIDX5:.+]] = getelementptr inbounds float, ptr %[[TMP9]], i64 %[[IDXPROM4]]
// CHECK-NEXT:    %[[TMP11:.+]] = load float, ptr %[[ARRAYIDX5]], align 4
// CHECK-NEXT:    %[[MUL6:.+]] = fmul float %[[MUL]], %[[TMP11]]
// CHECK-NEXT:    %[[TMP12:.+]] = load ptr, ptr %[[A_ADDR]], align 8
// CHECK-NEXT:    %[[TMP13:.+]] = load i32, ptr %[[I]], align 4
// CHECK-NEXT:    %[[IDXPROM7:.+]] = sext i32 %[[TMP13]] to i64
// CHECK-NEXT:    %[[ARRAYIDX8:.+]] = getelementptr inbounds float, ptr %[[TMP12]], i64 %[[IDXPROM7]]
// CHECK-NEXT:    store float %[[MUL6]], ptr %[[ARRAYIDX8]], align 4
// CHECK-NEXT:    br label %[[OMP_LOOP_INC]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_INC]]:
// CHECK-NEXT:    %[[OMP_LOOP_NEXT]] = add nuw i32 %[[OMP_LOOP_IV]], 1
// CHECK-NEXT:    br label %[[OMP_LOOP_HEADER]], !llvm.loop ![[LOOP3:[0-9]+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_EXIT]]:
// CHECK-NEXT:    br label %[[OMP_LOOP_AFTER:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_AFTER]]:
// CHECK-NEXT:    ret void
// CHECK-NEXT:  }
void unroll_partial_factor(float *a, float *b, float *c, float *d) {
#pragma omp unroll partial(3)
  for (int i = 0; i < 2; i++) {
    a[i] = b[i] * c[i] * d[i];
  }
}

#endif // HEADER

// CHECK-LABEL: define {{.*}}@__captured_stmt(
// CHECK-NEXT:  [[ENTRY:.*]]:
// CHECK-NEXT:    %[[DISTANCE_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[__CONTEXT_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[DOTSTART:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTSTOP:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTSTEP:.+]] = alloca i32, align 4
// CHECK-NEXT:    store ptr %[[DISTANCE:.+]], ptr %[[DISTANCE_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[__CONTEXT:.+]], ptr %[[__CONTEXT_ADDR]], align 8
// CHECK-NEXT:    %[[TMP0:.+]] = load ptr, ptr %[[__CONTEXT_ADDR]], align 8
// CHECK-NEXT:    %[[TMP1:.+]] = getelementptr inbounds %struct.anon, ptr %[[TMP0]], i32 0, i32 0
// CHECK-NEXT:    %[[TMP2:.+]] = load ptr, ptr %[[TMP1]], align 8
// CHECK-NEXT:    %[[TMP3:.+]] = load i32, ptr %[[TMP2]], align 4
// CHECK-NEXT:    store i32 %[[TMP3]], ptr %[[DOTSTART]], align 4
// CHECK-NEXT:    store i32 2, ptr %[[DOTSTOP]], align 4
// CHECK-NEXT:    store i32 1, ptr %[[DOTSTEP]], align 4
// CHECK-NEXT:    %[[TMP4:.+]] = load i32, ptr %[[DOTSTART]], align 4
// CHECK-NEXT:    %[[TMP5:.+]] = load i32, ptr %[[DOTSTOP]], align 4
// CHECK-NEXT:    %[[CMP:.+]] = icmp slt i32 %[[TMP4]], %[[TMP5]]
// CHECK-NEXT:    br i1 %[[CMP]], label %[[COND_TRUE:.+]], label %[[COND_FALSE:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_TRUE]]:
// CHECK-NEXT:    %[[TMP6:.+]] = load i32, ptr %[[DOTSTOP]], align 4
// CHECK-NEXT:    %[[TMP7:.+]] = load i32, ptr %[[DOTSTART]], align 4
// CHECK-NEXT:    %[[SUB:.+]] = sub nsw i32 %[[TMP6]], %[[TMP7]]
// CHECK-NEXT:    %[[TMP8:.+]] = load i32, ptr %[[DOTSTEP]], align 4
// CHECK-NEXT:    %[[SUB1:.+]] = sub i32 %[[TMP8]], 1
// CHECK-NEXT:    %[[ADD:.+]] = add i32 %[[SUB]], %[[SUB1]]
// CHECK-NEXT:    %[[TMP9:.+]] = load i32, ptr %[[DOTSTEP]], align 4
// CHECK-NEXT:    %[[DIV:.+]] = udiv i32 %[[ADD]], %[[TMP9]]
// CHECK-NEXT:    br label %[[COND_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_FALSE]]:
// CHECK-NEXT:    br label %[[COND_END]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_END]]:
// CHECK-NEXT:    %[[COND:.+]] = phi i32 [ %[[DIV]], %[[COND_TRUE]] ], [ 0, %[[COND_FALSE]] ]
// CHECK-NEXT:    %[[TMP10:.+]] = load ptr, ptr %[[DISTANCE_ADDR]], align 8
// CHECK-NEXT:    store i32 %[[COND]], ptr %[[TMP10]], align 4
// CHECK-NEXT:    ret void
// CHECK-NEXT:  }


// CHECK-LABEL: define {{.*}}@__captured_stmt.1(
// CHECK-NEXT:  [[ENTRY:.*]]:
// CHECK-NEXT:    %[[LOOPVAR_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[LOGICAL_ADDR:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[__CONTEXT_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr %[[LOOPVAR:.+]], ptr %[[LOOPVAR_ADDR]], align 8
// CHECK-NEXT:    store i32 %[[LOGICAL:.+]], ptr %[[LOGICAL_ADDR]], align 4
// CHECK-NEXT:    store ptr %[[__CONTEXT:.+]], ptr %[[__CONTEXT_ADDR]], align 8
// CHECK-NEXT:    %[[TMP0:.+]] = load ptr, ptr %[[__CONTEXT_ADDR]], align 8
// CHECK-NEXT:    %[[TMP1:.+]] = getelementptr inbounds %struct.anon.0, ptr %[[TMP0]], i32 0, i32 0
// CHECK-NEXT:    %[[TMP2:.+]] = load i32, ptr %[[TMP1]], align 4
// CHECK-NEXT:    %[[TMP3:.+]] = load i32, ptr %[[LOGICAL_ADDR]], align 4
// CHECK-NEXT:    %[[MUL:.+]] = mul i32 1, %[[TMP3]]
// CHECK-NEXT:    %[[ADD:.+]] = add i32 %[[TMP2]], %[[MUL]]
// CHECK-NEXT:    %[[TMP4:.+]] = load ptr, ptr %[[LOOPVAR_ADDR]], align 8
// CHECK-NEXT:    store i32 %[[ADD]], ptr %[[TMP4]], align 4
// CHECK-NEXT:    ret void
// CHECK-NEXT:  }


// CHECK: ![[META0:[0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: ![[META1:[0-9]+]] = !{i32 7, !"openmp", i32 51}
// CHECK: ![[META2:[0-9]+]] =
// CHECK: ![[LOOP3]] = distinct !{![[LOOP3]], ![[LOOPPROP4:[0-9]+]], ![[LOOPPROP5:[0-9]+]]}
// CHECK: ![[LOOPPROP4]] = !{!"llvm.loop.unroll.enable"}
// CHECK: ![[LOOPPROP5]] = !{!"llvm.loop.unroll.count", i32 3}
