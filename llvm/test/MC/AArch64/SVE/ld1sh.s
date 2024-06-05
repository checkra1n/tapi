// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

ld1sh   z0.s, p0/z, [x0]
// CHECK-INST: ld1sh   { z0.s }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a520a000 <unknown>

ld1sh   z0.d, p0/z, [x0]
// CHECK-INST: ld1sh   { z0.d }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a500a000 <unknown>

ld1sh   { z0.s }, p0/z, [x0]
// CHECK-INST: ld1sh   { z0.s }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a520a000 <unknown>

ld1sh   { z0.d }, p0/z, [x0]
// CHECK-INST: ld1sh   { z0.d }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a500a000 <unknown>

ld1sh   { z31.s }, p7/z, [sp, #-1, mul vl]
// CHECK-INST: ld1sh   { z31.s }, p7/z, [sp, #-1, mul vl]
// CHECK-ENCODING: [0xff,0xbf,0x2f,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a52fbfff <unknown>

ld1sh   { z21.s }, p5/z, [x10, #5, mul vl]
// CHECK-INST: ld1sh   { z21.s }, p5/z, [x10, #5, mul vl]
// CHECK-ENCODING: [0x55,0xb5,0x25,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a525b555 <unknown>

ld1sh   { z31.d }, p7/z, [sp, #-1, mul vl]
// CHECK-INST: ld1sh   { z31.d }, p7/z, [sp, #-1, mul vl]
// CHECK-ENCODING: [0xff,0xbf,0x0f,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a50fbfff <unknown>

ld1sh   { z21.d }, p5/z, [x10, #5, mul vl]
// CHECK-INST: ld1sh   { z21.d }, p5/z, [x10, #5, mul vl]
// CHECK-ENCODING: [0x55,0xb5,0x05,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a505b555 <unknown>

ld1sh    { z21.s }, p5/z, [sp, x21, lsl #1]
// CHECK-INST: ld1sh    { z21.s }, p5/z, [sp, x21, lsl #1]
// CHECK-ENCODING: [0xf5,0x57,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a53557f5 <unknown>

ld1sh    { z21.s }, p5/z, [x10, x21, lsl #1]
// CHECK-INST: ld1sh    { z21.s }, p5/z, [x10, x21, lsl #1]
// CHECK-ENCODING: [0x55,0x55,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a5355555 <unknown>

ld1sh    { z23.d }, p3/z, [x13, x8, lsl #1]
// CHECK-INST: ld1sh    { z23.d }, p3/z, [x13, x8, lsl #1]
// CHECK-ENCODING: [0xb7,0x4d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a5084db7 <unknown>
