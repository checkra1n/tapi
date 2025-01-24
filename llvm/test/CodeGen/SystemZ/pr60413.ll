; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=s390x-ibm-linux | FileCheck %s

%struct.anon.0.1.2.3.8.77 = type { [3 x i8], i8, [3 x i8] }

@e = external dso_local local_unnamed_addr global i32, align 4
@f = external dso_local local_unnamed_addr global %struct.anon.0.1.2.3.8.77, align 4
@g = external dso_local local_unnamed_addr global i8, align 2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0

define dso_local void @m() local_unnamed_addr #1 {
; CHECK-LABEL: m:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stmg %r13, %r15, 104(%r15)
; CHECK-NEXT:    aghi %r15, -168
; CHECK-NEXT:    llhrl %r1, f+4
; CHECK-NEXT:    sll %r1, 8
; CHECK-NEXT:    larl %r2, f
; CHECK-NEXT:    ic %r1, 6(%r2)
; CHECK-NEXT:    lr %r0, %r1
; CHECK-NEXT:    nilh %r0, 255
; CHECK-NEXT:    vlvgp %v1, %r1, %r0
; CHECK-NEXT:    vlvgf %v1, %r1, 0
; CHECK-NEXT:    vlvgf %v1, %r1, 2
; CHECK-NEXT:    vlvgp %v0, %r0, %r1
; CHECK-NEXT:    vlvgf %v0, %r0, 0
; CHECK-NEXT:    vlvgf %v0, %r0, 2
; CHECK-NEXT:    vlvgp %v2, %r1, %r1
; CHECK-NEXT:    vrepf %v2, %v2, 1
; CHECK-NEXT:    vgbm %v3, 30583
; CHECK-NEXT:    vn %v0, %v0, %v3
; CHECK-NEXT:    vn %v1, %v1, %v3
; CHECK-NEXT:    vn %v2, %v2, %v3
; CHECK-NEXT:    vrepif %v3, 127
; CHECK-NEXT:    vchlf %v1, %v1, %v3
; CHECK-NEXT:    vlgvf %r13, %v1, 0
; CHECK-NEXT:    vchlf %v2, %v2, %v3
; CHECK-NEXT:    vlgvf %r3, %v2, 1
; CHECK-NEXT:    nilf %r3, 1
; CHECK-NEXT:    vlgvf %r4, %v2, 0
; CHECK-NEXT:    risbg %r2, %r4, 48, 176, 15
; CHECK-NEXT:    rosbg %r2, %r3, 32, 49, 14
; CHECK-NEXT:    vlgvf %r5, %v2, 2
; CHECK-NEXT:    nilf %r5, 1
; CHECK-NEXT:    rosbg %r2, %r5, 32, 50, 13
; CHECK-NEXT:    vlgvf %r14, %v2, 3
; CHECK-NEXT:    nilf %r14, 1
; CHECK-NEXT:    rosbg %r2, %r14, 32, 51, 12
; CHECK-NEXT:    rosbg %r2, %r13, 52, 52, 11
; CHECK-NEXT:    vlgvf %r13, %v1, 1
; CHECK-NEXT:    rosbg %r2, %r13, 53, 53, 10
; CHECK-NEXT:    vlgvf %r13, %v1, 2
; CHECK-NEXT:    rosbg %r2, %r13, 54, 54, 9
; CHECK-NEXT:    vlgvf %r13, %v1, 3
; CHECK-NEXT:    rosbg %r2, %r13, 55, 55, 8
; CHECK-NEXT:    vchlf %v0, %v0, %v3
; CHECK-NEXT:    vlgvf %r13, %v0, 0
; CHECK-NEXT:    rosbg %r2, %r13, 56, 56, 7
; CHECK-NEXT:    vlgvf %r13, %v0, 1
; CHECK-NEXT:    rosbg %r2, %r13, 57, 57, 6
; CHECK-NEXT:    vlgvf %r13, %v0, 2
; CHECK-NEXT:    rosbg %r2, %r13, 58, 58, 5
; CHECK-NEXT:    vlgvf %r13, %v0, 3
; CHECK-NEXT:    rosbg %r2, %r13, 59, 59, 4
; CHECK-NEXT:    nilf %r4, 1
; CHECK-NEXT:    rosbg %r2, %r4, 32, 60, 3
; CHECK-NEXT:    rosbg %r2, %r3, 32, 61, 2
; CHECK-NEXT:    rosbg %r2, %r5, 32, 62, 1
; CHECK-NEXT:    or %r2, %r14
; CHECK-NEXT:    vlgvb %r4, %v0, 1
; CHECK-NEXT:    vlgvb %r3, %v0, 0
; CHECK-NEXT:    risbg %r3, %r3, 48, 176, 15
; CHECK-NEXT:    rosbg %r3, %r4, 49, 49, 14
; CHECK-NEXT:    vlgvb %r4, %v0, 2
; CHECK-NEXT:    rosbg %r3, %r4, 50, 50, 13
; CHECK-NEXT:    vlgvb %r4, %v0, 3
; CHECK-NEXT:    rosbg %r3, %r4, 51, 51, 12
; CHECK-NEXT:    vlgvb %r4, %v0, 4
; CHECK-NEXT:    rosbg %r3, %r4, 52, 52, 11
; CHECK-NEXT:    vlgvb %r4, %v0, 5
; CHECK-NEXT:    rosbg %r3, %r4, 53, 53, 10
; CHECK-NEXT:    vlgvb %r4, %v0, 6
; CHECK-NEXT:    rosbg %r3, %r4, 54, 54, 9
; CHECK-NEXT:    vlgvb %r4, %v0, 7
; CHECK-NEXT:    rosbg %r3, %r4, 55, 55, 8
; CHECK-NEXT:    vlgvb %r4, %v0, 8
; CHECK-NEXT:    rosbg %r3, %r4, 56, 56, 7
; CHECK-NEXT:    vlgvb %r4, %v0, 9
; CHECK-NEXT:    rosbg %r3, %r4, 57, 57, 6
; CHECK-NEXT:    vlgvb %r4, %v0, 10
; CHECK-NEXT:    rosbg %r3, %r4, 58, 58, 5
; CHECK-NEXT:    vlgvb %r4, %v0, 11
; CHECK-NEXT:    rosbg %r3, %r4, 59, 59, 4
; CHECK-NEXT:    vlgvb %r4, %v0, 12
; CHECK-NEXT:    rosbg %r3, %r4, 60, 60, 3
; CHECK-NEXT:    vlgvb %r4, %v0, 13
; CHECK-NEXT:    rosbg %r3, %r4, 61, 61, 2
; CHECK-NEXT:    vlgvb %r4, %v0, 14
; CHECK-NEXT:    rosbg %r3, %r4, 62, 62, 1
; CHECK-NEXT:    vlgvb %r4, %v0, 15
; CHECK-NEXT:    rosbg %r3, %r4, 63, 63, 0
; CHECK-NEXT:    xilf %r3, 4294967295
; CHECK-NEXT:    clijhe %r1, 128, .LBB0_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    larl %r1, e
; CHECK-NEXT:    llc %r1, 3(%r1)
; CHECK-NEXT:    nilf %r1, 1
; CHECK-NEXT:    j .LBB0_3
; CHECK-NEXT:  .LBB0_2: # %entry
; CHECK-NEXT:    lhi %r1, 0
; CHECK-NEXT:  .LBB0_3: # %entry
; CHECK-NEXT:    or %r2, %r3
; CHECK-NEXT:    chi %r0, 128
; CHECK-NEXT:    jl .LBB0_5
; CHECK-NEXT:  # %bb.4: # %entry
; CHECK-NEXT:    lhi %r1, 0
; CHECK-NEXT:  .LBB0_5: # %entry
; CHECK-NEXT:    tmll %r2, 65535
; CHECK-NEXT:    je .LBB0_7
; CHECK-NEXT:  # %bb.6: # %entry
; CHECK-NEXT:    lhi %r1, 0
; CHECK-NEXT:  .LBB0_7: # %entry
; CHECK-NEXT:    larl %r2, g
; CHECK-NEXT:    stc %r1, 0(%r2)
; CHECK-NEXT:    lmg %r13, %r15, 272(%r15)
; CHECK-NEXT:    br %r14
entry:
  %n = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %n) #2
  %e.promoted9.i = load i32, ptr @e, align 4
  %bf.load.i = load i24, ptr getelementptr inbounds (%struct.anon.0.1.2.3.8.77, ptr @f, i64 0, i32 2), align 4
  %tobool.not.1.i = icmp ult i24 %bf.load.i, 128
  %bf.load.2.i = load i24, ptr getelementptr inbounds (%struct.anon.0.1.2.3.8.77, ptr @f, i64 0, i32 2), align 4
  %bf.load.2.i.fr = freeze i24 %bf.load.2.i
  %tobool.not.2.i = icmp ult i24 %bf.load.2.i.fr, 128
  %bf.load.427.i = load i24, ptr getelementptr inbounds (%struct.anon.0.1.2.3.8.77, ptr @f, i64 0, i32 2), align 4
  %bf.load.3.5.i = load i24, ptr getelementptr inbounds (%struct.anon.0.1.2.3.8.77, ptr @f, i64 0, i32 2), align 4
  %bf.load.2.6.i = load i24, ptr getelementptr inbounds (%struct.anon.0.1.2.3.8.77, ptr @f, i64 0, i32 2), align 4
  %0 = insertelement <16 x i24> poison, i24 %bf.load.2.6.i, i64 0
  %1 = insertelement <16 x i24> %0, i24 %bf.load.2.6.i, i64 1
  %2 = insertelement <16 x i24> %1, i24 %bf.load.3.5.i, i64 3
  %3 = insertelement <16 x i24> %2, i24 %bf.load.3.5.i, i64 5
  %4 = insertelement <16 x i24> %3, i24 poison, i64 7
  %5 = insertelement <16 x i24> %4, i24 poison, i64 9
  %6 = insertelement <16 x i24> %5, i24 %bf.load.427.i, i64 11
  %7 = insertelement <16 x i24> %6, i24 %bf.load.427.i, i64 13
  %8 = insertelement <16 x i24> %7, i24 %bf.load.2.i.fr, i64 15
  %9 = shufflevector <16 x i24> %8, <16 x i24> poison, <16 x i32> <i32 0, i32 1, i32 0, i32 3, i32 3, i32 5, i32 5, i32 7, i32 7, i32 9, i32 9, i32 11, i32 11, i32 13, i32 13, i32 15>
  %.fr = freeze <16 x i24> %9
  %10 = icmp ugt <16 x i24> %.fr, <i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127, i24 127>
  %11 = bitcast <16 x i1> %10 to i16
  %12 = icmp eq i16 %11, 0
  %13 = freeze <16 x i1> poison
  %14 = bitcast <16 x i1> %13 to i16
  %15 = icmp eq i16 %14, -1
  %op.rdx = and i1 %12, %15
  %op.rdx1 = and i1 %op.rdx, %tobool.not.2.i
  %op.rdx2 = select i1 %op.rdx1, i1 %tobool.not.1.i, i1 false
  %16 = trunc i32 %e.promoted9.i to i8
  %17 = and i8 %16, 1
  %18 = select i1 false, i8 0, i8 %17
  %conv14.i = select i1 %op.rdx2, i8 %18, i8 0
  store i8 %conv14.i, ptr @g, align 2
  ret void
}

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { nounwind "target-features"="+transactional-execution,+vector" }
attributes #2 = { nounwind }