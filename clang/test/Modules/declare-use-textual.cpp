// RUN: rm -rf %t
// RUN: %clang_cc1 -fimplicit-module-maps -fmodules-cache-path=%t -fmodules-decluse -fmodule-name=Textual -I %S/Inputs/declare-use %s -verify
// RUN: %clang_cc1 -fimplicit-module-maps -fmodules-cache-path=%t -fmodules-decluse -fmodule-name=Textual -I %S/Inputs/declare-use %s -fno-modules-validate-textual-header-includes

// expected-error@textual.h:* {{module Textual does not depend on a module exporting 'a.h'}}
#include "textual.h"
