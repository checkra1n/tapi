; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

%struct.test.b = type { i32, i32 }
%struct.test.a = type { %struct.test.b, i32, i8*}

define void @foo(i8* %ptr) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@foo
; TUNIT-SAME: (i8* nocapture nofree readnone [[PTR:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[TMP0:%.*]] = alloca [[STRUCT_TEST_A:%.*]], align 8
; TUNIT-NEXT:    br label [[CALL_BR:%.*]]
; TUNIT:       call.br:
; TUNIT-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_TEST_A]], %struct.test.a* [[TMP0]], i64 0, i32 2
; TUNIT-NEXT:    tail call void @bar(%struct.test.a* noalias nocapture nofree noundef nonnull readonly byval([[STRUCT_TEST_A]]) align 8 dereferenceable(24) [[TMP0]]) #[[ATTR2:[0-9]+]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@foo
; CGSCC-SAME: (i8* nocapture nofree writeonly [[PTR:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[TMP0:%.*]] = alloca [[STRUCT_TEST_A:%.*]], align 8
; CGSCC-NEXT:    br label [[CALL_BR:%.*]]
; CGSCC:       call.br:
; CGSCC-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_TEST_A]], %struct.test.a* [[TMP0]], i64 0, i32 2
; CGSCC-NEXT:    store i8* [[PTR]], i8** [[TMP1]], align 8
; CGSCC-NEXT:    tail call void @bar(%struct.test.a* noalias nocapture nofree noundef nonnull readnone byval([[STRUCT_TEST_A]]) align 8 dereferenceable(24) [[TMP0]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret void
;
entry:
  %0 = alloca %struct.test.a, align 8
  br label %call.br

call.br:
  %1 = getelementptr inbounds %struct.test.a, %struct.test.a* %0, i64 0, i32 2
  store i8* %ptr, i8** %1
  tail call void @bar(%struct.test.a* noundef byval(%struct.test.a) align 8 %0)
  ret void
}

define void @bar(%struct.test.a* noundef byval(%struct.test.a) align 8 %dev) {
; CHECK: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@bar
; CHECK-SAME: (%struct.test.a* noalias nocapture nofree noundef nonnull writeonly byval([[STRUCT_TEST_A:%.*]]) align 8 dereferenceable(24) [[DEV:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT_TEST_A]], %struct.test.a* [[DEV]], i64 0, i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[STRUCT_TEST_B:%.*]], %struct.test.b* [[TMP1]], i64 0, i32 1
; CHECK-NEXT:    store i32 1, i32* [[TMP2]], align 4
; CHECK-NEXT:    ret void
;
  %1 = getelementptr inbounds %struct.test.a, %struct.test.a* %dev, i64 0, i32 0
  %2 = getelementptr inbounds %struct.test.b, %struct.test.b* %1, i64 0, i32 1
  store i32 1, i32* %2
  ret void
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; TUNIT: attributes #[[ATTR1]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR2]] = { nofree nosync nounwind willreturn writeonly }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR1]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR2]] = { nounwind willreturn writeonly }
;.