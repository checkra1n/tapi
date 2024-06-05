; RUN: llc -filetype=obj < %s | llvm-dwarfdump -debug-info -c -n S -n C0 -n C1 -n s -n E -n foo - \
; RUN:   | FileCheck %s --implicit-check-not=DW_TAG

; Generated by clang++ -c -g -std=c++11 -S -emit-llvm from the following C++11 source
; struct S {
;   char x;
;   alignas(128) char xx;
; };
;
; class alignas(64) C0 {
; };
;
; class C1 {
;   alignas(64) static void *p;
; };
;
; enum alignas(16) E {
;   A,
;   B,
;   C,
; };
;
; C0 c0;
;
; alignas(2048) S s;
;
; void foo()
; {
;     S ss;
;     E e;
;     C1 c1;
;     alignas(32) int i = 42;
;     auto Lambda = [i](){};
; }

; CHECK:   DW_TAG_class_type
; CHECK:     DW_AT_name{{.*}}"C0"
; CHECK:     DW_AT_alignment{{.*}}64

; CHECK:   DW_TAG_variable
; CHECK:     DW_AT_name{{.*}}"s"
; CHECK:     DW_AT_alignment{{.*}}2048

; CHECK:   DW_TAG_structure_type
; CHECK:     DW_TAG_member
; CHECK:     DW_TAG_member
; CHECK:       DW_AT_name{{.*}}"xx"
; CHECK:       DW_AT_alignment{{.*}}128

; CHECK:   DW_TAG_enumeration_type
; CHECK:     DW_AT_alignment{{.*}}16
; CHECK:       DW_TAG_enumerator
; CHECK:       DW_TAG_enumerator
; CHECK:       DW_TAG_enumerator

; CHECK:   DW_TAG_subprogram
; CHECK:     DW_TAG_variable
; CHECK:     DW_TAG_variable
; CHECK:     DW_TAG_variable
; CHECK:     DW_TAG_variable
; CHECK:       DW_AT_name{{.*}}"i"
; CHECK:       DW_AT_alignment{{.*}}32
; CHECK:     DW_TAG_variable
; CHECK:     DW_TAG_class_type
; CHECK:       DW_TAG_member
; CHECK:         DW_AT_name{{.*}}"i"
; CHECK:         DW_AT_alignment{{.*}}32
; CHECK:       DW_TAG_subprogram
; CHECK:         DW_TAG_formal_parameter

; CHECK:   DW_TAG_class_type
; CHECK:     DW_AT_name{{.*}}"C1"
; CHECK:     DW_TAG_member
; CHECK:       DW_AT_name{{.*}}"p"
; CHECK:       DW_AT_alignment{{.*}}64

; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.C0 = type { [64 x i8] }
%struct.S = type { i8, [127 x i8], i8, [127 x i8] }
%class.C1 = type { i8 }
%class.anon = type { i32 }

@c0 = global %class.C0 zeroinitializer, align 64, !dbg !0
@s = global %struct.S zeroinitializer, align 2048, !dbg !12

; Function Attrs: nounwind uwtable
define void @_Z3foov() #0 !dbg !24 {
entry:
  %ss = alloca %struct.S, align 128
  %e = alloca i32, align 16
  %c1 = alloca %class.C1, align 1
  %i = alloca i32, align 32
  %Lambda = alloca %class.anon, align 4
  call void @llvm.dbg.declare(metadata %struct.S* %ss, metadata !27, metadata !28), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %e, metadata !30, metadata !28), !dbg !31
  call void @llvm.dbg.declare(metadata %class.C1* %c1, metadata !32, metadata !28), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %i, metadata !38, metadata !28), !dbg !40
  store i32 42, i32* %i, align 32, !dbg !40
  call void @llvm.dbg.declare(metadata %class.anon* %Lambda, metadata !41, metadata !28), !dbg !50
  %0 = getelementptr inbounds %class.anon, %class.anon* %Lambda, i32 0, i32 0, !dbg !51
  %1 = load i32, i32* %i, align 32, !dbg !52
  store i32 %1, i32* %0, align 4, !dbg !51
  ret void, !dbg !53
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { nounwind uwtable }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!21, !22}
!llvm.ident = !{!23}

!0 = distinct !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = !DIGlobalVariable(name: "c0", scope: !2, file: !6, line: 19, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !3, producer: "clang version 4.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !11)
!3 = !DIFile(filename: "test.cpp", directory: "/tmp")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "E", file: !6, line: 13, size: 32, align: 128, elements: !7, identifier: "_ZTS1E")
!6 = !DIFile(filename: "./test.cpp", directory: "/tmp")
!7 = !{!8, !9, !10}
!8 = !DIEnumerator(name: "A", value: 0)
!9 = !DIEnumerator(name: "B", value: 1)
!10 = !DIEnumerator(name: "C", value: 2)
!11 = !{!0, !12}
!12 = distinct !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = !DIGlobalVariable(name: "s", scope: !2, file: !6, line: 21, type: !14, isLocal: false, isDefinition: true, align: 16384)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !6, line: 1, size: 2048, elements: !15, identifier: "_ZTS1S")
!15 = !{!16, !18}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !14, file: !6, line: 2, baseType: !17, size: 8)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "xx", scope: !14, file: !6, line: 3, baseType: !17, size: 8, align: 1024, offset: 1024)
!19 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C0", file: !6, line: 6, size: 512, align: 512, elements: !20, identifier: "_ZTS2C0")
!20 = !{}
!21 = !{i32 2, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{!"clang version 4.0.0"}
!24 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !6, file: !6, line: 23, type: !25, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !20)
!25 = !DISubroutineType(types: !26)
!26 = !{null}
!27 = !DILocalVariable(name: "ss", scope: !24, file: !6, line: 25, type: !14)
!28 = !DIExpression()
!29 = !DILocation(line: 25, column: 7, scope: !24)
!30 = !DILocalVariable(name: "e", scope: !24, file: !6, line: 26, type: !5)
!31 = !DILocation(line: 26, column: 7, scope: !24)
!32 = !DILocalVariable(name: "c1", scope: !24, file: !6, line: 27, type: !33)
!33 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C1", file: !6, line: 9, size: 8, elements: !34, identifier: "_ZTS2C1")
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !33, file: !6, line: 10, baseType: !36, align: 512, flags: DIFlagStaticMember)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!37 = !DILocation(line: 27, column: 8, scope: !24)
!38 = !DILocalVariable(name: "i", scope: !24, file: !6, line: 28, type: !39, align: 256)
!39 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!40 = !DILocation(line: 28, column: 21, scope: !24)
!41 = !DILocalVariable(name: "Lambda", scope: !24, file: !6, line: 29, type: !42)
!42 = distinct !DICompositeType(tag: DW_TAG_class_type, scope: !24, file: !6, line: 29, size: 32, elements: !43)
!43 = !{!44, !45}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !42, file: !6, line: 29, baseType: !39, size: 32, align: 256)
!45 = !DISubprogram(name: "operator()", scope: !42, file: !6, line: 29, type: !46, isLocal: false, isDefinition: false, scopeLine: 29, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!46 = !DISubroutineType(types: !47)
!47 = !{null, !48}
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!49 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!50 = !DILocation(line: 29, column: 10, scope: !24)
!51 = !DILocation(line: 29, column: 19, scope: !24)
!52 = !DILocation(line: 29, column: 20, scope: !24)
!53 = !DILocation(line: 30, column: 1, scope: !24)

