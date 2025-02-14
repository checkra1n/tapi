// RUN: %clang_cc1 -triple arm64-apple-ios -fptrauth-calls -emit-llvm -std=c++11 %s -o - \
// RUN:  | FileCheck %s --check-prefix=CXAATEXIT

// RUN: %clang_cc1 -triple arm64-apple-ios -fptrauth-calls -emit-llvm -std=c++11 %s -o - \
// RUN:    -fno-use-cxa-atexit \
// RUN:  | FileCheck %s --check-prefix=ATEXIT

class Foo {
 public:
  ~Foo() {
  }
};

Foo global;

// CXAATEXIT: @_ZN3FooD1Ev.ptrauth = private constant { ptr, i32, i64, i64 } { ptr @_ZN3FooD1Ev, i32 0, i64 0, i64 0 }, section "llvm.ptrauth", align 8
// CXAATEXIT: define internal void @__cxx_global_var_init()
// CXAATEXIT:   call i32 @__cxa_atexit(ptr @_ZN3FooD1Ev.ptrauth, ptr @global, ptr @__dso_handle)


// ATEXIT: @__dtor_global.ptrauth = private constant { ptr, i32, i64, i64 } { ptr @__dtor_global, i32 0, i64 0, i64 0 }, section "llvm.ptrauth", align 8
// ATEXIT: define internal void @__cxx_global_var_init()
// ATEXIT:   %{{.*}} = call i32 @atexit(ptr @__dtor_global.ptrauth)

// ATEXIT: define internal void @__dtor_global() {{.*}} section "__TEXT,__StaticInit,regular,pure_instructions" {
// ATEXIT:   %{{.*}} = call ptr @_ZN3FooD1Ev(ptr @global)
