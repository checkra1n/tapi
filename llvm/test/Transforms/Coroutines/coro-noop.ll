; Tests that CoroEarly pass correctly lowers coro.noop
; RUN: opt < %s -S -passes=coro-early | FileCheck %s

; CHECK: %NoopCoro.Frame = type { void (%NoopCoro.Frame*)*, void (%NoopCoro.Frame*)* }
; CHECK: @NoopCoro.Frame.Const = private constant %NoopCoro.Frame { void (%NoopCoro.Frame*)* @__NoopCoro_ResumeDestroy, void (%NoopCoro.Frame*)* @__NoopCoro_ResumeDestroy }


; CHECK-LABEL: @noop(
define i8* @noop() {
; CHECK-NEXT: entry
entry:
; CHECK-NEXT: ret i8* bitcast (%NoopCoro.Frame* @NoopCoro.Frame.Const to i8*)
  %n = call i8* @llvm.coro.noop()
  ret i8* %n
}

declare i8* @llvm.coro.noop()

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "hand-written", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "<stdin>", directory: "")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}


; CHECK: define private fastcc void @__NoopCoro_ResumeDestroy(%NoopCoro.Frame* %0) !dbg ![[RESUME:[0-9]+]] {
; CHECK-NEXT: entry
; CHECK-NEXT:    ret void

; CHECK: ![[RESUME]] = distinct !DISubprogram(name: "__NoopCoro_ResumeDestroy", linkageName: "__NoopCoro_ResumeDestroy", {{.*}} flags: DIFlagArtificial,
