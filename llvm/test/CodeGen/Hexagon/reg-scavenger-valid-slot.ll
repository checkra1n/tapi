; RUN: llc -march=hexagon < %s
; REQUIRES: asserts

; This testcase tries to force spills of both vector and int registers
; in a function where scavenging slots were reserved for both register
; classes. The original problem was that the scavenger selected an int
; slot (with size/alignment of 4) for a vector register (with size/
; alignment of 64). This caused an assertion in the assembler printer
; due to an offset in a vector store having unexpected low-order bits.

; We cannot directly whether the bits appear or not, since they will be
; truncated off by the time we see the output, but we can check that
; we got to the end of the function without crashing.

; CHECK: endloop
; CHECK: dealloc_return

target triple = "hexagon"

define void @foo(<16 x i32>* nocapture readnone %p) #0 {
entry:
  %0 = tail call { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } asm "nop", "=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r,=r"() #1
  %asmresult = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 0
  %asmresult1 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 1
  %asmresult2 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 2
  %asmresult3 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 3
  %asmresult4 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 4
  %asmresult5 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 5
  %asmresult6 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 6
  %asmresult7 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 7
  %asmresult8 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 8
  %asmresult9 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 9
  %asmresult10 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 10
  %asmresult11 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 11
  %asmresult12 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 12
  %asmresult13 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 13
  %asmresult14 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 14
  %asmresult15 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 15
  %asmresult16 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 16
  %asmresult17 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 17
  %asmresult18 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 18
  %asmresult19 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 19
  %asmresult20 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 20
  %asmresult21 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 21
  %asmresult22 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 22
  %asmresult23 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 23
  %asmresult24 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 24
  %asmresult25 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 25
  %asmresult26 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 26
  %asmresult27 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 27
  %asmresult28 = extractvalue { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 } %0, 28
  %1 = tail call { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } asm "nop", "=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v,=v"() #1
  %asmresult29 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 0
  %asmresult30 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 1
  %asmresult31 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 2
  %asmresult32 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 3
  %asmresult33 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 4
  %asmresult34 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 5
  %asmresult35 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 6
  %asmresult36 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 7
  %asmresult37 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 8
  %asmresult38 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 9
  %asmresult39 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 10
  %asmresult40 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 11
  %asmresult41 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 12
  %asmresult42 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 13
  %asmresult43 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 14
  %asmresult44 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 15
  %asmresult45 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 16
  %asmresult46 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 17
  %asmresult47 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 18
  %asmresult48 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 19
  %asmresult49 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 20
  %asmresult50 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 21
  %asmresult51 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 22
  %asmresult52 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 23
  %asmresult53 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 24
  %asmresult54 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 25
  %asmresult55 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 26
  %asmresult56 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 27
  %asmresult57 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 28
  %asmresult58 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 29
  %asmresult59 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 30
  %asmresult60 = extractvalue { <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32>, <16 x i32> } %1, 31
  %2 = tail call { <64 x i1>, <64 x i1>, <64 x i1>, <64 x i1> } asm "nop", "=q,=q,=q,=q"() #1
  %asmresult61 = extractvalue { <64 x i1>, <64 x i1>, <64 x i1>, <64 x i1> } %2, 0
  %asmresult62 = extractvalue { <64 x i1>, <64 x i1>, <64 x i1>, <64 x i1> } %2, 1
  %asmresult63 = extractvalue { <64 x i1>, <64 x i1>, <64 x i1>, <64 x i1> } %2, 2
  %asmresult64 = extractvalue { <64 x i1>, <64 x i1>, <64 x i1>, <64 x i1> } %2, 3
  %3 = tail call <64 x i1> asm "nop", "=q,q,q,q,q"(<64 x i1> %asmresult61, <64 x i1> %asmresult62, <64 x i1> %asmresult63, <64 x i1> %asmresult64) #1
  tail call void asm sideeffect "nop", "q,q,q"(<64 x i1> %asmresult61, <64 x i1> %asmresult62, <64 x i1> %asmresult63) #2
  tail call void asm sideeffect "nop", "q,q"(<64 x i1> %asmresult64, <64 x i1> %3) #2
  tail call void asm sideeffect "nop", "v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v"(<16 x i32> %asmresult29, <16 x i32> %asmresult30, <16 x i32> %asmresult31, <16 x i32> %asmresult32, <16 x i32> %asmresult33, <16 x i32> %asmresult34, <16 x i32> %asmresult35, <16 x i32> %asmresult36, <16 x i32> %asmresult37, <16 x i32> %asmresult38, <16 x i32> %asmresult39, <16 x i32> %asmresult40, <16 x i32> %asmresult41, <16 x i32> %asmresult42, <16 x i32> %asmresult43, <16 x i32> %asmresult44, <16 x i32> %asmresult45, <16 x i32> %asmresult46, <16 x i32> %asmresult47, <16 x i32> %asmresult48, <16 x i32> %asmresult49, <16 x i32> %asmresult50, <16 x i32> %asmresult51, <16 x i32> %asmresult52, <16 x i32> %asmresult53, <16 x i32> %asmresult54, <16 x i32> %asmresult55, <16 x i32> %asmresult56, <16 x i32> %asmresult57, <16 x i32> %asmresult58, <16 x i32> %asmresult59, <16 x i32> %asmresult60) #2
  tail call void asm sideeffect "nop", "r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r"(i32 %asmresult, i32 %asmresult1, i32 %asmresult2, i32 %asmresult3, i32 %asmresult4, i32 %asmresult5, i32 %asmresult6, i32 %asmresult7, i32 %asmresult8, i32 %asmresult9, i32 %asmresult10, i32 %asmresult11, i32 %asmresult12, i32 %asmresult13, i32 %asmresult14, i32 %asmresult15, i32 %asmresult16, i32 %asmresult17, i32 %asmresult18, i32 %asmresult19, i32 %asmresult20, i32 %asmresult21, i32 %asmresult22, i32 %asmresult23, i32 %asmresult24, i32 %asmresult25, i32 %asmresult26, i32 %asmresult27, i32 %asmresult28) #2
  ret void
}

attributes #0 = { nounwind "target-cpu"="hexagonv60" "target-features"="+hvxv60,+hvx-length64b" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }
