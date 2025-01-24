; NOTE: Assertions have been autogenerated by utils/update_test_checks.py

; RUN: opt -passes=lower-matrix-intrinsics -matrix-default-layout=row-major -S < %s | FileCheck --check-prefix=RM %s

; Check row-major code generation for loads, stores, binary operators (fadd/fsub) and multiply.
; %a.ptr is a pointer to a 2x3 matrix, %b.ptr to a 3x2 matrix and %c.ptr to a 2x2 matrix.
; Load, store and binary operators on %a should operate on 3 element vectors and on 2 element vectors for %b.
define void @multiply_sub_add_2x3_3x2(ptr %a.ptr, ptr %b.ptr, ptr %c.ptr) {
; RM-LABEL: @multiply_sub_add_2x3_3x2(
; RM-NEXT:  entry:
; RM-NEXT:    [[COL_LOAD:%.*]] = load <3 x double>, ptr [[A_PTR:%.*]], align 8
; RM-NEXT:    [[VEC_GEP:%.*]] = getelementptr double, ptr [[A_PTR]], i64 3
; RM-NEXT:    [[COL_LOAD1:%.*]] = load <3 x double>, ptr [[VEC_GEP]], align 8
; RM-NEXT:    [[COL_LOAD2:%.*]] = load <2 x double>, ptr [[B_PTR:%.*]], align 8
; RM-NEXT:    [[VEC_GEP3:%.*]] = getelementptr double, ptr [[B_PTR]], i64 2
; RM-NEXT:    [[COL_LOAD4:%.*]] = load <2 x double>, ptr [[VEC_GEP3]], align 8
; RM-NEXT:    [[VEC_GEP5:%.*]] = getelementptr double, ptr [[B_PTR]], i64 4
; RM-NEXT:    [[COL_LOAD6:%.*]] = load <2 x double>, ptr [[VEC_GEP5]], align 8
; RM-NEXT:    [[TMP0:%.*]] = fadd <3 x double> [[COL_LOAD]], [[COL_LOAD]]
; RM-NEXT:    [[TMP1:%.*]] = fadd <3 x double> [[COL_LOAD1]], [[COL_LOAD1]]
; RM-NEXT:    store <3 x double> [[TMP0]], ptr [[A_PTR]], align 8
; RM-NEXT:    [[VEC_GEP7:%.*]] = getelementptr double, ptr [[A_PTR]], i64 3
; RM-NEXT:    store <3 x double> [[TMP1]], ptr [[VEC_GEP7]], align 8
; RM-NEXT:    [[TMP2:%.*]] = fsub <2 x double> [[COL_LOAD2]], <double 1.000000e+00, double 1.000000e+00>
; RM-NEXT:    [[TMP3:%.*]] = fsub <2 x double> [[COL_LOAD4]], <double 1.000000e+00, double 1.000000e+00>
; RM-NEXT:    [[TMP4:%.*]] = fsub <2 x double> [[COL_LOAD6]], <double 1.000000e+00, double 1.000000e+00>
; RM-NEXT:    store <2 x double> [[TMP2]], ptr [[B_PTR]], align 8
; RM-NEXT:    [[VEC_GEP8:%.*]] = getelementptr double, ptr [[B_PTR]], i64 2
; RM-NEXT:    store <2 x double> [[TMP3]], ptr [[VEC_GEP8]], align 8
; RM-NEXT:    [[VEC_GEP9:%.*]] = getelementptr double, ptr [[B_PTR]], i64 4
; RM-NEXT:    store <2 x double> [[TMP4]], ptr [[VEC_GEP9]], align 8
; RM-NEXT:    [[BLOCK:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP5:%.*]] = extractelement <3 x double> [[TMP0]], i64 0
; RM-NEXT:    [[SPLAT_SPLATINSERT:%.*]] = insertelement <1 x double> poison, double [[TMP5]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP6:%.*]] = fmul <1 x double> [[SPLAT_SPLAT]], [[BLOCK]]
; RM-NEXT:    [[BLOCK10:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP7:%.*]] = extractelement <3 x double> [[TMP0]], i64 1
; RM-NEXT:    [[SPLAT_SPLATINSERT11:%.*]] = insertelement <1 x double> poison, double [[TMP7]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT12:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT11]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP8:%.*]] = fmul <1 x double> [[SPLAT_SPLAT12]], [[BLOCK10]]
; RM-NEXT:    [[TMP9:%.*]] = fadd <1 x double> [[TMP6]], [[TMP8]]
; RM-NEXT:    [[BLOCK13:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP10:%.*]] = extractelement <3 x double> [[TMP0]], i64 2
; RM-NEXT:    [[SPLAT_SPLATINSERT14:%.*]] = insertelement <1 x double> poison, double [[TMP10]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT15:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT14]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP11:%.*]] = fmul <1 x double> [[SPLAT_SPLAT15]], [[BLOCK13]]
; RM-NEXT:    [[TMP12:%.*]] = fadd <1 x double> [[TMP9]], [[TMP11]]
; RM-NEXT:    [[TMP13:%.*]] = shufflevector <1 x double> [[TMP12]], <1 x double> poison, <2 x i32> <i32 0, i32 poison>
; RM-NEXT:    [[TMP14:%.*]] = shufflevector <2 x double> poison, <2 x double> [[TMP13]], <2 x i32> <i32 2, i32 1>
; RM-NEXT:    [[BLOCK16:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP15:%.*]] = extractelement <3 x double> [[TMP0]], i64 0
; RM-NEXT:    [[SPLAT_SPLATINSERT17:%.*]] = insertelement <1 x double> poison, double [[TMP15]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT18:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT17]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP16:%.*]] = fmul <1 x double> [[SPLAT_SPLAT18]], [[BLOCK16]]
; RM-NEXT:    [[BLOCK19:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP17:%.*]] = extractelement <3 x double> [[TMP0]], i64 1
; RM-NEXT:    [[SPLAT_SPLATINSERT20:%.*]] = insertelement <1 x double> poison, double [[TMP17]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT21:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT20]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP18:%.*]] = fmul <1 x double> [[SPLAT_SPLAT21]], [[BLOCK19]]
; RM-NEXT:    [[TMP19:%.*]] = fadd <1 x double> [[TMP16]], [[TMP18]]
; RM-NEXT:    [[BLOCK22:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP20:%.*]] = extractelement <3 x double> [[TMP0]], i64 2
; RM-NEXT:    [[SPLAT_SPLATINSERT23:%.*]] = insertelement <1 x double> poison, double [[TMP20]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT24:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT23]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP21:%.*]] = fmul <1 x double> [[SPLAT_SPLAT24]], [[BLOCK22]]
; RM-NEXT:    [[TMP22:%.*]] = fadd <1 x double> [[TMP19]], [[TMP21]]
; RM-NEXT:    [[TMP23:%.*]] = shufflevector <1 x double> [[TMP22]], <1 x double> poison, <2 x i32> <i32 0, i32 poison>
; RM-NEXT:    [[TMP24:%.*]] = shufflevector <2 x double> [[TMP14]], <2 x double> [[TMP23]], <2 x i32> <i32 0, i32 2>
; RM-NEXT:    [[BLOCK25:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP25:%.*]] = extractelement <3 x double> [[TMP1]], i64 0
; RM-NEXT:    [[SPLAT_SPLATINSERT26:%.*]] = insertelement <1 x double> poison, double [[TMP25]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT27:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT26]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP26:%.*]] = fmul <1 x double> [[SPLAT_SPLAT27]], [[BLOCK25]]
; RM-NEXT:    [[BLOCK28:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP27:%.*]] = extractelement <3 x double> [[TMP1]], i64 1
; RM-NEXT:    [[SPLAT_SPLATINSERT29:%.*]] = insertelement <1 x double> poison, double [[TMP27]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT30:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT29]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP28:%.*]] = fmul <1 x double> [[SPLAT_SPLAT30]], [[BLOCK28]]
; RM-NEXT:    [[TMP29:%.*]] = fadd <1 x double> [[TMP26]], [[TMP28]]
; RM-NEXT:    [[BLOCK31:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP30:%.*]] = extractelement <3 x double> [[TMP1]], i64 2
; RM-NEXT:    [[SPLAT_SPLATINSERT32:%.*]] = insertelement <1 x double> poison, double [[TMP30]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT33:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT32]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP31:%.*]] = fmul <1 x double> [[SPLAT_SPLAT33]], [[BLOCK31]]
; RM-NEXT:    [[TMP32:%.*]] = fadd <1 x double> [[TMP29]], [[TMP31]]
; RM-NEXT:    [[TMP33:%.*]] = shufflevector <1 x double> [[TMP32]], <1 x double> poison, <2 x i32> <i32 0, i32 poison>
; RM-NEXT:    [[TMP34:%.*]] = shufflevector <2 x double> poison, <2 x double> [[TMP33]], <2 x i32> <i32 2, i32 1>
; RM-NEXT:    [[BLOCK34:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP35:%.*]] = extractelement <3 x double> [[TMP1]], i64 0
; RM-NEXT:    [[SPLAT_SPLATINSERT35:%.*]] = insertelement <1 x double> poison, double [[TMP35]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT36:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT35]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP36:%.*]] = fmul <1 x double> [[SPLAT_SPLAT36]], [[BLOCK34]]
; RM-NEXT:    [[BLOCK37:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP37:%.*]] = extractelement <3 x double> [[TMP1]], i64 1
; RM-NEXT:    [[SPLAT_SPLATINSERT38:%.*]] = insertelement <1 x double> poison, double [[TMP37]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT39:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT38]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP38:%.*]] = fmul <1 x double> [[SPLAT_SPLAT39]], [[BLOCK37]]
; RM-NEXT:    [[TMP39:%.*]] = fadd <1 x double> [[TMP36]], [[TMP38]]
; RM-NEXT:    [[BLOCK40:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> poison, <1 x i32> <i32 1>
; RM-NEXT:    [[TMP40:%.*]] = extractelement <3 x double> [[TMP1]], i64 2
; RM-NEXT:    [[SPLAT_SPLATINSERT41:%.*]] = insertelement <1 x double> poison, double [[TMP40]], i64 0
; RM-NEXT:    [[SPLAT_SPLAT42:%.*]] = shufflevector <1 x double> [[SPLAT_SPLATINSERT41]], <1 x double> poison, <1 x i32> zeroinitializer
; RM-NEXT:    [[TMP41:%.*]] = fmul <1 x double> [[SPLAT_SPLAT42]], [[BLOCK40]]
; RM-NEXT:    [[TMP42:%.*]] = fadd <1 x double> [[TMP39]], [[TMP41]]
; RM-NEXT:    [[TMP43:%.*]] = shufflevector <1 x double> [[TMP42]], <1 x double> poison, <2 x i32> <i32 0, i32 poison>
; RM-NEXT:    [[TMP44:%.*]] = shufflevector <2 x double> [[TMP34]], <2 x double> [[TMP43]], <2 x i32> <i32 0, i32 2>
; RM-NEXT:    [[COL_LOAD43:%.*]] = load <2 x double>, ptr [[C_PTR:%.*]], align 8
; RM-NEXT:    [[VEC_GEP44:%.*]] = getelementptr double, ptr [[C_PTR]], i64 2
; RM-NEXT:    [[COL_LOAD45:%.*]] = load <2 x double>, ptr [[VEC_GEP44]], align 8
; RM-NEXT:    [[TMP45:%.*]] = fsub <2 x double> [[COL_LOAD43]], [[TMP24]]
; RM-NEXT:    [[TMP46:%.*]] = fsub <2 x double> [[COL_LOAD45]], [[TMP44]]
; RM-NEXT:    store <2 x double> [[TMP45]], ptr [[C_PTR]], align 8
; RM-NEXT:    [[VEC_GEP46:%.*]] = getelementptr double, ptr [[C_PTR]], i64 2
; RM-NEXT:    store <2 x double> [[TMP46]], ptr [[VEC_GEP46]], align 8
; RM-NEXT:    ret void
;
entry:
  %a = load <6 x double>, ptr %a.ptr, align 8
  %b = load <6 x double>, ptr %b.ptr, align 8
  %add = fadd <6 x double> %a, %a
  store <6 x double> %add, ptr %a.ptr, align 8
  %sub = fsub <6 x double> %b, <double 1.0, double 1.0, double 1.0, double 1.0, double 1.0, double 1.0>
  store <6 x double> %sub, ptr %b.ptr, align 8
  %mul = call <4 x double> @llvm.matrix.multiply.v4f64.v6f64.v6f64(<6 x double> %add, <6 x double> %sub, i32 2, i32 3, i32 2)
  %c = load <4 x double>, ptr %c.ptr, align 8
  %res = fsub <4 x double> %c, %mul
  store <4 x double> %res, ptr %c.ptr, align 8
  ret void
}

declare <4 x double> @llvm.matrix.multiply.v4f64.v6f64.v6f64(<6 x double>, <6 x double>, i32, i32, i32)
