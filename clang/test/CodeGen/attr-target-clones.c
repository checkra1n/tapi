// RUN: %clang_cc1 -triple x86_64-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefixes=LINUX,CHECK
// RUN: %clang_cc1 -triple x86_64-apple-macos -emit-llvm %s -o - | FileCheck %s --check-prefixes=DARWIN,CHECK
// RUN: %clang_cc1 -triple x86_64-windows-pc -emit-llvm %s -o - | FileCheck %s --check-prefixes=WINDOWS,CHECK

// LINUX: $foo.resolver = comdat any
// LINUX: $foo_dupes.resolver = comdat any
// LINUX: $unused.resolver = comdat any
// LINUX: $foo_inline.resolver = comdat any
// LINUX: $foo_inline2.resolver = comdat any

// DARWIN-NOT: comdat any

// WINDOWS: $foo = comdat any
// WINDOWS: $foo_dupes = comdat any
// WINDOWS: $unused = comdat any
// WINDOWS: $foo_inline = comdat any
// WINDOWS: $foo_inline2 = comdat any

// LINUX: @foo = weak_odr ifunc i32 (), ptr @foo.resolver
// LINUX: @foo_dupes = weak_odr ifunc void (), ptr @foo_dupes.resolver
// LINUX: @unused = weak_odr ifunc void (), ptr @unused.resolver
// LINUX: @foo_inline = weak_odr ifunc i32 (), ptr @foo_inline.resolver
// LINUX: @foo_inline2 = weak_odr ifunc i32 (), ptr @foo_inline2.resolver
// LINUX: @foo_used_no_defn = weak_odr ifunc i32 (), ptr @foo_used_no_defn.resolver

int __attribute__((target_clones("sse4.2, default"))) foo(void) { return 0; }
// LINUX: define {{.*}}i32 @foo.sse4.2.0()
// LINUX: define {{.*}}i32 @foo.default.1()
// LINUX: define weak_odr ptr @foo.resolver() comdat
// LINUX: ret ptr @foo.sse4.2.0
// LINUX: ret ptr @foo.default.1

// DARWIN: define {{.*}}i32 @foo.sse4.2.0()
// DARWIN: define {{.*}}i32 @foo.default.1()
// DARWIN: define weak_odr ptr @foo.resolver() {
// DARWIN: ret ptr @foo.sse4.2.0
// DARWIN: ret ptr @foo.default.1

// WINDOWS: define dso_local i32 @foo.sse4.2.0()
// WINDOWS: define dso_local i32 @foo.default.1()
// WINDOWS: define weak_odr dso_local i32 @foo() comdat
// WINDOWS: musttail call i32 @foo.sse4.2.0
// WINDOWS: musttail call i32 @foo.default.1

__attribute__((target_clones("default,default ,sse4.2"))) void foo_dupes(void) {}
// LINUX: define {{.*}}void @foo_dupes.default.1()
// LINUX: define {{.*}}void @foo_dupes.sse4.2.0()
// LINUX: define weak_odr ptr @foo_dupes.resolver() comdat
// LINUX: ret ptr @foo_dupes.sse4.2.0
// LINUX: ret ptr @foo_dupes.default.1

// DARWIN: define {{.*}}void @foo_dupes.default.1()
// DARWIN: define {{.*}}void @foo_dupes.sse4.2.0()
// DARWIN: define weak_odr ptr @foo_dupes.resolver() {
// DARWIN: ret ptr @foo_dupes.sse4.2.0
// DARWIN: ret ptr @foo_dupes.default.1

// WINDOWS: define dso_local void @foo_dupes.default.1()
// WINDOWS: define dso_local void @foo_dupes.sse4.2.0()
// WINDOWS: define weak_odr dso_local void @foo_dupes() comdat
// WINDOWS: musttail call void @foo_dupes.sse4.2.0
// WINDOWS: musttail call void @foo_dupes.default.1

void bar2(void) {
  // LINUX: define {{.*}}void @bar2()
  // DARWIN: define {{.*}}void @bar2()
  // WINDOWS: define dso_local void @bar2()
  foo_dupes();
  // LINUX: call void @foo_dupes()
  // DARWIN: call void @foo_dupes()
  // WINDOWS: call void @foo_dupes()
}

int bar(void) {
  // LINUX: define {{.*}}i32 @bar() #[[DEF:[0-9]+]]
  // DARWIN: define {{.*}}i32 @bar() #[[DEF:[0-9]+]]
  // WINDOWS: define dso_local i32 @bar() #[[DEF:[0-9]+]]
  return foo();
  // LINUX: call i32 @foo()
  // DARWIN: call i32 @foo()
  // WINDOWS: call i32 @foo()
}

void __attribute__((target_clones("default, arch=ivybridge"))) unused(void) {}
// LINUX: define {{.*}}void @unused.default.1()
// LINUX: define {{.*}}void @unused.arch_ivybridge.0()
// LINUX: define weak_odr ptr @unused.resolver() comdat
// LINUX: ret ptr @unused.arch_ivybridge.0
// LINUX: ret ptr @unused.default.1

// DARWIN: define {{.*}}void @unused.default.1()
// DARWIN: define {{.*}}void @unused.arch_ivybridge.0()
// DARWIN: define weak_odr ptr @unused.resolver() {
// DARWIN: ret ptr @unused.arch_ivybridge.0
// DARWIN: ret ptr @unused.default.1

// WINDOWS: define dso_local void @unused.default.1()
// WINDOWS: define dso_local void @unused.arch_ivybridge.0()
// WINDOWS: define weak_odr dso_local void @unused() comdat
// WINDOWS: musttail call void @unused.arch_ivybridge.0
// WINDOWS: musttail call void @unused.default.1


inline int __attribute__((target_clones("arch=sandybridge,default,sse4.2")))
foo_inline(void) { return 0; }
inline int __attribute__((target_clones("arch=sandybridge,default,sse4.2")))
foo_inline2(void);

int bar3(void) {
  // LINUX: define {{.*}}i32 @bar3()
  // DARWIN: define {{.*}}i32 @bar3()
  // WINDOWS: define dso_local i32 @bar3()
  return foo_inline() + foo_inline2();
  // LINUX: call i32 @foo_inline()
  // LINUX: call i32 @foo_inline2()
  // DARWIN: call i32 @foo_inline()
  // DARWIN: call i32 @foo_inline2()
  // WINDOWS: call i32 @foo_inline()
  // WINDOWS: call i32 @foo_inline2()
}

// LINUX: define weak_odr ptr @foo_inline.resolver() comdat
// LINUX: ret ptr @foo_inline.arch_sandybridge.0
// LINUX: ret ptr @foo_inline.sse4.2.1
// LINUX: ret ptr @foo_inline.default.2

// DARWIN: define weak_odr ptr @foo_inline.resolver() {
// DARWIN: ret ptr @foo_inline.arch_sandybridge.0
// DARWIN: ret ptr @foo_inline.sse4.2.1
// DARWIN: ret ptr @foo_inline.default.2

// WINDOWS: define weak_odr dso_local i32 @foo_inline() comdat
// WINDOWS: musttail call i32 @foo_inline.arch_sandybridge.0
// WINDOWS: musttail call i32 @foo_inline.sse4.2.1
// WINDOWS: musttail call i32 @foo_inline.default.2

inline int __attribute__((target_clones("arch=sandybridge,default,sse4.2")))
foo_inline2(void){ return 0; }
// LINUX: define weak_odr ptr @foo_inline2.resolver() comdat
// LINUX: ret ptr @foo_inline2.arch_sandybridge.0
// LINUX: ret ptr @foo_inline2.sse4.2.1
// LINUX: ret ptr @foo_inline2.default.2

// DARWIN: define weak_odr ptr @foo_inline2.resolver() {
// DARWIN: ret ptr @foo_inline2.arch_sandybridge.0
// DARWIN: ret ptr @foo_inline2.sse4.2.1
// DARWIN: ret ptr @foo_inline2.default.2

// WINDOWS: define weak_odr dso_local i32 @foo_inline2() comdat
// WINDOWS: musttail call i32 @foo_inline2.arch_sandybridge.0
// WINDOWS: musttail call i32 @foo_inline2.sse4.2.1
// WINDOWS: musttail call i32 @foo_inline2.default.2


int __attribute__((target_clones("default", "sse4.2")))
foo_unused_no_defn(void);

int __attribute__((target_clones("default", "sse4.2")))
foo_used_no_defn(void);

int test_foo_used_no_defn(void) {
  // LINUX: define {{.*}}i32 @test_foo_used_no_defn()
  // DARWIN: define {{.*}}i32 @test_foo_used_no_defn()
  // WINDOWS: define dso_local i32 @test_foo_used_no_defn()
  return foo_used_no_defn();
  // LINUX: call i32 @foo_used_no_defn()
  // DARWIN: call i32 @foo_used_no_defn()
  // WINDOWS: call i32 @foo_used_no_defn()
}


// LINUX: define weak_odr ptr @foo_used_no_defn.resolver() comdat
// LINUX: ret ptr @foo_used_no_defn.sse4.2.0
// LINUX: ret ptr @foo_used_no_defn.default.1

// DARWIN: define weak_odr ptr @foo_used_no_defn.resolver() {
// DARWIN: ret ptr @foo_used_no_defn.sse4.2.0
// DARWIN: ret ptr @foo_used_no_defn.default.1

// WINDOWS: define weak_odr dso_local i32 @foo_used_no_defn() comdat
// WINDOWS: musttail call i32 @foo_used_no_defn.sse4.2.0
// WINDOWS: musttail call i32 @foo_used_no_defn.default.1


// Deferred emission of inline definitions.

// LINUX: define linkonce i32 @foo_inline.arch_sandybridge.0() #[[SB:[0-9]+]]
// LINUX: define linkonce i32 @foo_inline.default.2() #[[DEF:[0-9]+]]
// LINUX: define linkonce i32 @foo_inline.sse4.2.1() #[[SSE42:[0-9]+]]

// DARWIN: define linkonce i32 @foo_inline.arch_sandybridge.0() #[[SB:[0-9]+]]
// DARWIN: define linkonce i32 @foo_inline.default.2() #[[DEF:[0-9]+]]
// DARWIN: define linkonce i32 @foo_inline.sse4.2.1() #[[SSE42:[0-9]+]]

// WINDOWS: define linkonce_odr dso_local i32 @foo_inline.arch_sandybridge.0() #[[SB:[0-9]+]]
// WINDOWS: define linkonce_odr dso_local i32 @foo_inline.default.2() #[[DEF]]
// WINDOWS: define linkonce_odr dso_local i32 @foo_inline.sse4.2.1() #[[SSE42:[0-9]+]]


// LINUX: define linkonce i32 @foo_inline2.arch_sandybridge.0() #[[SB]]
// LINUX: define linkonce i32 @foo_inline2.default.2() #[[DEF]]
// LINUX: define linkonce i32 @foo_inline2.sse4.2.1() #[[SSE42]]

// DARWIN: define linkonce i32 @foo_inline2.arch_sandybridge.0() #[[SB]]
// DARWIN: define linkonce i32 @foo_inline2.default.2() #[[DEF]]
// DARWIN: define linkonce i32 @foo_inline2.sse4.2.1() #[[SSE42]]

// WINDOWS: define linkonce_odr dso_local i32 @foo_inline2.arch_sandybridge.0() #[[SB]]
// WINDOWS: define linkonce_odr dso_local i32 @foo_inline2.default.2() #[[DEF]]
// WINDOWS: define linkonce_odr dso_local i32 @foo_inline2.sse4.2.1() #[[SSE42]]


// LINUX: declare i32 @foo_used_no_defn.default.1()
// LINUX: declare i32 @foo_used_no_defn.sse4.2.0()

// DARWIN: declare i32 @foo_used_no_defn.default.1()
// DARWIN: declare i32 @foo_used_no_defn.sse4.2.0()

// WINDOWS: declare dso_local i32 @foo_used_no_defn.default.1()
// WINDOWS: declare dso_local i32 @foo_used_no_defn.sse4.2.0()


// CHECK: attributes #[[SSE42]] =
// CHECK-SAME: "target-features"="+crc32,+cx8,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87"
// CHECK: attributes #[[DEF]] =
// Don't bother checking features, we verified it is the same as a normal function.
// CHECK: attributes #[[SB]] =
// CHECK-SAME: "target-features"="+avx,+cmov,+crc32,+cx16,+cx8,+fxsr,+mmx,+pclmul,+popcnt,+sahf,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt"
