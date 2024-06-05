; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64_be -o - %s | FileCheck %s --check-prefix CHECK-BE
; RUN: llc -mtriple=aarch64 -o - %s | FileCheck %s --check-prefix CHECK-LE

define i8 @test1(i32 %a, i8* %pa) {
; CHECK-BE-LABEL: test1:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    mov w8, w0
; CHECK-BE-NEXT:    lsr w0, w0, #24
; CHECK-BE-NEXT:    str w8, [x1]
; CHECK-BE-NEXT:    ret
;
; CHECK-LE-LABEL: test1:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    str w0, [x1]
; CHECK-LE-NEXT:    ret
  %p32 = bitcast i8* %pa to i32*
  %p8 = getelementptr i8, i8* %pa, i32 0
  store i32 %a, i32* %p32
  %res = load i8, i8* %p8
  ret i8 %res
}

define i8 @test2(i32 %a, i8* %pa) {
; CHECK-BE-LABEL: test2:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    str w0, [x1]
; CHECK-BE-NEXT:    ldrb w0, [x1, #1]
; CHECK-BE-NEXT:    ret
;
; CHECK-LE-LABEL: test2:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    str w0, [x1]
; CHECK-LE-NEXT:    ubfx w0, w0, #8, #8
; CHECK-LE-NEXT:    ret
  %p32 = bitcast i8* %pa to i32*
  %p8 = getelementptr i8, i8* %pa, i32 1
  store i32 %a, i32* %p32
  %res = load i8, i8* %p8
  ret i8 %res
}

define i8 @test3(i32 %a, i8* %pa) {
; CHECK-BE-LABEL: test3:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    str w0, [x1]
; CHECK-BE-NEXT:    ldrb w0, [x1, #2]
; CHECK-BE-NEXT:    ret
;
; CHECK-LE-LABEL: test3:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    str w0, [x1]
; CHECK-LE-NEXT:    ubfx w0, w0, #16, #8
; CHECK-LE-NEXT:    ret
  %p32 = bitcast i8* %pa to i32*
  %p8 = getelementptr i8, i8* %pa, i32 2
  store i32 %a, i32* %p32
  %res = load i8, i8* %p8
  ret i8 %res
}

define i8 @test4(i32 %a, i8* %pa) {
; CHECK-BE-LABEL: test4:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    str w0, [x1]
; CHECK-BE-NEXT:    ret
;
; CHECK-LE-LABEL: test4:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    str w0, [x1]
; CHECK-LE-NEXT:    lsr w0, w0, #24
; CHECK-LE-NEXT:    ret
  %p32 = bitcast i8* %pa to i32*
  %p8 = getelementptr i8, i8* %pa, i32 3
  store i32 %a, i32* %p32
  %res = load i8, i8* %p8
  ret i8 %res
}