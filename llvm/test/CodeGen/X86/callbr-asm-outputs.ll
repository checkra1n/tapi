; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-- -verify-machineinstrs < %s | FileCheck %s

; A test for asm-goto output

define i32 @test1(i32 %x) {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    addl $4, %eax
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp .LBB0_2
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.1: # %normal
; CHECK-NEXT:    retl
; CHECK-NEXT:  .LBB0_2: # Block address taken
; CHECK-NEXT:    # %abnormal
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    retl
entry:
  %add = add nsw i32 %x, 4
  %ret = callbr i32 asm "xorl $1, $0; jmp ${2:l}", "=r,r,!i,~{dirflag},~{fpsr},~{flags}"(i32 %add)
          to label %normal [label %abnormal]

normal:
  ret i32 %ret

abnormal:
  ret i32 1
}

define i32 @test2(i32 %out1, i32 %out2) {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %edi
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %esi
; CHECK-NEXT:    movl $-1, %eax
; CHECK-NEXT:    cmpl %edi, %esi
; CHECK-NEXT:    jge .LBB1_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    #APP
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    testl %edi, %esi
; CHECK-NEXT:    jne .LBB1_4
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    jmp .LBB1_3
; CHECK-NEXT:  .LBB1_2: # %if.else
; CHECK-NEXT:    #APP
; CHECK-NEXT:    testl %esi, %edi
; CHECK-NEXT:    testl %esi, %edi
; CHECK-NEXT:    jne .LBB1_5
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  .LBB1_3:
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:  .LBB1_5: # Block address taken
; CHECK-NEXT:    # %return
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    retl
; CHECK-NEXT:  .LBB1_4: # Block address taken
; CHECK-NEXT:    # %label_true
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    movl $-2, %eax
; CHECK-NEXT:    jmp .LBB1_5
entry:
  %cmp = icmp slt i32 %out1, %out2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %0 = callbr { i32, i32 } asm sideeffect "testl $0, $0; testl $1, $2; jne ${3:l}", "={si},={di},r,!i,!i,0,1,~{dirflag},~{fpsr},~{flags}"(i32 %out1, i32 %out1, i32 %out2)
          to label %if.end [label %label_true, label %return]

if.else:                                          ; preds = %entry
  %1 = callbr { i32, i32 } asm sideeffect "testl $0, $1; testl $2, $3; jne ${5:l}", "={si},={di},r,r,!i,!i,0,1,~{dirflag},~{fpsr},~{flags}"(i32 %out1, i32 %out2, i32 %out1, i32 %out2)
          to label %if.end [label %label_true, label %return]

if.end:                                           ; preds = %if.else, %if.then
  %.sink11 = phi { i32, i32 } [ %0, %if.then ], [ %1, %if.else ]
  %asmresult3 = extractvalue { i32, i32 } %.sink11, 0
  %asmresult4 = extractvalue { i32, i32 } %.sink11, 1
  %add = add nsw i32 %asmresult4, %asmresult3
  br label %return

label_true:                                       ; preds = %if.else, %if.then
  br label %return

return:                                           ; preds = %if.then, %if.else, %label_true, %if.end
  %retval.0 = phi i32 [ %add, %if.end ], [ -2, %label_true ], [ -1, %if.else ], [ -1, %if.then ]
  ret i32 %retval.0
}

define i32 @test3(i1 %cmp) {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    testb $1, {{[0-9]+}}(%esp)
; CHECK-NEXT:    je .LBB2_3
; CHECK-NEXT:  # %bb.1: # %true
; CHECK-NEXT:    #APP
; CHECK-NEXT:    .short %esi
; CHECK-NEXT:    .short %edi
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    jmp .LBB2_5
; CHECK-NEXT:  .LBB2_3: # %false
; CHECK-NEXT:    #APP
; CHECK-NEXT:    .short %eax
; CHECK-NEXT:    .short %edx
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.4:
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:  .LBB2_5: # %asm.fallthrough
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    retl
; CHECK-NEXT:  .LBB2_6: # Block address taken
; CHECK-NEXT:    # %indirect
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    movl $42, %eax
; CHECK-NEXT:    jmp .LBB2_5
entry:
  br i1 %cmp, label %true, label %false

true:
  %0 = callbr { i32, i32 } asm sideeffect ".word $0, $1", "={si},={di},!i" () to label %asm.fallthrough [label %indirect]

false:
  %1 = callbr { i32, i32 } asm sideeffect ".word $0, $1", "={ax},={dx},!i" () to label %asm.fallthrough [label %indirect]

asm.fallthrough:
  %vals = phi { i32, i32 } [ %0, %true ], [ %1, %false ]
  %v = extractvalue { i32, i32 } %vals, 1
  ret i32 %v

indirect:
  ret i32 42
}

; Test 4 - asm-goto with output constraints.
define i32 @test4(i32 %out1, i32 %out2) {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl $-1, %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    #APP
; CHECK-NEXT:    testl %ecx, %ecx
; CHECK-NEXT:    testl %edx, %ecx
; CHECK-NEXT:    jne .LBB3_3
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.1: # %asm.fallthrough
; CHECK-NEXT:    #APP
; CHECK-NEXT:    testl %ecx, %edx
; CHECK-NEXT:    testl %ecx, %edx
; CHECK-NEXT:    jne .LBB3_4
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.2: # %asm.fallthrough2
; CHECK-NEXT:    addl %edx, %ecx
; CHECK-NEXT:    movl %ecx, %eax
; CHECK-NEXT:  .LBB3_4: # Block address taken
; CHECK-NEXT:    # %return
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    retl
; CHECK-NEXT:  .LBB3_3: # Block address taken
; CHECK-NEXT:    # %label_true
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    movl $-2, %eax
; CHECK-NEXT:    jmp .LBB3_4
entry:
  %0 = callbr { i32, i32 } asm sideeffect "testl $0, $0; testl $1, $2; jne ${3:l}", "=r,=r,r,!i,!i,~{dirflag},~{fpsr},~{flags}"(i32 %out1)
          to label %asm.fallthrough [label %label_true, label %return]

asm.fallthrough:                                  ; preds = %entry
  %asmresult = extractvalue { i32, i32 } %0, 0
  %asmresult1 = extractvalue { i32, i32 } %0, 1
  %1 = callbr { i32, i32 } asm sideeffect "testl $0, $1; testl $2, $3; jne ${5:l}", "=r,=r,r,r,!i,!i,~{dirflag},~{fpsr},~{flags}"(i32 %asmresult, i32 %asmresult1)
          to label %asm.fallthrough2 [label %label_true, label %return]

asm.fallthrough2:                                 ; preds = %asm.fallthrough
  %asmresult3 = extractvalue { i32, i32 } %1, 0
  %asmresult4 = extractvalue { i32, i32 } %1, 1
  %add = add nsw i32 %asmresult3, %asmresult4
  br label %return

label_true:                                       ; preds = %asm.fallthrough, %entry
  br label %return

return:                                           ; preds = %entry, %asm.fallthrough, %label_true, %asm.fallthrough2
  %retval.0 = phi i32 [ %add, %asm.fallthrough2 ], [ -2, %label_true ], [ -1, %asm.fallthrough ], [ -1, %entry ]
  ret i32 %retval.0
}

; Test5 - test that we don't rely on a positional constraint. ie. +r in
; GCCAsmStmt being turned into "={esp},0" since after D87279 they're turned
; into "={esp},{esp}". This previously caused an ICE; this test is more so
; about avoiding another ICE than what the actual output is.
define dso_local void @test5() {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  .LBB4_1: # Block address taken
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    retl
  %1 = call i32 @llvm.read_register.i32(metadata !3)
  %2 = callbr i32 asm "", "={esp},!i,{esp},~{dirflag},~{fpsr},~{flags}"(i32 %1)
          to label %3 [label %4]

3:
  call void @llvm.write_register.i32(metadata !3, i32 %2)
  br label %4

4:
  ret void
}

declare i32 @llvm.read_register.i32(metadata)
declare void @llvm.write_register.i32(metadata, i32)
!3 = !{!"esp"}
