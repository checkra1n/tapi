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

fcvt    z0.h, p0/m, z0.s
// CHECK-INST: fcvt    z0.h, p0/m, z0.s
// CHECK-ENCODING: [0x00,0xa0,0x88,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 6588a000 <unknown>

fcvt    z0.h, p0/m, z0.d
// CHECK-INST: fcvt    z0.h, p0/m, z0.d
// CHECK-ENCODING: [0x00,0xa0,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65c8a000 <unknown>

fcvt    z0.s, p0/m, z0.h
// CHECK-INST: fcvt    z0.s, p0/m, z0.h
// CHECK-ENCODING: [0x00,0xa0,0x89,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 6589a000 <unknown>

fcvt    z0.s, p0/m, z0.d
// CHECK-INST: fcvt    z0.s, p0/m, z0.d
// CHECK-ENCODING: [0x00,0xa0,0xca,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65caa000 <unknown>

fcvt    z0.d, p0/m, z0.h
// CHECK-INST: fcvt    z0.d, p0/m, z0.h
// CHECK-ENCODING: [0x00,0xa0,0xc9,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65c9a000 <unknown>

fcvt    z0.d, p0/m, z0.s
// CHECK-INST: fcvt    z0.d, p0/m, z0.s
// CHECK-ENCODING: [0x00,0xa0,0xcb,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65cba000 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z5.d, p0/z, z7.d
// CHECK-INST: movprfx	z5.d, p0/z, z7.d
// CHECK-ENCODING: [0xe5,0x20,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04d020e5 <unknown>

fcvt    z5.d, p0/m, z0.s
// CHECK-INST: fcvt	z5.d, p0/m, z0.s
// CHECK-ENCODING: [0x05,0xa0,0xcb,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65cba005 <unknown>

movprfx z5, z7
// CHECK-INST: movprfx	z5, z7
// CHECK-ENCODING: [0xe5,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce5 <unknown>

fcvt    z5.d, p0/m, z0.s
// CHECK-INST: fcvt	z5.d, p0/m, z0.s
// CHECK-ENCODING: [0x05,0xa0,0xcb,0x65]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 65cba005 <unknown>
