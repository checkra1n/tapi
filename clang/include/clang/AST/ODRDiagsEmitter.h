//===- ODRDiagsEmitter.h - Emits diagnostic for ODR mismatches --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_AST_ODRDIAGSEMITTER_H
#define LLVM_CLANG_AST_ODRDIAGSEMITTER_H

#include "clang/AST/ASTContext.h"
#include "clang/AST/DeclCXX.h"
#include "clang/Basic/Diagnostic.h"
#include "clang/Basic/LangOptions.h"

namespace clang {

class ODRDiagsEmitter {
public:
  ODRDiagsEmitter(DiagnosticsEngine &Diags, const ASTContext &Context,
                  const LangOptions &LangOpts)
      : Diags(Diags), Context(Context), LangOpts(LangOpts) {}

  /// Diagnose ODR mismatch between 2 FunctionDecl.
  ///
  /// Returns true if found a mismatch and diagnosed it.
  bool diagnoseMismatch(const FunctionDecl *FirstFunction,
                        const FunctionDecl *SecondFunction) const;

  /// Diagnose ODR mismatch between 2 EnumDecl.
  ///
  /// Returns true if found a mismatch and diagnosed it.
  bool diagnoseMismatch(const EnumDecl *FirstEnum,
                        const EnumDecl *SecondEnum) const;

  /// Diagnose ODR mismatch between 2 CXXRecordDecl.
  ///
  /// Returns true if found a mismatch and diagnosed it.
  /// To compare 2 declarations with merged and identical definition data
  /// you need to provide pre-merge definition data in \p SecondDD.
  bool
  diagnoseMismatch(const CXXRecordDecl *FirstRecord,
                   const CXXRecordDecl *SecondRecord,
                   const struct CXXRecordDecl::DefinitionData *SecondDD) const;

  /// Diagnose ODR mismatch between 2 RecordDecl that are not CXXRecordDecl.
  ///
  /// Returns true if found a mismatch and diagnosed it.
  bool diagnoseMismatch(const RecordDecl *FirstRecord,
                        const RecordDecl *SecondRecord) const;

  /// Get the best name we know for the module that owns the given
  /// declaration, or an empty string if the declaration is not from a module.
  static std::string getOwningModuleNameForDiagnostic(const Decl *D);

private:
  using DeclHashes = llvm::SmallVector<std::pair<const Decl *, unsigned>, 4>;

  // Used with err_module_odr_violation_mismatch_decl and
  // note_module_odr_violation_mismatch_decl
  // This list should be the same Decl's as in ODRHash::isSubDeclToBeProcessed
  enum ODRMismatchDecl {
    EndOfClass,
    PublicSpecifer,
    PrivateSpecifer,
    ProtectedSpecifer,
    StaticAssert,
    Field,
    CXXMethod,
    TypeAlias,
    TypeDef,
    Var,
    Friend,
    FunctionTemplate,
    Other
  };

  struct DiffResult {
    const Decl *FirstDecl = nullptr, *SecondDecl = nullptr;
    ODRMismatchDecl FirstDiffType = Other, SecondDiffType = Other;
  };

  // If there is a diagnoseable difference, FirstDiffType and
  // SecondDiffType will not be Other and FirstDecl and SecondDecl will be
  // filled in if not EndOfClass.
  static DiffResult FindTypeDiffs(DeclHashes &FirstHashes,
                                  DeclHashes &SecondHashes);

  DiagnosticBuilder Diag(SourceLocation Loc, unsigned DiagID) const {
    return Diags.Report(Loc, DiagID);
  }

  // Use this to diagnose that an unexpected Decl was encountered
  // or no difference was detected. This causes a generic error
  // message to be emitted.
  void diagnoseSubMismatchUnexpected(DiffResult &DR,
                                     const NamedDecl *FirstRecord,
                                     StringRef FirstModule,
                                     const NamedDecl *SecondRecord,
                                     StringRef SecondModule) const;

  void diagnoseSubMismatchDifferentDeclKinds(DiffResult &DR,
                                             const NamedDecl *FirstRecord,
                                             StringRef FirstModule,
                                             const NamedDecl *SecondRecord,
                                             StringRef SecondModule) const;

  bool diagnoseSubMismatchField(const NamedDecl *FirstRecord,
                                StringRef FirstModule, StringRef SecondModule,
                                const FieldDecl *FirstField,
                                const FieldDecl *SecondField) const;

  bool diagnoseSubMismatchTypedef(const NamedDecl *FirstRecord,
                                  StringRef FirstModule, StringRef SecondModule,
                                  const TypedefNameDecl *FirstTD,
                                  const TypedefNameDecl *SecondTD,
                                  bool IsTypeAlias) const;

  bool diagnoseSubMismatchVar(const NamedDecl *FirstRecord,
                              StringRef FirstModule, StringRef SecondModule,
                              const VarDecl *FirstVD,
                              const VarDecl *SecondVD) const;

private:
  DiagnosticsEngine &Diags;
  const ASTContext &Context;
  const LangOptions &LangOpts;
};

} // namespace clang

#endif
