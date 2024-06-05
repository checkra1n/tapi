; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=aarch64 -type-promotion -verify -dce -S %s -o - | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

@_ZN4llvmL20trailingBytesForUTF8E = internal unnamed_addr constant [256 x i8] c"\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\04\04\04\04\05\05\05\05", align 1
@_ZN4llvmL15offsetsFromUTF8E = internal unnamed_addr constant [6 x i32] [i32 0, i32 12416, i32 925824, i32 63447168, i32 -100130688, i32 -2113396608], align 4

define dso_local noundef i32 @_ZN4llvm18ConvertUTF8toUTF16EPPKhS1_PPtS3_NS_15ConversionFlagsE(i8** nocapture noundef %sourceStart, i8* noundef %sourceEnd, i16** nocapture noundef %targetStart, i16* noundef readnone %targetEnd, i32 noundef %flags) local_unnamed_addr {
; CHECK-LABEL: @_ZN4llvm18ConvertUTF8toUTF16EPPKhS1_PPtS3_NS_15ConversionFlagsE(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = load i8*, i8** [[SOURCESTART:%.*]], align 8
; CHECK-NEXT:    [[I1:%.*]] = load i16*, i16** [[TARGETSTART:%.*]], align 8
; CHECK-NEXT:    [[SUB_PTR_LHS_CAST:%.*]] = ptrtoint i8* [[SOURCEEND:%.*]] to i64
; CHECK-NEXT:    [[CMP61:%.*]] = icmp eq i32 [[FLAGS:%.*]], 0
; CHECK-NEXT:    [[CMP183:%.*]] = icmp ult i8* [[I]], [[SOURCEEND]]
; CHECK-NEXT:    br i1 [[CMP183]], label [[WHILE_BODY:%.*]], label [[WHILE_END:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[TARGET_0186:%.*]] = phi i16* [ [[TARGET_2:%.*]], [[CLEANUP:%.*]] ], [ [[I1]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SOURCE_0184:%.*]] = phi i8* [ [[SOURCE_6:%.*]], [[CLEANUP]] ], [ [[I]], [[ENTRY]] ]
; CHECK-NEXT:    [[I2:%.*]] = load i8, i8* [[SOURCE_0184]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = zext i8 [[I2]] to i32
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[TMP0]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [256 x i8], [256 x i8]* @_ZN4llvmL20trailingBytesForUTF8E, i64 0, i64 [[IDXPROM]]
; CHECK-NEXT:    [[I3:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[CONV1:%.*]] = zext i8 [[I3]] to i64
; CHECK-NEXT:    [[SUB_PTR_RHS_CAST:%.*]] = ptrtoint i8* [[SOURCE_0184]] to i64
; CHECK-NEXT:    [[SUB_PTR_SUB:%.*]] = sub i64 [[SUB_PTR_LHS_CAST]], [[SUB_PTR_RHS_CAST]]
; CHECK-NEXT:    [[CMP2_NOT:%.*]] = icmp sgt i64 [[SUB_PTR_SUB]], [[CONV1]]
; CHECK-NEXT:    br i1 [[CMP2_NOT]], label [[IF_END:%.*]], label [[WHILE_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i64 [[CONV1]], 1
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_0184]], i64 [[ADD]]
; CHECK-NEXT:    switch i8 [[I3]], label [[WHILE_END]] [
; CHECK-NEXT:    i8 3, label [[SW_BB_I:%.*]]
; CHECK-NEXT:    i8 2, label [[SW_BB3_I:%.*]]
; CHECK-NEXT:    i8 1, label [[SW_BB12_I:%.*]]
; CHECK-NEXT:    i8 0, label [[SW_BB47_I:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb.i:
; CHECK-NEXT:    [[INCDEC_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_0184]], i64 [[CONV1]]
; CHECK-NEXT:    [[I4:%.*]] = load i8, i8* [[INCDEC_PTR_I]], align 1
; CHECK-NEXT:    [[I5:%.*]] = icmp sgt i8 [[I4]], -65
; CHECK-NEXT:    br i1 [[I5]], label [[WHILE_END]], label [[SW_BB3_I]]
; CHECK:       sw.bb3.i:
; CHECK-NEXT:    [[I6:%.*]] = phi i64 [ [[ADD]], [[IF_END]] ], [ 3, [[SW_BB_I]] ]
; CHECK-NEXT:    [[I7:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_0184]], i64 -1
; CHECK-NEXT:    [[INCDEC_PTR4_I:%.*]] = getelementptr inbounds i8, i8* [[I7]], i64 [[I6]]
; CHECK-NEXT:    [[I8:%.*]] = load i8, i8* [[INCDEC_PTR4_I]], align 1
; CHECK-NEXT:    [[I9:%.*]] = icmp sgt i8 [[I8]], -65
; CHECK-NEXT:    br i1 [[I9]], label [[WHILE_END]], label [[SW_BB12_I]]
; CHECK:       sw.bb12.i:
; CHECK-NEXT:    [[SRCPTR_1_I:%.*]] = phi i8* [ [[ADD_PTR_I]], [[IF_END]] ], [ [[INCDEC_PTR4_I]], [[SW_BB3_I]] ]
; CHECK-NEXT:    [[INCDEC_PTR13_I:%.*]] = getelementptr inbounds i8, i8* [[SRCPTR_1_I]], i64 -1
; CHECK-NEXT:    [[I10:%.*]] = load i8, i8* [[INCDEC_PTR13_I]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[I10]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[TMP1]] to i8
; CHECK-NEXT:    [[I11:%.*]] = icmp sgt i8 [[TMP2]], -65
; CHECK-NEXT:    br i1 [[I11]], label [[WHILE_END]], label [[IF_END20_I:%.*]]
; CHECK:       if.end20.i:
; CHECK-NEXT:    switch i32 [[TMP0]], label [[SW_BB47_I]] [
; CHECK-NEXT:    i32 224, label [[SW_BB22_I:%.*]]
; CHECK-NEXT:    i32 237, label [[SW_BB27_I:%.*]]
; CHECK-NEXT:    i32 240, label [[SW_BB32_I:%.*]]
; CHECK-NEXT:    i32 244, label [[SW_BB37_I:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb22.i:
; CHECK-NEXT:    [[CMP24_I:%.*]] = icmp ult i32 [[TMP1]], 160
; CHECK-NEXT:    br i1 [[CMP24_I]], label [[WHILE_END]], label [[IF_END5:%.*]]
; CHECK:       sw.bb27.i:
; CHECK-NEXT:    [[CMP29_I:%.*]] = icmp ugt i32 [[TMP1]], 159
; CHECK-NEXT:    br i1 [[CMP29_I]], label [[WHILE_END]], label [[IF_END5]]
; CHECK:       sw.bb32.i:
; CHECK-NEXT:    [[CMP34_I:%.*]] = icmp ult i32 [[TMP1]], 144
; CHECK-NEXT:    br i1 [[CMP34_I]], label [[WHILE_END]], label [[IF_END5]]
; CHECK:       sw.bb37.i:
; CHECK-NEXT:    [[CMP39_I:%.*]] = icmp ugt i32 [[TMP1]], 143
; CHECK-NEXT:    br i1 [[CMP39_I]], label [[WHILE_END]], label [[IF_END5]]
; CHECK:       sw.bb47.i:
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i32 [[TMP0]] to i8
; CHECK-NEXT:    [[I12:%.*]] = icmp slt i8 [[TMP3]], -62
; CHECK-NEXT:    [[CMP56_I:%.*]] = icmp ugt i32 [[TMP0]], 244
; CHECK-NEXT:    [[OR_COND:%.*]] = or i1 [[I12]], [[CMP56_I]]
; CHECK-NEXT:    br i1 [[OR_COND]], label [[WHILE_END]], label [[IF_END5]]
; CHECK:       if.end5:
; CHECK-NEXT:    switch i8 [[I3]], label [[SW_EPILOG:%.*]] [
; CHECK-NEXT:    i8 0, label [[SW_BB29:%.*]]
; CHECK-NEXT:    i8 1, label [[SW_BB24:%.*]]
; CHECK-NEXT:    i8 3, label [[SW_BB14:%.*]]
; CHECK-NEXT:    i8 2, label [[SW_BB19:%.*]]
; CHECK-NEXT:    ]
; CHECK:       sw.bb14:
; CHECK-NEXT:    [[INCDEC_PTR15:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_0184]], i64 1
; CHECK-NEXT:    [[CONV16:%.*]] = zext i8 [[I2]] to i32
; CHECK-NEXT:    [[SHL18:%.*]] = shl nuw nsw i32 [[CONV16]], 6
; CHECK-NEXT:    [[DOTPRE232:%.*]] = load i8, i8* [[INCDEC_PTR15]], align 1
; CHECK-NEXT:    [[TMP4:%.*]] = zext i8 [[DOTPRE232]] to i32
; CHECK-NEXT:    br label [[SW_BB19]]
; CHECK:       sw.bb19:
; CHECK-NEXT:    [[I13:%.*]] = phi i32 [ [[TMP0]], [[IF_END5]] ], [ [[TMP4]], [[SW_BB14]] ]
; CHECK-NEXT:    [[SOURCE_3:%.*]] = phi i8* [ [[SOURCE_0184]], [[IF_END5]] ], [ [[INCDEC_PTR15]], [[SW_BB14]] ]
; CHECK-NEXT:    [[CH_2:%.*]] = phi i32 [ 0, [[IF_END5]] ], [ [[SHL18]], [[SW_BB14]] ]
; CHECK-NEXT:    [[INCDEC_PTR20:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_3]], i64 1
; CHECK-NEXT:    [[ADD22:%.*]] = add nuw nsw i32 [[CH_2]], [[I13]]
; CHECK-NEXT:    [[SHL23:%.*]] = shl nsw i32 [[ADD22]], 6
; CHECK-NEXT:    [[DOTPRE233:%.*]] = load i8, i8* [[INCDEC_PTR20]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = zext i8 [[DOTPRE233]] to i32
; CHECK-NEXT:    br label [[SW_BB24]]
; CHECK:       sw.bb24:
; CHECK-NEXT:    [[I14:%.*]] = phi i32 [ [[TMP0]], [[IF_END5]] ], [ [[TMP5]], [[SW_BB19]] ]
; CHECK-NEXT:    [[SOURCE_4:%.*]] = phi i8* [ [[SOURCE_0184]], [[IF_END5]] ], [ [[INCDEC_PTR20]], [[SW_BB19]] ]
; CHECK-NEXT:    [[CH_3:%.*]] = phi i32 [ 0, [[IF_END5]] ], [ [[SHL23]], [[SW_BB19]] ]
; CHECK-NEXT:    [[INCDEC_PTR25:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_4]], i64 1
; CHECK-NEXT:    [[ADD27:%.*]] = add nsw i32 [[CH_3]], [[I14]]
; CHECK-NEXT:    [[SHL28:%.*]] = shl i32 [[ADD27]], 6
; CHECK-NEXT:    [[DOTPRE234:%.*]] = load i8, i8* [[INCDEC_PTR25]], align 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i8 [[DOTPRE234]] to i32
; CHECK-NEXT:    br label [[SW_BB29]]
; CHECK:       sw.bb29:
; CHECK-NEXT:    [[I15:%.*]] = phi i32 [ [[TMP0]], [[IF_END5]] ], [ [[TMP6]], [[SW_BB24]] ]
; CHECK-NEXT:    [[SOURCE_5:%.*]] = phi i8* [ [[SOURCE_0184]], [[IF_END5]] ], [ [[INCDEC_PTR25]], [[SW_BB24]] ]
; CHECK-NEXT:    [[CH_4:%.*]] = phi i32 [ 0, [[IF_END5]] ], [ [[SHL28]], [[SW_BB24]] ]
; CHECK-NEXT:    [[INCDEC_PTR30:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_5]], i64 1
; CHECK-NEXT:    [[ADD32:%.*]] = add i32 [[CH_4]], [[I15]]
; CHECK-NEXT:    br label [[SW_EPILOG]]
; CHECK:       sw.epilog:
; CHECK-NEXT:    [[SOURCE_6]] = phi i8* [ [[SOURCE_0184]], [[IF_END5]] ], [ [[INCDEC_PTR30]], [[SW_BB29]] ]
; CHECK-NEXT:    [[CH_5:%.*]] = phi i32 [ 0, [[IF_END5]] ], [ [[ADD32]], [[SW_BB29]] ]
; CHECK-NEXT:    [[ARRAYIDX34:%.*]] = getelementptr inbounds [6 x i32], [6 x i32]* @_ZN4llvmL15offsetsFromUTF8E, i64 0, i64 [[CONV1]]
; CHECK-NEXT:    [[I16:%.*]] = load i32, i32* [[ARRAYIDX34]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[CH_5]], [[I16]]
; CHECK-NEXT:    [[CMP35_NOT:%.*]] = icmp ult i16* [[TARGET_0186]], [[TARGETEND:%.*]]
; CHECK-NEXT:    br i1 [[CMP35_NOT]], label [[IF_END39:%.*]], label [[IF_THEN36:%.*]]
; CHECK:       if.then36:
; CHECK-NEXT:    [[CONV1_LE258:%.*]] = zext i8 [[I3]] to i64
; CHECK-NEXT:    [[IDX_NEG:%.*]] = xor i64 [[CONV1_LE258]], -1
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_6]], i64 [[IDX_NEG]]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       if.end39:
; CHECK-NEXT:    [[CMP40:%.*]] = icmp ult i32 [[SUB]], 65536
; CHECK-NEXT:    br i1 [[CMP40]], label [[IF_THEN41:%.*]], label [[IF_ELSE58:%.*]]
; CHECK:       if.then41:
; CHECK-NEXT:    [[I17:%.*]] = and i32 [[SUB]], -2048
; CHECK-NEXT:    [[I18:%.*]] = icmp eq i32 [[I17]], 55296
; CHECK-NEXT:    br i1 [[I18]], label [[IF_THEN44:%.*]], label [[IF_ELSE54:%.*]]
; CHECK:       if.then44:
; CHECK-NEXT:    br i1 [[CMP61]], label [[IF_THEN46:%.*]], label [[IF_ELSE:%.*]]
; CHECK:       if.then46:
; CHECK-NEXT:    [[CONV1_LE:%.*]] = zext i8 [[I3]] to i64
; CHECK-NEXT:    [[IDX_NEG50:%.*]] = xor i64 [[CONV1_LE]], -1
; CHECK-NEXT:    [[ADD_PTR51:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_6]], i64 [[IDX_NEG50]]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       if.else:
; CHECK-NEXT:    [[INCDEC_PTR52:%.*]] = getelementptr inbounds i16, i16* [[TARGET_0186]], i64 1
; CHECK-NEXT:    store i16 -3, i16* [[TARGET_0186]], align 2
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       if.else54:
; CHECK-NEXT:    [[CONV55:%.*]] = trunc i32 [[SUB]] to i16
; CHECK-NEXT:    [[INCDEC_PTR56:%.*]] = getelementptr inbounds i16, i16* [[TARGET_0186]], i64 1
; CHECK-NEXT:    store i16 [[CONV55]], i16* [[TARGET_0186]], align 2
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       if.else58:
; CHECK-NEXT:    [[CMP59:%.*]] = icmp ugt i32 [[SUB]], 1114111
; CHECK-NEXT:    br i1 [[CMP59]], label [[IF_THEN60:%.*]], label [[IF_ELSE71:%.*]]
; CHECK:       if.then60:
; CHECK-NEXT:    br i1 [[CMP61]], label [[IF_THEN62:%.*]], label [[IF_ELSE68:%.*]]
; CHECK:       if.then62:
; CHECK-NEXT:    [[CONV1_LE254:%.*]] = zext i8 [[I3]] to i64
; CHECK-NEXT:    [[IDX_NEG66:%.*]] = xor i64 [[CONV1_LE254]], -1
; CHECK-NEXT:    [[ADD_PTR67:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_6]], i64 [[IDX_NEG66]]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       if.else68:
; CHECK-NEXT:    [[INCDEC_PTR69:%.*]] = getelementptr inbounds i16, i16* [[TARGET_0186]], i64 1
; CHECK-NEXT:    store i16 -3, i16* [[TARGET_0186]], align 2
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       if.else71:
; CHECK-NEXT:    [[ADD_PTR72:%.*]] = getelementptr inbounds i16, i16* [[TARGET_0186]], i64 1
; CHECK-NEXT:    [[CMP73_NOT:%.*]] = icmp ult i16* [[ADD_PTR72]], [[TARGETEND]]
; CHECK-NEXT:    br i1 [[CMP73_NOT]], label [[IF_END80:%.*]], label [[IF_THEN74:%.*]]
; CHECK:       if.then74:
; CHECK-NEXT:    [[CONV1_LE256:%.*]] = zext i8 [[I3]] to i64
; CHECK-NEXT:    [[IDX_NEG78:%.*]] = xor i64 [[CONV1_LE256]], -1
; CHECK-NEXT:    [[ADD_PTR79:%.*]] = getelementptr inbounds i8, i8* [[SOURCE_6]], i64 [[IDX_NEG78]]
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       if.end80:
; CHECK-NEXT:    [[SUB81:%.*]] = add nuw nsw i32 [[SUB]], 67043328
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[SUB81]], 10
; CHECK-NEXT:    [[I19:%.*]] = trunc i32 [[SHR]] to i16
; CHECK-NEXT:    [[CONV83:%.*]] = add nuw nsw i16 [[I19]], -10240
; CHECK-NEXT:    store i16 [[CONV83]], i16* [[TARGET_0186]], align 2
; CHECK-NEXT:    [[I20:%.*]] = trunc i32 [[SUB]] to i16
; CHECK-NEXT:    [[I21:%.*]] = and i16 [[I20]], 1023
; CHECK-NEXT:    [[CONV86:%.*]] = or i16 [[I21]], -9216
; CHECK-NEXT:    [[INCDEC_PTR87:%.*]] = getelementptr inbounds i16, i16* [[TARGET_0186]], i64 2
; CHECK-NEXT:    store i16 [[CONV86]], i16* [[ADD_PTR72]], align 2
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    [[TARGET_2]] = phi i16* [ [[INCDEC_PTR52]], [[IF_ELSE]] ], [ [[INCDEC_PTR56]], [[IF_ELSE54]] ], [ [[INCDEC_PTR69]], [[IF_ELSE68]] ], [ [[INCDEC_PTR87]], [[IF_END80]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8* [[SOURCE_6]], [[SOURCEEND]]
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_BODY]], label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    [[TARGET_0166:%.*]] = phi i16* [ [[TARGET_0186]], [[IF_THEN74]] ], [ [[TARGET_0186]], [[IF_THEN62]] ], [ [[TARGET_0186]], [[IF_THEN46]] ], [ [[TARGET_0186]], [[IF_THEN36]] ], [ [[I1]], [[ENTRY]] ], [ [[TARGET_2]], [[CLEANUP]] ], [ [[TARGET_0186]], [[WHILE_BODY]] ], [ [[TARGET_0186]], [[IF_END]] ], [ [[TARGET_0186]], [[SW_BB_I]] ], [ [[TARGET_0186]], [[SW_BB3_I]] ], [ [[TARGET_0186]], [[SW_BB12_I]] ], [ [[TARGET_0186]], [[SW_BB22_I]] ], [ [[TARGET_0186]], [[SW_BB27_I]] ], [ [[TARGET_0186]], [[SW_BB32_I]] ], [ [[TARGET_0186]], [[SW_BB37_I]] ], [ [[TARGET_0186]], [[SW_BB47_I]] ]
; CHECK-NEXT:    [[SOURCE_8:%.*]] = phi i8* [ [[ADD_PTR79]], [[IF_THEN74]] ], [ [[ADD_PTR67]], [[IF_THEN62]] ], [ [[ADD_PTR51]], [[IF_THEN46]] ], [ [[ADD_PTR]], [[IF_THEN36]] ], [ [[I]], [[ENTRY]] ], [ [[SOURCE_6]], [[CLEANUP]] ], [ [[SOURCE_0184]], [[WHILE_BODY]] ], [ [[SOURCE_0184]], [[IF_END]] ], [ [[SOURCE_0184]], [[SW_BB_I]] ], [ [[SOURCE_0184]], [[SW_BB3_I]] ], [ [[SOURCE_0184]], [[SW_BB12_I]] ], [ [[SOURCE_0184]], [[SW_BB22_I]] ], [ [[SOURCE_0184]], [[SW_BB27_I]] ], [ [[SOURCE_0184]], [[SW_BB32_I]] ], [ [[SOURCE_0184]], [[SW_BB37_I]] ], [ [[SOURCE_0184]], [[SW_BB47_I]] ]
; CHECK-NEXT:    [[RESULT_2:%.*]] = phi i32 [ 2, [[IF_THEN74]] ], [ 3, [[IF_THEN62]] ], [ 3, [[IF_THEN46]] ], [ 2, [[IF_THEN36]] ], [ 0, [[ENTRY]] ], [ 0, [[CLEANUP]] ], [ 1, [[WHILE_BODY]] ], [ 3, [[IF_END]] ], [ 3, [[SW_BB_I]] ], [ 3, [[SW_BB3_I]] ], [ 3, [[SW_BB12_I]] ], [ 3, [[SW_BB22_I]] ], [ 3, [[SW_BB27_I]] ], [ 3, [[SW_BB32_I]] ], [ 3, [[SW_BB37_I]] ], [ 3, [[SW_BB47_I]] ]
; CHECK-NEXT:    store i8* [[SOURCE_8]], i8** [[SOURCESTART]], align 8
; CHECK-NEXT:    store i16* [[TARGET_0166]], i16** [[TARGETSTART]], align 8
; CHECK-NEXT:    ret i32 [[RESULT_2]]
;
entry:
  %i = load i8*, i8** %sourceStart, align 8
  %i1 = load i16*, i16** %targetStart, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %sourceEnd to i64
  %cmp61 = icmp eq i32 %flags, 0
  %cmp183 = icmp ult i8* %i, %sourceEnd
  br i1 %cmp183, label %while.body, label %while.end

while.body:                                       ; preds = %cleanup, %entry
  %target.0186 = phi i16* [ %target.2, %cleanup ], [ %i1, %entry ]
  %source.0184 = phi i8* [ %source.6, %cleanup ], [ %i, %entry ]
  %i2 = load i8, i8* %source.0184, align 1
  %idxprom = zext i8 %i2 to i64
  %arrayidx = getelementptr inbounds [256 x i8], [256 x i8]* @_ZN4llvmL20trailingBytesForUTF8E, i64 0, i64 %idxprom
  %i3 = load i8, i8* %arrayidx, align 1
  %conv1 = zext i8 %i3 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %source.0184 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %cmp2.not = icmp sgt i64 %sub.ptr.sub, %conv1
  br i1 %cmp2.not, label %if.end, label %while.end

if.end:                                           ; preds = %while.body
  %add = add nuw nsw i64 %conv1, 1
  %add.ptr.i = getelementptr inbounds i8, i8* %source.0184, i64 %add
  switch i8 %i3, label %while.end [
  i8 3, label %sw.bb.i
  i8 2, label %sw.bb3.i
  i8 1, label %sw.bb12.i
  i8 0, label %sw.bb47.i
  ]

sw.bb.i:                                          ; preds = %if.end
  %incdec.ptr.i = getelementptr inbounds i8, i8* %source.0184, i64 %conv1
  %i4 = load i8, i8* %incdec.ptr.i, align 1
  %i5 = icmp sgt i8 %i4, -65
  br i1 %i5, label %while.end, label %sw.bb3.i

sw.bb3.i:                                         ; preds = %sw.bb.i, %if.end
  %i6 = phi i64 [ %add, %if.end ], [ 3, %sw.bb.i ]
  %i7 = getelementptr inbounds i8, i8* %source.0184, i64 -1
  %incdec.ptr4.i = getelementptr inbounds i8, i8* %i7, i64 %i6
  %i8 = load i8, i8* %incdec.ptr4.i, align 1
  %i9 = icmp sgt i8 %i8, -65
  br i1 %i9, label %while.end, label %sw.bb12.i

sw.bb12.i:                                        ; preds = %sw.bb3.i, %if.end
  %srcptr.1.i = phi i8* [ %add.ptr.i, %if.end ], [ %incdec.ptr4.i, %sw.bb3.i ]
  %incdec.ptr13.i = getelementptr inbounds i8, i8* %srcptr.1.i, i64 -1
  %i10 = load i8, i8* %incdec.ptr13.i, align 1
  %i11 = icmp sgt i8 %i10, -65
  br i1 %i11, label %while.end, label %if.end20.i

if.end20.i:                                       ; preds = %sw.bb12.i
  switch i8 %i2, label %sw.bb47.i [
  i8 -32, label %sw.bb22.i
  i8 -19, label %sw.bb27.i
  i8 -16, label %sw.bb32.i
  i8 -12, label %sw.bb37.i
  ]

sw.bb22.i:                                        ; preds = %if.end20.i
  %cmp24.i = icmp ult i8 %i10, -96
  br i1 %cmp24.i, label %while.end, label %if.end5

sw.bb27.i:                                        ; preds = %if.end20.i
  %cmp29.i = icmp ugt i8 %i10, -97
  br i1 %cmp29.i, label %while.end, label %if.end5

sw.bb32.i:                                        ; preds = %if.end20.i
  %cmp34.i = icmp ult i8 %i10, -112
  br i1 %cmp34.i, label %while.end, label %if.end5

sw.bb37.i:                                        ; preds = %if.end20.i
  %cmp39.i = icmp ugt i8 %i10, -113
  br i1 %cmp39.i, label %while.end, label %if.end5

sw.bb47.i:                                        ; preds = %if.end20.i, %if.end
  %i12 = icmp slt i8 %i2, -62
  %cmp56.i = icmp ugt i8 %i2, -12
  %or.cond = or i1 %i12, %cmp56.i
  br i1 %or.cond, label %while.end, label %if.end5

if.end5:                                          ; preds = %sw.bb47.i, %sw.bb37.i, %sw.bb32.i, %sw.bb27.i, %sw.bb22.i
  switch i8 %i3, label %sw.epilog [
  i8 0, label %sw.bb29
  i8 1, label %sw.bb24
  i8 3, label %sw.bb14
  i8 2, label %sw.bb19
  ]

sw.bb14:                                          ; preds = %if.end5
  %incdec.ptr15 = getelementptr inbounds i8, i8* %source.0184, i64 1
  %conv16 = zext i8 %i2 to i32
  %shl18 = shl nuw nsw i32 %conv16, 6
  %.pre232 = load i8, i8* %incdec.ptr15, align 1
  br label %sw.bb19

sw.bb19:                                          ; preds = %sw.bb14, %if.end5
  %i13 = phi i8 [ %i2, %if.end5 ], [ %.pre232, %sw.bb14 ]
  %source.3 = phi i8* [ %source.0184, %if.end5 ], [ %incdec.ptr15, %sw.bb14 ]
  %ch.2 = phi i32 [ 0, %if.end5 ], [ %shl18, %sw.bb14 ]
  %incdec.ptr20 = getelementptr inbounds i8, i8* %source.3, i64 1
  %conv21 = zext i8 %i13 to i32
  %add22 = add nuw nsw i32 %ch.2, %conv21
  %shl23 = shl nsw i32 %add22, 6
  %.pre233 = load i8, i8* %incdec.ptr20, align 1
  br label %sw.bb24

sw.bb24:                                          ; preds = %sw.bb19, %if.end5
  %i14 = phi i8 [ %i2, %if.end5 ], [ %.pre233, %sw.bb19 ]
  %source.4 = phi i8* [ %source.0184, %if.end5 ], [ %incdec.ptr20, %sw.bb19 ]
  %ch.3 = phi i32 [ 0, %if.end5 ], [ %shl23, %sw.bb19 ]
  %incdec.ptr25 = getelementptr inbounds i8, i8* %source.4, i64 1
  %conv26 = zext i8 %i14 to i32
  %add27 = add nsw i32 %ch.3, %conv26
  %shl28 = shl i32 %add27, 6
  %.pre234 = load i8, i8* %incdec.ptr25, align 1
  br label %sw.bb29

sw.bb29:                                          ; preds = %sw.bb24, %if.end5
  %i15 = phi i8 [ %i2, %if.end5 ], [ %.pre234, %sw.bb24 ]
  %source.5 = phi i8* [ %source.0184, %if.end5 ], [ %incdec.ptr25, %sw.bb24 ]
  %ch.4 = phi i32 [ 0, %if.end5 ], [ %shl28, %sw.bb24 ]
  %incdec.ptr30 = getelementptr inbounds i8, i8* %source.5, i64 1
  %conv31 = zext i8 %i15 to i32
  %add32 = add i32 %ch.4, %conv31
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.bb29, %if.end5
  %source.6 = phi i8* [ %source.0184, %if.end5 ], [ %incdec.ptr30, %sw.bb29 ]
  %ch.5 = phi i32 [ 0, %if.end5 ], [ %add32, %sw.bb29 ]
  %arrayidx34 = getelementptr inbounds [6 x i32], [6 x i32]* @_ZN4llvmL15offsetsFromUTF8E, i64 0, i64 %conv1
  %i16 = load i32, i32* %arrayidx34, align 4
  %sub = sub i32 %ch.5, %i16
  %cmp35.not = icmp ult i16* %target.0186, %targetEnd
  br i1 %cmp35.not, label %if.end39, label %if.then36

if.then36:                                        ; preds = %sw.epilog
  %conv1.le258 = zext i8 %i3 to i64
  %idx.neg = xor i64 %conv1.le258, -1
  %add.ptr = getelementptr inbounds i8, i8* %source.6, i64 %idx.neg
  br label %while.end

if.end39:                                         ; preds = %sw.epilog
  %cmp40 = icmp ult i32 %sub, 65536
  br i1 %cmp40, label %if.then41, label %if.else58

if.then41:                                        ; preds = %if.end39
  %i17 = and i32 %sub, -2048
  %i18 = icmp eq i32 %i17, 55296
  br i1 %i18, label %if.then44, label %if.else54

if.then44:                                        ; preds = %if.then41
  br i1 %cmp61, label %if.then46, label %if.else

if.then46:                                        ; preds = %if.then44
  %conv1.le = zext i8 %i3 to i64
  %idx.neg50 = xor i64 %conv1.le, -1
  %add.ptr51 = getelementptr inbounds i8, i8* %source.6, i64 %idx.neg50
  br label %while.end

if.else:                                          ; preds = %if.then44
  %incdec.ptr52 = getelementptr inbounds i16, i16* %target.0186, i64 1
  store i16 -3, i16* %target.0186, align 2
  br label %cleanup

if.else54:                                        ; preds = %if.then41
  %conv55 = trunc i32 %sub to i16
  %incdec.ptr56 = getelementptr inbounds i16, i16* %target.0186, i64 1
  store i16 %conv55, i16* %target.0186, align 2
  br label %cleanup

if.else58:                                        ; preds = %if.end39
  %cmp59 = icmp ugt i32 %sub, 1114111
  br i1 %cmp59, label %if.then60, label %if.else71

if.then60:                                        ; preds = %if.else58
  br i1 %cmp61, label %if.then62, label %if.else68

if.then62:                                        ; preds = %if.then60
  %conv1.le254 = zext i8 %i3 to i64
  %idx.neg66 = xor i64 %conv1.le254, -1
  %add.ptr67 = getelementptr inbounds i8, i8* %source.6, i64 %idx.neg66
  br label %while.end

if.else68:                                        ; preds = %if.then60
  %incdec.ptr69 = getelementptr inbounds i16, i16* %target.0186, i64 1
  store i16 -3, i16* %target.0186, align 2
  br label %cleanup

if.else71:                                        ; preds = %if.else58
  %add.ptr72 = getelementptr inbounds i16, i16* %target.0186, i64 1
  %cmp73.not = icmp ult i16* %add.ptr72, %targetEnd
  br i1 %cmp73.not, label %if.end80, label %if.then74

if.then74:                                        ; preds = %if.else71
  %conv1.le256 = zext i8 %i3 to i64
  %idx.neg78 = xor i64 %conv1.le256, -1
  %add.ptr79 = getelementptr inbounds i8, i8* %source.6, i64 %idx.neg78
  br label %while.end

if.end80:                                         ; preds = %if.else71
  %sub81 = add nuw nsw i32 %sub, 67043328
  %shr = lshr i32 %sub81, 10
  %i19 = trunc i32 %shr to i16
  %conv83 = add nuw nsw i16 %i19, -10240
  store i16 %conv83, i16* %target.0186, align 2
  %i20 = trunc i32 %sub to i16
  %i21 = and i16 %i20, 1023
  %conv86 = or i16 %i21, -9216
  %incdec.ptr87 = getelementptr inbounds i16, i16* %target.0186, i64 2
  store i16 %conv86, i16* %add.ptr72, align 2
  br label %cleanup

cleanup:                                          ; preds = %if.end80, %if.else68, %if.else54, %if.else
  %target.2 = phi i16* [ %incdec.ptr52, %if.else ], [ %incdec.ptr56, %if.else54 ], [ %incdec.ptr69, %if.else68 ], [ %incdec.ptr87, %if.end80 ]
  %cmp = icmp ult i8* %source.6, %sourceEnd
  br i1 %cmp, label %while.body, label %while.end

while.end:                                        ; preds = %cleanup, %if.then74, %if.then62, %if.then46, %if.then36, %sw.bb47.i, %sw.bb37.i, %sw.bb32.i, %sw.bb27.i, %sw.bb22.i, %sw.bb12.i, %sw.bb3.i, %sw.bb.i, %if.end, %while.body, %entry
  %target.0166 = phi i16* [ %target.0186, %if.then74 ], [ %target.0186, %if.then62 ], [ %target.0186, %if.then46 ], [ %target.0186, %if.then36 ], [ %i1, %entry ], [ %target.2, %cleanup ], [ %target.0186, %while.body ], [ %target.0186, %if.end ], [ %target.0186, %sw.bb.i ], [ %target.0186, %sw.bb3.i ], [ %target.0186, %sw.bb12.i ], [ %target.0186, %sw.bb22.i ], [ %target.0186, %sw.bb27.i ], [ %target.0186, %sw.bb32.i ], [ %target.0186, %sw.bb37.i ], [ %target.0186, %sw.bb47.i ]
  %source.8 = phi i8* [ %add.ptr79, %if.then74 ], [ %add.ptr67, %if.then62 ], [ %add.ptr51, %if.then46 ], [ %add.ptr, %if.then36 ], [ %i, %entry ], [ %source.6, %cleanup ], [ %source.0184, %while.body ], [ %source.0184, %if.end ], [ %source.0184, %sw.bb.i ], [ %source.0184, %sw.bb3.i ], [ %source.0184, %sw.bb12.i ], [ %source.0184, %sw.bb22.i ], [ %source.0184, %sw.bb27.i ], [ %source.0184, %sw.bb32.i ], [ %source.0184, %sw.bb37.i ], [ %source.0184, %sw.bb47.i ]
  %result.2 = phi i32 [ 2, %if.then74 ], [ 3, %if.then62 ], [ 3, %if.then46 ], [ 2, %if.then36 ], [ 0, %entry ], [ 0, %cleanup ], [ 1, %while.body ], [ 3, %if.end ], [ 3, %sw.bb.i ], [ 3, %sw.bb3.i ], [ 3, %sw.bb12.i ], [ 3, %sw.bb22.i ], [ 3, %sw.bb27.i ], [ 3, %sw.bb32.i ], [ 3, %sw.bb37.i ], [ 3, %sw.bb47.i ]
  store i8* %source.8, i8** %sourceStart, align 8
  store i16* %target.0166, i16** %targetStart, align 8
  ret i32 %result.2
}
