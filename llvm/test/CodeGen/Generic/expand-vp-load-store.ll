; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --expandvp -S < %s | FileCheck %s
; RUN: opt --expandvp --expandvp-override-evl-transform=Legal --expandvp-override-mask-transform=Convert -S < %s | FileCheck %s

; Fixed vectors
define <2 x i64> @vpload_v2i64(<2 x i64>* %ptr, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: @vpload_v2i64(
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <2 x i32> poison, i32 [[EVL:%.*]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <2 x i32> [[DOTSPLATINSERT]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <2 x i32> <i32 0, i32 1>, [[DOTSPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i1> [[TMP1]], [[M:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i64> @llvm.masked.load.v2i64.p0v2i64(<2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[TMP2]], <2 x i64> poison)
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %load = call <2 x i64> @llvm.vp.load.v2i64.p0v2i64(<2 x i64>* %ptr, <2 x i1> %m, i32 %evl)
  ret <2 x i64> %load
}

define <2 x i64> @vpload_v2i64_vlmax(<2 x i64>* %ptr, <2 x i1> %m) {
; CHECK-LABEL: @vpload_v2i64_vlmax(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.masked.load.v2i64.p0v2i64(<2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[M:%.*]], <2 x i64> poison)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %load = call <2 x i64> @llvm.vp.load.v2i64.p0v2i64(<2 x i64>* %ptr, <2 x i1> %m, i32 2)
  ret <2 x i64> %load
}

define <2 x i64> @vpload_v2i64_allones_mask(<2 x i64>* %ptr, i32 zeroext %evl) {
; CHECK-LABEL: @vpload_v2i64_allones_mask(
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <2 x i32> poison, i32 [[EVL:%.*]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <2 x i32> [[DOTSPLATINSERT]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <2 x i32> <i32 0, i32 1>, [[DOTSPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i1> [[TMP1]], <i1 true, i1 true>
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i64> @llvm.masked.load.v2i64.p0v2i64(<2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[TMP2]], <2 x i64> poison)
; CHECK-NEXT:    ret <2 x i64> [[TMP3]]
;
  %load = call <2 x i64> @llvm.vp.load.v2i64.p0v2i64(<2 x i64>* %ptr, <2 x i1> <i1 1, i1 1>, i32 %evl)
  ret <2 x i64> %load
}

define <2 x i64> @vpload_v2i64_allones_mask_vlmax(<2 x i64>* %ptr) {
; CHECK-LABEL: @vpload_v2i64_allones_mask_vlmax(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* [[PTR:%.*]], align 16
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %load = call <2 x i64> @llvm.vp.load.v2i64.p0v2i64(<2 x i64>* %ptr, <2 x i1> <i1 1, i1 1>, i32 2)
  ret <2 x i64> %load
}

define void @vpstore_v2i64(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: @vpstore_v2i64(
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <2 x i32> poison, i32 [[EVL:%.*]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <2 x i32> [[DOTSPLATINSERT]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <2 x i32> <i32 0, i32 1>, [[DOTSPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i1> [[TMP1]], [[M:%.*]]
; CHECK-NEXT:    call void @llvm.masked.store.v2i64.p0v2i64(<2 x i64> [[VAL:%.*]], <2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[TMP2]])
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.v2i64.p0v2i64(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> %m, i32 %evl)
  ret void
}

define void @vpstore_v2i64_vlmax(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> %m) {
; CHECK-LABEL: @vpstore_v2i64_vlmax(
; CHECK-NEXT:    call void @llvm.masked.store.v2i64.p0v2i64(<2 x i64> [[VAL:%.*]], <2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[M:%.*]])
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.v2i64.p0v2i64(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> %m, i32 2)
  ret void
}

define void @vpstore_v2i64_allones_mask(<2 x i64> %val, <2 x i64>* %ptr, i32 zeroext %evl) {
; CHECK-LABEL: @vpstore_v2i64_allones_mask(
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <2 x i32> poison, i32 [[EVL:%.*]], i32 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <2 x i32> [[DOTSPLATINSERT]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <2 x i32> <i32 0, i32 1>, [[DOTSPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i1> [[TMP1]], <i1 true, i1 true>
; CHECK-NEXT:    call void @llvm.masked.store.v2i64.p0v2i64(<2 x i64> [[VAL:%.*]], <2 x i64>* [[PTR:%.*]], i32 1, <2 x i1> [[TMP2]])
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.v2i64.p0v2i64(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> <i1 1, i1 1>, i32 %evl)
  ret void
}

define void @vpstore_v2i64_allones_mask_vlmax(<2 x i64> %val, <2 x i64>* %ptr) {
; CHECK-LABEL: @vpstore_v2i64_allones_mask_vlmax(
; CHECK-NEXT:    store <2 x i64> [[VAL:%.*]], <2 x i64>* [[PTR:%.*]], align 16
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.v2i64.p0v2i64(<2 x i64> %val, <2 x i64>* %ptr, <2 x i1> <i1 1, i1 1>, i32 2)
  ret void
}

; Scalable vectors
define <vscale x 1 x i64> @vpload_nxv1i64(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: @vpload_nxv1i64(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 0, i32 [[EVL:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and <vscale x 1 x i1> [[TMP1]], [[M:%.*]]
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[SCALABLE_SIZE:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[TMP2]], <vscale x 1 x i64> poison)
; CHECK-NEXT:    ret <vscale x 1 x i64> [[TMP3]]
;
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %load
}

define <vscale x 1 x i64> @vpload_nxv1i64_vscale(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m) {
; CHECK-LABEL: @vpload_nxv1i64_vscale(
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[VLMAX:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[M:%.*]], <vscale x 1 x i64> poison)
; CHECK-NEXT:    ret <vscale x 1 x i64> [[TMP1]]
;
  %vscale = call i32 @llvm.vscale.i32()
  %vlmax = mul nuw i32 %vscale, 1
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 %vlmax)
  ret <vscale x 1 x i64> %load
}

define <vscale x 1 x i64> @vpload_nxv1i64_allones_mask(<vscale x 1 x i64>* %ptr, i32 zeroext %evl) {
; CHECK-LABEL: @vpload_nxv1i64_allones_mask(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 0, i32 [[EVL:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and <vscale x 1 x i1> [[TMP1]], shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer)
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[SCALABLE_SIZE:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[TMP2]], <vscale x 1 x i64> poison)
; CHECK-NEXT:    ret <vscale x 1 x i64> [[TMP3]]
;
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 1 x i64> %load
}

define <vscale x 1 x i64> @vpload_nxv1i64_allones_mask_vscale(<vscale x 1 x i64>* %ptr) {
; CHECK-LABEL: @vpload_nxv1i64_allones_mask_vscale(
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[VLMAX:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = load <vscale x 1 x i64>, <vscale x 1 x i64>* [[PTR:%.*]], align 8
; CHECK-NEXT:    ret <vscale x 1 x i64> [[TMP1]]
;
  %vscale = call i32 @llvm.vscale.i32()
  %vlmax = mul nuw i32 %vscale, 1
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>* %ptr, <vscale x 1 x i1> shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer), i32 %vlmax)
  ret <vscale x 1 x i64> %load
}

define void @vpstore_nxv1i64(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: @vpstore_nxv1i64(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 0, i32 [[EVL:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and <vscale x 1 x i1> [[TMP1]], [[M:%.*]]
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[SCALABLE_SIZE:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    call void @llvm.masked.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> [[VAL:%.*]], <vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[TMP2]])
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret void
}

define void @vpstore_nxv1i64_vscale(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: @vpstore_nxv1i64_vscale(
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[VLMAX:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    call void @llvm.masked.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> [[VAL:%.*]], <vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[M:%.*]])
; CHECK-NEXT:    ret void
;
  %vscale = call i32 @llvm.vscale.i32()
  %vlmax = mul nuw i32 %vscale, 1
  call void @llvm.vp.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> %m, i32 %vlmax)
  ret void
}

define void @vpstore_nxv1i64_allones_mask(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, i32 zeroext %evl) {
; CHECK-LABEL: @vpstore_nxv1i64_allones_mask(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 0, i32 [[EVL:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = and <vscale x 1 x i1> [[TMP1]], shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer)
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[SCALABLE_SIZE:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    call void @llvm.masked.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> [[VAL:%.*]], <vscale x 1 x i64>* [[PTR:%.*]], i32 1, <vscale x 1 x i1> [[TMP2]])
; CHECK-NEXT:    ret void
;
  call void @llvm.vp.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer), i32 %evl)
  ret void
}

define void @vpstore_nxv1i64_allones_mask_vscale(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr) {
; CHECK-LABEL: @vpstore_nxv1i64_allones_mask_vscale(
; CHECK-NEXT:    [[VSCALE:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[VLMAX:%.*]] = mul nuw i32 [[VSCALE]], 1
; CHECK-NEXT:    store <vscale x 1 x i64> [[VAL:%.*]], <vscale x 1 x i64>* [[PTR:%.*]], align 8
; CHECK-NEXT:    ret void
;
  %vscale = call i32 @llvm.vscale.i32()
  %vlmax = mul nuw i32 %vscale, 1
  call void @llvm.vp.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64> %val, <vscale x 1 x i64>* %ptr, <vscale x 1 x i1> shufflevector (<vscale x 1 x i1> insertelement (<vscale x 1 x i1> poison, i1 true, i32 0), <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer), i32 %vlmax)
  ret void
}

declare i32 @llvm.vscale.i32()

declare <2 x i64> @llvm.vp.load.v2i64.p0v2i64(<2 x i64>*, <2 x i1>, i32)
declare void @llvm.vp.store.v2i64.p0v2i64(<2 x i64>, <2 x i64>*, <2 x i1>, i32)

declare <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0nxv1i64(<vscale x 1 x i64>*, <vscale x 1 x i1>, i32)
declare void @llvm.vp.store.nxv1i64.p0nxv1i64(<vscale x 1 x i64>, <vscale x 1 x i64>*, <vscale x 1 x i1>, i32)
