// Fix sign conversion warnings found by fsanitize=implicit-integer-sign-change
// in intrinsic headers.
// Preprocess file to workaround no warnings in system headers.
// RUN: %clang_cc1 %s -triple x86_64-pc-linux-gnu -ffreestanding -E -CC 2>&1 \
// RUN:     | %clang_cc1 -x c - -triple x86_64-pc-linux-gnu -Wsign-conversion -fsyntax-only -verify
// REQUIRES: x86-registered-target

#include <x86intrin.h>

void test0(void) {
  // expected-no-diagnostics
  _MM_SET_DENORMALS_ZERO_MODE(_MM_DENORMALS_ZERO_ON);
  _MM_SET_DENORMALS_ZERO_MODE(_MM_DENORMALS_ZERO_OFF);
  _MM_SET_DENORMALS_ZERO_MODE(_MM_DENORMALS_ZERO_MASK);

  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_INVALID);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_DENORM);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_DIV_ZERO);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_OVERFLOW);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_UNDERFLOW);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_INEXACT);
  _MM_SET_EXCEPTION_STATE(_MM_EXCEPT_MASK);

  _MM_SET_EXCEPTION_MASK(_MM_MASK_INVALID);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_DENORM);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_DIV_ZERO);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_OVERFLOW);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_UNDERFLOW);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_INEXACT);
  _MM_SET_EXCEPTION_MASK(_MM_MASK_MASK);

  _MM_SET_ROUNDING_MODE(_MM_ROUND_NEAREST);
  _MM_SET_ROUNDING_MODE(_MM_ROUND_DOWN);
  _MM_SET_ROUNDING_MODE(_MM_ROUND_UP);
  _MM_SET_ROUNDING_MODE(_MM_ROUND_TOWARD_ZERO);
  _MM_SET_ROUNDING_MODE(_MM_ROUND_MASK);

  _MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_MASK);
  _MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_ON);
  _MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_OFF);
}
