; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+sve -o - | FileCheck %s

target triple = "aarch64"

%"class.std::complex" = type { { double, double } }

; Zero initialized reduction. The IR is generated with predicated tail folding (-prefer-predicate-over-epilogue=predicate-dont-vectorize)
;
;   complex<double> x = 0.0 + 0.0i;
;   for (int i = 0; i < 100; ++i)
;       x += a[i] * b[i];
;
define %"class.std::complex" @complex_mul_v2f64(ptr %a, ptr %b) {
; CHECK-LABEL: complex_mul_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w9, #100 // =0x64
; CHECK-NEXT:    cntd x10
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    mov x11, x10
; CHECK-NEXT:    mov z1.d, #0 // =0x0
; CHECK-NEXT:    rdvl x12, #2
; CHECK-NEXT:    whilelo p1.d, xzr, x9
; CHECK-NEXT:    zip2 z0.d, z1.d, z1.d
; CHECK-NEXT:    zip1 z1.d, z1.d, z1.d
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:  .LBB0_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x13, x0, x8
; CHECK-NEXT:    add x14, x1, x8
; CHECK-NEXT:    zip1 p2.d, p1.d, p1.d
; CHECK-NEXT:    zip2 p3.d, p1.d, p1.d
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    mov z7.d, z0.d
; CHECK-NEXT:    ld1d { z2.d }, p3/z, [x13, #1, mul vl]
; CHECK-NEXT:    ld1d { z3.d }, p2/z, [x13]
; CHECK-NEXT:    ld1d { z4.d }, p3/z, [x14, #1, mul vl]
; CHECK-NEXT:    ld1d { z5.d }, p2/z, [x14]
; CHECK-NEXT:    whilelo p1.d, x11, x9
; CHECK-NEXT:    add x8, x8, x12
; CHECK-NEXT:    add x11, x11, x10
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #0
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #0
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #90
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #90
; CHECK-NEXT:    mov z0.d, p3/m, z7.d
; CHECK-NEXT:    mov z1.d, p2/m, z6.d
; CHECK-NEXT:    b.mi .LBB0_1
; CHECK-NEXT:  // %bb.2: // %exit.block
; CHECK-NEXT:    uzp2 z2.d, z1.d, z0.d
; CHECK-NEXT:    uzp1 z0.d, z1.d, z0.d
; CHECK-NEXT:    faddv d0, p0, z0.d
; CHECK-NEXT:    faddv d1, p0, z2.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 killed $z1
; CHECK-NEXT:    ret
entry:
  %active.lane.mask.entry = tail call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 0, i64 100)
  %0 = tail call i64 @llvm.vscale.i64()
  %1 = shl i64 %0, 1
  %2 = shl nuw nsw i64 %0, 5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv35 = phi i64 [ %lsr.iv.next36, %vector.body ], [ %1, %entry ]
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ 0, %entry ]
  %active.lane.mask = phi <vscale x 2 x i1> [ %active.lane.mask.entry, %entry ], [ %active.lane.mask.next, %vector.body ]
  %vec.phi = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %15, %vector.body ]
  %vec.phi27 = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %16, %vector.body ]
  %scevgep = getelementptr i8, ptr %a, i64 %lsr.iv
  %scevgep34 = getelementptr i8, ptr %b, i64 %lsr.iv
  %interleaved.mask = tail call <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i1> %active.lane.mask)
  %wide.masked.vec = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep, i32 8, <vscale x 4 x i1> %interleaved.mask, <vscale x 4 x double> poison)
  %strided.vec = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec)
  %3 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 0
  %4 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 1
  %interleaved.mask28 = tail call <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i1> %active.lane.mask)
  %wide.masked.vec29 = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep34, i32 8, <vscale x 4 x i1> %interleaved.mask28, <vscale x 4 x double> poison)
  %strided.vec30 = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec29)
  %5 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec30, 0
  %6 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec30, 1
  %7 = fmul fast <vscale x 2 x double> %6, %3
  %8 = fmul fast <vscale x 2 x double> %5, %4
  %9 = fmul fast <vscale x 2 x double> %5, %3
  %10 = fadd fast <vscale x 2 x double> %9, %vec.phi27
  %11 = fmul fast <vscale x 2 x double> %6, %4
  %12 = fsub fast <vscale x 2 x double> %10, %11
  %13 = fadd fast <vscale x 2 x double> %8, %vec.phi
  %14 = fadd fast <vscale x 2 x double> %13, %7
  %15 = select fast <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x double> %14, <vscale x 2 x double> %vec.phi
  %16 = select fast <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x double> %12, <vscale x 2 x double> %vec.phi27
  %active.lane.mask.next = tail call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 %lsr.iv35, i64 100)
  %17 = extractelement <vscale x 2 x i1> %active.lane.mask.next, i64 0
  %lsr.iv.next = add i64 %lsr.iv, %2
  %lsr.iv.next36 = add i64 %lsr.iv35, %1
  br i1 %17, label %vector.body, label %exit.block

exit.block:                                     ; preds = %vector.body
  %18 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %16)
  %19 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %15)
  %.fca.0.0.insert = insertvalue %"class.std::complex" poison, double %18, 0, 0
  %.fca.0.1.insert = insertvalue %"class.std::complex" %.fca.0.0.insert, double %19, 0, 1
  ret %"class.std::complex" %.fca.0.1.insert
}

; Zero initialized reduction with conditional block. The IR is generated with scalar tail folding (-prefer-predicate-over-epilogue=scalar-epilogue)
;
;   complex<double> x = 0.0 + 0.0i;
;   for (int i = 0; i < 100; ++i)
;       if (cond[i])
;           x += a[i] * b[i];
;
define %"class.std::complex" @complex_mul_predicated_v2f64(ptr %a, ptr %b, ptr %cond) {
; CHECK-LABEL: complex_mul_predicated_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cntd x10
; CHECK-NEXT:    mov w12, #100 // =0x64
; CHECK-NEXT:    neg x11, x10
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    mov x9, xzr
; CHECK-NEXT:    and x11, x11, x12
; CHECK-NEXT:    mov z1.d, #0 // =0x0
; CHECK-NEXT:    rdvl x12, #2
; CHECK-NEXT:    zip2 z0.d, z1.d, z1.d
; CHECK-NEXT:    zip1 z1.d, z1.d, z1.d
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:  .LBB1_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld1w { z2.d }, p0/z, [x2, x9, lsl #2]
; CHECK-NEXT:    add x13, x0, x8
; CHECK-NEXT:    add x14, x1, x8
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    mov z7.d, z0.d
; CHECK-NEXT:    add x9, x9, x10
; CHECK-NEXT:    add x8, x8, x12
; CHECK-NEXT:    cmpne p2.d, p0/z, z2.d, #0
; CHECK-NEXT:    zip1 p1.d, p2.d, p2.d
; CHECK-NEXT:    zip2 p2.d, p2.d, p2.d
; CHECK-NEXT:    ld1d { z2.d }, p2/z, [x13, #1, mul vl]
; CHECK-NEXT:    ld1d { z3.d }, p1/z, [x13]
; CHECK-NEXT:    ld1d { z4.d }, p2/z, [x14, #1, mul vl]
; CHECK-NEXT:    ld1d { z5.d }, p1/z, [x14]
; CHECK-NEXT:    cmp x11, x9
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #0
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #0
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #90
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #90
; CHECK-NEXT:    mov z0.d, p2/m, z7.d
; CHECK-NEXT:    mov z1.d, p1/m, z6.d
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %exit.block
; CHECK-NEXT:    uzp2 z2.d, z1.d, z0.d
; CHECK-NEXT:    uzp1 z0.d, z1.d, z0.d
; CHECK-NEXT:    faddv d0, p0, z0.d
; CHECK-NEXT:    faddv d1, p0, z2.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 killed $z1
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.vscale.i64()
  %1 = shl nuw nsw i64 %0, 1
  %n.mod.vf = urem i64 100, %1
  %n.vec = sub i64 100, %n.mod.vf
  %2 = shl nuw nsw i64 %0, 5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv48 = phi i64 [ %lsr.iv.next, %vector.body ], [ 0, %entry ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %vec.phi = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %predphi34, %vector.body ]
  %vec.phi30 = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %predphi, %vector.body ]
  %3 = shl i64 %index, 2
  %scevgep47 = getelementptr i8, ptr %cond, i64 %3
  %wide.load = load <vscale x 2 x i32>, ptr %scevgep47, align 4
  %4 = icmp ne <vscale x 2 x i32> %wide.load, zeroinitializer
  %scevgep49 = getelementptr i8, ptr %a, i64 %lsr.iv48
  %scevgep50 = getelementptr i8, ptr %b, i64 %lsr.iv48
  %interleaved.mask = tail call <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1> %4, <vscale x 2 x i1> %4)
  %wide.masked.vec = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep49, i32 8, <vscale x 4 x i1> %interleaved.mask, <vscale x 4 x double> poison)
  %strided.vec = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec)
  %5 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 0
  %6 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 1
  %wide.masked.vec32 = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep50, i32 8, <vscale x 4 x i1> %interleaved.mask, <vscale x 4 x double> poison)
  %strided.vec33 = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec32)
  %7 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec33, 0
  %8 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec33, 1
  %9 = fmul fast <vscale x 2 x double> %8, %5
  %10 = fmul fast <vscale x 2 x double> %7, %6
  %11 = fmul fast <vscale x 2 x double> %7, %5
  %12 = fadd fast <vscale x 2 x double> %11, %vec.phi30
  %13 = fmul fast <vscale x 2 x double> %8, %6
  %14 = fsub fast <vscale x 2 x double> %12, %13
  %15 = fadd fast <vscale x 2 x double> %10, %vec.phi
  %16 = fadd fast <vscale x 2 x double> %15, %9
  %predphi = select <vscale x 2 x i1> %4, <vscale x 2 x double> %14, <vscale x 2 x double> %vec.phi30
  %predphi34 = select <vscale x 2 x i1> %4, <vscale x 2 x double> %16, <vscale x 2 x double> %vec.phi
  %index.next = add nuw i64 %index, %1
  %lsr.iv.next = add i64 %lsr.iv48, %2
  %17 = icmp eq i64 %n.vec, %index.next
  br i1 %17, label %exit.block, label %vector.body

exit.block:                                     ; preds = %vector.body
  %18 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %predphi)
  %19 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %predphi34)
  %.fca.0.0.insert = insertvalue %"class.std::complex" poison, double %18, 0, 0
  %.fca.0.1.insert = insertvalue %"class.std::complex" %.fca.0.0.insert, double %19, 0, 1
  ret %"class.std::complex" %.fca.0.1.insert
}

; Zero initialized reduction with conditional block. The IR is generated with scalar tail folding (-predicate-over-epilogue=predicate-dont-vectorize)
;
;   complex<double> x = 0.0 + 0.0i;
;   for (int i = 0; i < 100; ++i)
;       if (cond[i])
;           x += a[i] * b[i];
;
define %"class.std::complex" @complex_mul_predicated_x2_v2f64(ptr %a, ptr %b, ptr %cond) {
; CHECK-LABEL: complex_mul_predicated_x2_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w10, #100 // =0x64
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    mov x9, xzr
; CHECK-NEXT:    mov z1.d, #0 // =0x0
; CHECK-NEXT:    cntd x11
; CHECK-NEXT:    rdvl x12, #2
; CHECK-NEXT:    whilelo p1.d, xzr, x10
; CHECK-NEXT:    zip2 z0.d, z1.d, z1.d
; CHECK-NEXT:    zip1 z1.d, z1.d, z1.d
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:  .LBB2_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld1w { z2.d }, p1/z, [x2, x9, lsl #2]
; CHECK-NEXT:    add x13, x0, x8
; CHECK-NEXT:    add x14, x1, x8
; CHECK-NEXT:    mov z6.d, z1.d
; CHECK-NEXT:    mov z7.d, z0.d
; CHECK-NEXT:    add x9, x9, x11
; CHECK-NEXT:    add x8, x8, x12
; CHECK-NEXT:    cmpne p1.d, p1/z, z2.d, #0
; CHECK-NEXT:    zip1 p2.d, p1.d, p1.d
; CHECK-NEXT:    zip2 p3.d, p1.d, p1.d
; CHECK-NEXT:    ld1d { z2.d }, p3/z, [x13, #1, mul vl]
; CHECK-NEXT:    ld1d { z3.d }, p2/z, [x13]
; CHECK-NEXT:    ld1d { z4.d }, p3/z, [x14, #1, mul vl]
; CHECK-NEXT:    ld1d { z5.d }, p2/z, [x14]
; CHECK-NEXT:    whilelo p1.d, x9, x10
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #0
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #0
; CHECK-NEXT:    fcmla z6.d, p0/m, z5.d, z3.d, #90
; CHECK-NEXT:    fcmla z7.d, p0/m, z4.d, z2.d, #90
; CHECK-NEXT:    mov z0.d, p3/m, z7.d
; CHECK-NEXT:    mov z1.d, p2/m, z6.d
; CHECK-NEXT:    b.mi .LBB2_1
; CHECK-NEXT:  // %bb.2: // %exit.block
; CHECK-NEXT:    uzp2 z2.d, z1.d, z0.d
; CHECK-NEXT:    uzp1 z0.d, z1.d, z0.d
; CHECK-NEXT:    faddv d0, p0, z0.d
; CHECK-NEXT:    faddv d1, p0, z2.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 killed $z1
; CHECK-NEXT:    ret
entry:
  %active.lane.mask.entry = tail call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 0, i64 100)
  %0 = tail call i64 @llvm.vscale.i64()
  %1 = shl i64 %0, 1
  %2 = shl nuw nsw i64 %0, 5
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ 0, %entry ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %active.lane.mask = phi <vscale x 2 x i1> [ %active.lane.mask.entry, %entry ], [ %active.lane.mask.next, %vector.body ]
  %vec.phi = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %19, %vector.body ]
  %vec.phi30 = phi <vscale x 2 x double> [ zeroinitializer, %entry ], [ %21, %vector.body ]
  %3 = shl i64 %index, 2
  %scevgep = getelementptr i8, ptr %cond, i64 %3
  %wide.masked.load = tail call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr %scevgep, i32 4, <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i32> poison)
  %4 = icmp ne <vscale x 2 x i32> %wide.masked.load, zeroinitializer
  %scevgep38 = getelementptr i8, ptr %a, i64 %lsr.iv
  %scevgep39 = getelementptr i8, ptr %b, i64 %lsr.iv
  %5 = select <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i1> %4, <vscale x 2 x i1> zeroinitializer
  %interleaved.mask = tail call <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1> %5, <vscale x 2 x i1> %5)
  %wide.masked.vec = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep38, i32 8, <vscale x 4 x i1> %interleaved.mask, <vscale x 4 x double> poison)
  %strided.vec = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec)
  %6 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 0
  %7 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec, 1
  %interleaved.mask31 = tail call <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1> %5, <vscale x 2 x i1> %5)
  %wide.masked.vec32 = tail call <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr %scevgep39, i32 8, <vscale x 4 x i1> %interleaved.mask31, <vscale x 4 x double> poison)
  %strided.vec33 = tail call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %wide.masked.vec32)
  %8 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec33, 0
  %9 = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } %strided.vec33, 1
  %10 = fmul fast <vscale x 2 x double> %9, %6
  %11 = fmul fast <vscale x 2 x double> %8, %7
  %12 = fmul fast <vscale x 2 x double> %8, %6
  %13 = fadd fast <vscale x 2 x double> %12, %vec.phi30
  %14 = fmul fast <vscale x 2 x double> %9, %7
  %15 = fsub fast <vscale x 2 x double> %13, %14
  %16 = fadd fast <vscale x 2 x double> %11, %vec.phi
  %17 = fadd fast <vscale x 2 x double> %16, %10
  %18 = select <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i1> %4, <vscale x 2 x i1> zeroinitializer
  %19 = select fast <vscale x 2 x i1> %18, <vscale x 2 x double> %17, <vscale x 2 x double> %vec.phi
  %20 = select <vscale x 2 x i1> %active.lane.mask, <vscale x 2 x i1> %4, <vscale x 2 x i1> zeroinitializer
  %21 = select fast <vscale x 2 x i1> %20, <vscale x 2 x double> %15, <vscale x 2 x double> %vec.phi30
  %index.next = add i64 %index, %1
  %22 = add i64 %1, %index
  %active.lane.mask.next = tail call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 %22, i64 100)
  %23 = extractelement <vscale x 2 x i1> %active.lane.mask.next, i64 0
  %lsr.iv.next = add i64 %lsr.iv, %2
  br i1 %23, label %vector.body, label %exit.block

exit.block:                                     ; preds = %vector.body
  %24 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %21)
  %25 = tail call fast double @llvm.vector.reduce.fadd.nxv2f64(double -0.000000e+00, <vscale x 2 x double> %19)
  %.fca.0.0.insert = insertvalue %"class.std::complex" poison, double %24, 0, 0
  %.fca.0.1.insert = insertvalue %"class.std::complex" %.fca.0.0.insert, double %25, 0, 1
  ret %"class.std::complex" %.fca.0.1.insert
}

declare i64 @llvm.vscale.i64()
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64, i64)
declare <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr nocapture, i32 immarg, <vscale x 2 x i1>, <vscale x 2 x i32>)
declare <vscale x 4 x double> @llvm.masked.load.nxv4f64.p0(ptr nocapture, i32 immarg, <vscale x 4 x i1>, <vscale x 4 x double>)
declare <vscale x 4 x i1> @llvm.experimental.vector.interleave2.nxv4i1(<vscale x 2 x i1>, <vscale x 2 x i1>)
declare { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double>)
declare double @llvm.vector.reduce.fadd.nxv2f64(double, <vscale x 2 x double>)
