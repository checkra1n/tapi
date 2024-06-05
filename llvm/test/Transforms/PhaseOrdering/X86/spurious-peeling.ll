; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -passes="default<O1>" -S < %s | FileCheck --check-prefixes=O1 %s
; RUN: opt -passes="default<O2>" -S < %s | FileCheck --check-prefixes=O23 %s
; RUN: opt -passes="default<O3>" -S < %s | FileCheck --check-prefixes=O23 %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.FloatVecPair = type { %class.HomemadeVector, %class.HomemadeVector }
%class.HomemadeVector = type <{ %class.HomemadeVector.0*, i32, [4 x i8] }>
%class.HomemadeVector.0 = type <{ float*, i32, [4 x i8] }>

$_ZN12FloatVecPair6vecIncEv = comdat any

define dso_local void @_Z13vecIncFromPtrP12FloatVecPair(%class.FloatVecPair* %FVP) {
; O1-LABEL: define {{[^@]+}}@_Z13vecIncFromPtrP12FloatVecPair
; O1-SAME: (%class.FloatVecPair* nocapture readonly [[FVP:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; O1-NEXT:  entry:
; O1-NEXT:    [[BASE_I_I:%.*]] = getelementptr inbounds [[CLASS_FLOATVECPAIR:%.*]], %class.FloatVecPair* [[FVP]], i64 0, i32 1, i32 0
; O1-NEXT:    [[TMP0:%.*]] = load %class.HomemadeVector.0*, %class.HomemadeVector.0** [[BASE_I_I]], align 8, !tbaa [[TBAA0:![0-9]+]]
; O1-NEXT:    [[SIZE4_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0:%.*]], %class.HomemadeVector.0* [[TMP0]], i64 undef, i32 1
; O1-NEXT:    [[TMP1:%.*]] = load i32, i32* [[SIZE4_I]], align 8, !tbaa [[TBAA6:![0-9]+]]
; O1-NEXT:    [[CMP510_NOT_I:%.*]] = icmp eq i32 [[TMP1]], 0
; O1-NEXT:    br i1 [[CMP510_NOT_I]], label [[_ZN12FLOATVECPAIR6VECINCEV_EXIT:%.*]], label [[FOR_BODY7_LR_PH_I:%.*]]
; O1:       for.body7.lr.ph.i:
; O1-NEXT:    [[BASE_I4_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0]], %class.HomemadeVector.0* [[TMP0]], i64 undef, i32 0
; O1-NEXT:    [[TMP2:%.*]] = load float*, float** [[BASE_I4_I]], align 8, !tbaa [[TBAA8:![0-9]+]]
; O1-NEXT:    [[ARRAYIDX_I5_I:%.*]] = getelementptr inbounds float, float* [[TMP2]], i64 undef
; O1-NEXT:    [[BASE_I6_I:%.*]] = getelementptr inbounds [[CLASS_FLOATVECPAIR]], %class.FloatVecPair* [[FVP]], i64 0, i32 0, i32 0
; O1-NEXT:    [[TMP3:%.*]] = load %class.HomemadeVector.0*, %class.HomemadeVector.0** [[BASE_I6_I]], align 8, !tbaa [[TBAA0]]
; O1-NEXT:    [[BASE_I8_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0]], %class.HomemadeVector.0* [[TMP3]], i64 undef, i32 0
; O1-NEXT:    [[TMP4:%.*]] = load float*, float** [[BASE_I8_I]], align 8, !tbaa [[TBAA8]]
; O1-NEXT:    [[ARRAYIDX_I9_I:%.*]] = getelementptr inbounds float, float* [[TMP4]], i64 undef
; O1-NEXT:    br label [[FOR_BODY7_I:%.*]]
; O1:       for.body7.i:
; O1-NEXT:    [[J_011_I:%.*]] = phi i32 [ 0, [[FOR_BODY7_LR_PH_I]] ], [ [[INC_I:%.*]], [[FOR_BODY7_I]] ]
; O1-NEXT:    [[TMP5:%.*]] = load float, float* [[ARRAYIDX_I5_I]], align 4, !tbaa [[TBAA9:![0-9]+]]
; O1-NEXT:    [[TMP6:%.*]] = load float, float* [[ARRAYIDX_I9_I]], align 4, !tbaa [[TBAA9]]
; O1-NEXT:    [[ADD_I:%.*]] = fadd float [[TMP5]], [[TMP6]]
; O1-NEXT:    store float [[ADD_I]], float* [[ARRAYIDX_I9_I]], align 4, !tbaa [[TBAA9]]
; O1-NEXT:    [[INC_I]] = add nuw i32 [[J_011_I]], 1
; O1-NEXT:    [[EXITCOND_NOT_I:%.*]] = icmp eq i32 [[INC_I]], [[TMP1]]
; O1-NEXT:    br i1 [[EXITCOND_NOT_I]], label [[_ZN12FLOATVECPAIR6VECINCEV_EXIT]], label [[FOR_BODY7_I]], !llvm.loop [[LOOP11:![0-9]+]]
; O1:       _ZN12FloatVecPair6vecIncEv.exit:
; O1-NEXT:    ret void
;
; O23-LABEL: define {{[^@]+}}@_Z13vecIncFromPtrP12FloatVecPair
; O23-SAME: (%class.FloatVecPair* nocapture readonly [[FVP:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; O23-NEXT:  entry:
; O23-NEXT:    [[BASE_I_I:%.*]] = getelementptr inbounds [[CLASS_FLOATVECPAIR:%.*]], %class.FloatVecPair* [[FVP]], i64 0, i32 1, i32 0
; O23-NEXT:    [[TMP0:%.*]] = load %class.HomemadeVector.0*, %class.HomemadeVector.0** [[BASE_I_I]], align 8, !tbaa [[TBAA0:![0-9]+]]
; O23-NEXT:    [[SIZE4_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0:%.*]], %class.HomemadeVector.0* [[TMP0]], i64 undef, i32 1
; O23-NEXT:    [[TMP1:%.*]] = load i32, i32* [[SIZE4_I]], align 8, !tbaa [[TBAA6:![0-9]+]]
; O23-NEXT:    [[CMP510_NOT_I:%.*]] = icmp eq i32 [[TMP1]], 0
; O23-NEXT:    br i1 [[CMP510_NOT_I]], label [[_ZN12FLOATVECPAIR6VECINCEV_EXIT:%.*]], label [[FOR_BODY7_LR_PH_I:%.*]]
; O23:       for.body7.lr.ph.i:
; O23-NEXT:    [[BASE_I4_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0]], %class.HomemadeVector.0* [[TMP0]], i64 undef, i32 0
; O23-NEXT:    [[TMP2:%.*]] = load float*, float** [[BASE_I4_I]], align 8, !tbaa [[TBAA8:![0-9]+]]
; O23-NEXT:    [[ARRAYIDX_I5_I:%.*]] = getelementptr inbounds float, float* [[TMP2]], i64 undef
; O23-NEXT:    [[BASE_I6_I:%.*]] = getelementptr inbounds [[CLASS_FLOATVECPAIR]], %class.FloatVecPair* [[FVP]], i64 0, i32 0, i32 0
; O23-NEXT:    [[TMP3:%.*]] = load %class.HomemadeVector.0*, %class.HomemadeVector.0** [[BASE_I6_I]], align 8, !tbaa [[TBAA0]]
; O23-NEXT:    [[BASE_I8_I:%.*]] = getelementptr inbounds [[CLASS_HOMEMADEVECTOR_0]], %class.HomemadeVector.0* [[TMP3]], i64 undef, i32 0
; O23-NEXT:    [[TMP4:%.*]] = load float*, float** [[BASE_I8_I]], align 8, !tbaa [[TBAA8]]
; O23-NEXT:    [[ARRAYIDX_I9_I:%.*]] = getelementptr inbounds float, float* [[TMP4]], i64 undef
; O23-NEXT:    [[DOTPRE_I:%.*]] = load float, float* [[ARRAYIDX_I9_I]], align 4, !tbaa [[TBAA9:![0-9]+]]
; O23-NEXT:    br label [[FOR_BODY7_I:%.*]]
; O23:       for.body7.i:
; O23-NEXT:    [[TMP5:%.*]] = phi float [ [[DOTPRE_I]], [[FOR_BODY7_LR_PH_I]] ], [ [[ADD_I:%.*]], [[FOR_BODY7_I]] ]
; O23-NEXT:    [[J_011_I:%.*]] = phi i32 [ 0, [[FOR_BODY7_LR_PH_I]] ], [ [[INC_I:%.*]], [[FOR_BODY7_I]] ]
; O23-NEXT:    [[TMP6:%.*]] = load float, float* [[ARRAYIDX_I5_I]], align 4, !tbaa [[TBAA9]]
; O23-NEXT:    [[ADD_I]] = fadd float [[TMP5]], [[TMP6]]
; O23-NEXT:    store float [[ADD_I]], float* [[ARRAYIDX_I9_I]], align 4, !tbaa [[TBAA9]]
; O23-NEXT:    [[INC_I]] = add nuw i32 [[J_011_I]], 1
; O23-NEXT:    [[EXITCOND_NOT_I:%.*]] = icmp eq i32 [[INC_I]], [[TMP1]]
; O23-NEXT:    br i1 [[EXITCOND_NOT_I]], label [[_ZN12FLOATVECPAIR6VECINCEV_EXIT]], label [[FOR_BODY7_I]], !llvm.loop [[LOOP11:![0-9]+]]
; O23:       _ZN12FloatVecPair6vecIncEv.exit:
; O23-NEXT:    ret void
;
entry:
  %FVP.addr = alloca %class.FloatVecPair*, align 8
  store %class.FloatVecPair* %FVP, %class.FloatVecPair** %FVP.addr, align 8, !tbaa !0
  %0 = load %class.FloatVecPair*, %class.FloatVecPair** %FVP.addr, align 8, !tbaa !0
  call void @_ZN12FloatVecPair6vecIncEv(%class.FloatVecPair* %0)
  ret void
}

define linkonce_odr dso_local void @_ZN12FloatVecPair6vecIncEv(%class.FloatVecPair* %this) comdat align 2 {
entry:
  %this.addr = alloca %class.FloatVecPair*, align 8
  %j = alloca i32, align 4
  store %class.FloatVecPair* %this, %class.FloatVecPair** %this.addr, align 8, !tbaa !0
  %this1 = load %class.FloatVecPair*, %class.FloatVecPair** %this.addr, align 8
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4, !tbaa !4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %0 = load i32, i32* %j, align 4, !tbaa !4
  %Vsrc23 = getelementptr inbounds %class.FloatVecPair, %class.FloatVecPair* %this1, i32 0, i32 1
  %call = call %class.HomemadeVector.0* @_ZN14HomemadeVectorIS_IfLj8EELj8EEixEj(%class.HomemadeVector* %Vsrc23)
  %size4 = getelementptr inbounds %class.HomemadeVector.0, %class.HomemadeVector.0* %call, i32 0, i32 1
  %1 = load i32, i32* %size4, align 8, !tbaa !6
  %cmp5 = icmp ult i32 %0, %1
  br i1 %cmp5, label %for.body7, label %for.cond.cleanup6

for.cond.cleanup6:                                ; preds = %for.cond2
  ret void

for.body7:                                        ; preds = %for.cond2
  %Vsrc28 = getelementptr inbounds %class.FloatVecPair, %class.FloatVecPair* %this1, i32 0, i32 1
  %call9 = call %class.HomemadeVector.0* @_ZN14HomemadeVectorIS_IfLj8EELj8EEixEj(%class.HomemadeVector* %Vsrc28)
  %call10 = call float* @_ZN14HomemadeVectorIfLj8EEixEj(%class.HomemadeVector.0* %call9)
  %2 = load float, float* %call10, align 4, !tbaa !8
  %Vsrcdst = getelementptr inbounds %class.FloatVecPair, %class.FloatVecPair* %this1, i32 0, i32 0
  %call11 = call %class.HomemadeVector.0* @_ZN14HomemadeVectorIS_IfLj8EELj8EEixEj(%class.HomemadeVector* %Vsrcdst)
  %call12 = call float* @_ZN14HomemadeVectorIfLj8EEixEj(%class.HomemadeVector.0* %call11)
  %3 = load float, float* %call12, align 4, !tbaa !8
  %add = fadd float %3, %2
  store float %add, float* %call12, align 4, !tbaa !8
  br label %for.inc

for.inc:                                          ; preds = %for.body7
  %4 = load i32, i32* %j, align 4, !tbaa !4
  %inc = add i32 %4, 1
  store i32 %inc, i32* %j, align 4, !tbaa !4
  br label %for.cond2, !llvm.loop !10
}

define linkonce_odr dso_local %class.HomemadeVector.0* @_ZN14HomemadeVectorIS_IfLj8EELj8EEixEj(%class.HomemadeVector* %this) align 2 {
entry:
  %this.addr = alloca %class.HomemadeVector*, align 8
  store %class.HomemadeVector* %this, %class.HomemadeVector** %this.addr, align 8, !tbaa !0
  %this1 = load %class.HomemadeVector*, %class.HomemadeVector** %this.addr, align 8
  %base = getelementptr inbounds %class.HomemadeVector, %class.HomemadeVector* %this1, i32 0, i32 0
  %0 = load %class.HomemadeVector.0*, %class.HomemadeVector.0** %base, align 8, !tbaa !12
  %1 = bitcast %class.HomemadeVector.0* %0 to i8*
  %2 = bitcast i8* %1 to %class.HomemadeVector.0*
  %arrayidx = getelementptr inbounds %class.HomemadeVector.0, %class.HomemadeVector.0* %2, i64 undef
  ret %class.HomemadeVector.0* %arrayidx
}

define linkonce_odr dso_local float* @_ZN14HomemadeVectorIfLj8EEixEj(%class.HomemadeVector.0* %this) align 2 {
entry:
  %this.addr = alloca %class.HomemadeVector.0*, align 8
  store %class.HomemadeVector.0* %this, %class.HomemadeVector.0** %this.addr, align 8, !tbaa !0
  %this1 = load %class.HomemadeVector.0*, %class.HomemadeVector.0** %this.addr, align 8
  %base = getelementptr inbounds %class.HomemadeVector.0, %class.HomemadeVector.0* %this1, i32 0, i32 0
  %0 = load float*, float** %base, align 8, !tbaa !14
  %1 = bitcast float* %0 to i8*
  %2 = bitcast i8* %1 to float*
  %arrayidx = getelementptr inbounds float, float* %2, i64 undef
  ret float* %arrayidx
}

!0 = !{!1, !1, i64 0}
!1 = !{!"any pointer", !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !2, i64 0}
!6 = !{!7, !5, i64 8}
!7 = !{!"_ZTS14HomemadeVectorIfLj8EE", !1, i64 0, !5, i64 8}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !2, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!13, !1, i64 0}
!13 = !{!"_ZTS14HomemadeVectorIS_IfLj8EELj8EE", !1, i64 0, !5, i64 8}
!14 = !{!7, !1, i64 0}
