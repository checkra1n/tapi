; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=13 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
;
; Test for multiple potential values
;
; potential-test 1
; bool iszero(int c) { return c == 0; }
; bool potential_test1(bool c) { return iszero(c ? 1 : -1); }

define internal i1 @iszero1(i32 %c) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@iszero1
; CGSCC-SAME: (i32 noundef [[C:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CGSCC-NEXT:    ret i1 [[CMP]]
;
  %cmp = icmp eq i32 %c, 0
  ret i1 %cmp
}

define i1 @potential_test1(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test1
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:    ret i1 false
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test1
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[ARG:%.*]] = select i1 [[C]], i32 -1, i32 1
; CGSCC-NEXT:    [[RET:%.*]] = call i1 @iszero1(i32 noundef [[ARG]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret i1 [[RET]]
;
  %arg = select i1 %c, i32 -1, i32 1
  %ret = call i1 @iszero1(i32 %arg)
  ret i1 %ret
}


; potential-test 2
;
; potential values of argument of iszero are {1,-1}
; potential value of returned value of iszero is 0
;
; int call_with_two_values(int x) { return iszero(x) + iszero(-x); }
; int potential_test2(int x) { return call_with_two_values(1) + call_with_two_values(-1); }

define internal i32 @iszero2(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@iszero2
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CHECK-NEXT:    [[RET:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp eq i32 %c, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

define internal i32 @call_with_two_values(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_with_two_values
; TUNIT-SAME: (i32 noundef [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET1:%.*]] = call i32 @iszero2(i32 noundef [[C]]) #[[ATTR1:[0-9]+]], !range [[RNG0:![0-9]+]]
; TUNIT-NEXT:    [[MINUSC:%.*]] = sub i32 0, [[C]]
; TUNIT-NEXT:    [[CSRET2:%.*]] = call i32 @iszero2(i32 [[MINUSC]]) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    [[RET:%.*]] = add i32 [[CSRET1]], [[CSRET2]]
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_with_two_values
; CGSCC-SAME: (i32 noundef [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET1:%.*]] = call i32 @iszero2(i32 noundef [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[MINUSC:%.*]] = sub i32 0, [[C]]
; CGSCC-NEXT:    [[CSRET2:%.*]] = call i32 @iszero2(i32 [[MINUSC]]) #[[ATTR2]]
; CGSCC-NEXT:    [[RET:%.*]] = add i32 [[CSRET1]], [[CSRET2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %csret1 = call i32 @iszero2(i32 %c)
  %minusc = sub i32 0, %c
  %csret2 = call i32 @iszero2(i32 %minusc)
  %ret = add i32 %csret1, %csret2
  ret i32 %ret
}

define i32 @potential_test2(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test2
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET1:%.*]] = call i32 @call_with_two_values(i32 noundef 1) #[[ATTR1]], !range [[RNG1:![0-9]+]]
; TUNIT-NEXT:    [[CSRET2:%.*]] = call i32 @call_with_two_values(i32 noundef -1) #[[ATTR1]], !range [[RNG1]]
; TUNIT-NEXT:    [[RET:%.*]] = add i32 [[CSRET1]], [[CSRET2]]
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test2
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET1:%.*]] = call i32 @call_with_two_values(i32 noundef 1) #[[ATTR2]]
; CGSCC-NEXT:    [[CSRET2:%.*]] = call i32 @call_with_two_values(i32 noundef -1) #[[ATTR2]]
; CGSCC-NEXT:    [[RET:%.*]] = add i32 [[CSRET1]], [[CSRET2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %csret1 = call i32 @call_with_two_values(i32 1)
  %csret2 = call i32 @call_with_two_values(i32 -1)
  %ret = add i32 %csret1, %csret2
  ret i32 %ret
}


; potential-test 3
;
; potential values of returned value of f are {0,1}
; potential values of argument of g are {0,1}
; potential value of returned value of g is 1
; then returned value of g can be simplified
;
; int zero_or_one(int c) { return c < 2; }
; int potential_test3() { return zero_or_one(iszero(0))+zero_or_one(iszero(1)); }

define internal i32 @iszero3(i32 %c) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@iszero3
; CGSCC-SAME: (i32 noundef [[C:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CGSCC-NEXT:    [[RET:%.*]] = zext i1 [[CMP]] to i32
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp eq i32 %c, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

define internal i32 @less_than_two(i32 %c) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@less_than_two
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:    [[CMP:%.*]] = icmp slt i32 [[C]], 2
; CGSCC-NEXT:    [[RET:%.*]] = zext i1 [[CMP]] to i32
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp slt i32 %c, 2
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

define i32 @potential_test3() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test3
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:    ret i32 2
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test3
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:    [[CMP1:%.*]] = call i32 @iszero3(i32 noundef 0) #[[ATTR2]]
; CGSCC-NEXT:    [[TRUE1:%.*]] = call i32 @less_than_two(i32 [[CMP1]]) #[[ATTR2]]
; CGSCC-NEXT:    [[CMP2:%.*]] = call i32 @iszero3(i32 noundef 1) #[[ATTR2]]
; CGSCC-NEXT:    [[TRUE2:%.*]] = call i32 @less_than_two(i32 [[CMP2]]) #[[ATTR2]]
; CGSCC-NEXT:    [[RET:%.*]] = add i32 [[TRUE1]], [[TRUE2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %cmp1 = call i32 @iszero3(i32 0)
  %true1 = call i32 @less_than_two(i32 %cmp1)
  %cmp2 = call i32 @iszero3(i32 1)
  %true2 = call i32 @less_than_two(i32 %cmp2)
  %ret = add i32 %true1, %true2
  ret i32 %ret
}


; potential-test 4,5
;
; simplified
; int potential_test4(int c) { return return1or3(c) == 2; }
; int potential_test5(int c) { return return1or3(c) == return2or4(c); }
;
; not simplified
; int potential_test6(int c) { return return1or3(c) == 3; }
; int potential_test7(int c) { return return1or3(c) == return3or4(c); }

define i32 @potential_test4(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test4
; TUNIT-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[FALSE:%.*]] = icmp eq i32 [[CSRET]], 2
; TUNIT-NEXT:    [[RET:%.*]] = zext i1 [[FALSE]] to i32
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test4
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[FALSE:%.*]] = icmp eq i32 [[CSRET]], 2
; CGSCC-NEXT:    [[RET:%.*]] = zext i1 [[FALSE]] to i32
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %csret = call i32 @return1or3(i32 %c)
  %false = icmp eq i32 %csret, 2
  %ret = zext i1 %false to i32
  ret i32 %ret
}

define i32 @potential_test5(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test5
; TUNIT-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[CSRET2:%.*]] = call i32 @return2or4(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[FALSE:%.*]] = icmp eq i32 [[CSRET1]], [[CSRET2]]
; TUNIT-NEXT:    [[RET:%.*]] = zext i1 [[FALSE]] to i32
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test5
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[CSRET2:%.*]] = call i32 @return2or4(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[FALSE:%.*]] = icmp eq i32 [[CSRET1]], [[CSRET2]]
; CGSCC-NEXT:    [[RET:%.*]] = zext i1 [[FALSE]] to i32
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %csret1 = call i32 @return1or3(i32 %c)
  %csret2 = call i32 @return2or4(i32 %c)
  %false = icmp eq i32 %csret1, %csret2
  %ret = zext i1 %false to i32
  ret i32 %ret
}

define i1 @potential_test6(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test6
; TUNIT-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[RET:%.*]] = icmp eq i32 [[CSRET1]], 3
; TUNIT-NEXT:    ret i1 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test6
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[RET:%.*]] = icmp eq i32 [[CSRET1]], 3
; CGSCC-NEXT:    ret i1 [[RET]]
;
  %csret1 = call i32 @return1or3(i32 %c)
  %ret = icmp eq i32 %csret1, 3
  ret i1 %ret
}

define i1 @potential_test7(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test7
; TUNIT-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[CSRET2:%.*]] = call i32 @return3or4(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[RET:%.*]] = icmp eq i32 [[CSRET1]], [[CSRET2]]
; TUNIT-NEXT:    ret i1 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test7
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[CSRET1:%.*]] = call i32 @return1or3(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[CSRET2:%.*]] = call i32 @return3or4(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[RET:%.*]] = icmp eq i32 [[CSRET1]], [[CSRET2]]
; CGSCC-NEXT:    ret i1 [[RET]]
;
  %csret1 = call i32 @return1or3(i32 %c)
  %csret2 = call i32 @return3or4(i32 %c)
  %ret = icmp eq i32 %csret1, %csret2
  ret i1 %ret
}

define internal i32 @return1or3(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@return1or3
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 1, i32 3
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp eq i32 %c, 0
  %ret = select i1 %cmp, i32 1, i32 3
  ret i32 %ret
}

define internal i32 @return2or4(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@return2or4
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 2, i32 4
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp eq i32 %c, 0
  %ret = select i1 %cmp, i32 2, i32 4
  ret i32 %ret
}

define internal i32 @return3or4(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@return3or4
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 3, i32 4
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp eq i32 %c, 0
  %ret = select i1 %cmp, i32 3, i32 4
  ret i32 %ret
}

; potential-test 8
;
; propagate argument to callsite argument

define internal i1 @cmp_with_four(i32 %c) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@cmp_with_four
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C]], 4
; CGSCC-NEXT:    ret i1 [[CMP]]
;
  %cmp = icmp eq i32 %c, 4
  ret i1 %cmp
}

define internal i1 @wrapper(i32 %c) {
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@wrapper
; CGSCC-SAME: (i32 noundef [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[RET:%.*]] = call i1 @cmp_with_four(i32 noundef [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    ret i1 [[RET]]
;
  %ret = call i1 @cmp_with_four(i32 %c)
  ret i1 %ret
}

define i1 @potential_test8() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test8
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:    ret i1 false
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test8
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:    [[RES1:%.*]] = call i1 @wrapper(i32 noundef 1) #[[ATTR2]]
; CGSCC-NEXT:    [[RES3:%.*]] = call i1 @wrapper(i32 noundef 3) #[[ATTR2]]
; CGSCC-NEXT:    [[RES5:%.*]] = call i1 @wrapper(i32 noundef 5) #[[ATTR2]]
; CGSCC-NEXT:    [[RES13:%.*]] = or i1 [[RES1]], [[RES3]]
; CGSCC-NEXT:    [[RES135:%.*]] = or i1 [[RES13]], [[RES5]]
; CGSCC-NEXT:    ret i1 [[RES135]]
;
  %res1 = call i1 @wrapper(i32 1)
  %res3 = call i1 @wrapper(i32 3)
  %res5 = call i1 @wrapper(i32 5)
  %res13 = or i1 %res1, %res3
  %res135 =  or i1 %res13, %res5
  ret i1 %res135
}

define i1 @potential_test9() {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@potential_test9
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[COND:%.*]]
; CHECK:       cond:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[I_1:%.*]], [[INC:%.*]] ]
; CHECK-NEXT:    [[C_0:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[C_1:%.*]], [[INC]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I_0]], 10
; CHECK-NEXT:    br i1 [[CMP]], label [[BODY:%.*]], label [[END:%.*]]
; CHECK:       body:
; CHECK-NEXT:    [[C_1]] = mul i32 [[C_0]], -1
; CHECK-NEXT:    br label [[INC]]
; CHECK:       inc:
; CHECK-NEXT:    [[I_1]] = add i32 [[I_0]], 1
; CHECK-NEXT:    br label [[COND]]
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = icmp eq i32 [[C_0]], 0
; CHECK-NEXT:    ret i1 [[RET]]
;
entry:
  br label %cond
cond:
  %i.0 = phi i32 [0, %entry], [%i.1, %inc]
  %c.0 = phi i32 [1, %entry], [%c.1, %inc]
  %cmp = icmp slt i32 %i.0, 10
  br i1 %cmp, label %body, label %end
body:
  %c.1 = mul i32 %c.0, -1
  br label %inc
inc:
  %i.1 = add i32 %i.0, 1
  br label %cond
end:
  %ret = icmp eq i32 %c.0, 0
  ret i1 %ret
}

; Test 10
; FIXME: potential returned values of @may_return_undef is {1, -1}
;        and returned value of @potential_test10 can be simplified to 0(false)

define internal i32 @may_return_undef(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@may_return_undef
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    switch i32 [[C]], label [[OTHERWISE:%.*]] [
; CHECK-NEXT:    i32 1, label [[A:%.*]]
; CHECK-NEXT:    i32 -1, label [[B:%.*]]
; CHECK-NEXT:    ]
; CHECK:       a:
; CHECK-NEXT:    ret i32 1
; CHECK:       b:
; CHECK-NEXT:    ret i32 -1
; CHECK:       otherwise:
; CHECK-NEXT:    ret i32 undef
;
  switch i32 %c, label %otherwise [i32 1, label %a
  i32 -1, label %b]
a:
  ret i32 1
b:
  ret i32 -1
otherwise:
  ret i32 undef
}

define i1 @potential_test10(i32 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test10
; TUNIT-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[RET:%.*]] = call i32 @may_return_undef(i32 [[C]]) #[[ATTR1]]
; TUNIT-NEXT:    [[CMP:%.*]] = icmp eq i32 [[RET]], 0
; TUNIT-NEXT:    ret i1 [[CMP]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test10
; CGSCC-SAME: (i32 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[RET:%.*]] = call i32 @may_return_undef(i32 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[RET]], 0
; CGSCC-NEXT:    ret i1 [[CMP]]
;
  %ret = call i32 @may_return_undef(i32 %c)
  %cmp = icmp eq i32 %ret, 0
  ret i1 %cmp
}

define i32 @optimize_undef_1(i1 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@optimize_undef_1
; CHECK-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    ret i32 0
; CHECK:       f:
; CHECK-NEXT:    [[UNDEF:%.*]] = add i32 undef, 1
; CHECK-NEXT:    ret i32 [[UNDEF]]
;
  br i1 %c, label %t, label %f
t:
  ret i32 0
f:
  %undef = add i32 undef, 1
  ret i32 %undef
}

define i32 @optimize_undef_2(i1 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@optimize_undef_2
; CHECK-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    ret i32 0
; CHECK:       f:
; CHECK-NEXT:    [[UNDEF:%.*]] = sub i32 undef, 1
; CHECK-NEXT:    ret i32 [[UNDEF]]
;
  br i1 %c, label %t, label %f
t:
  ret i32 0
f:
  %undef = sub i32 undef, 1
  ret i32 %undef
}

define i32 @optimize_undef_3(i1 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@optimize_undef_3
; CHECK-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    ret i32 0
; CHECK:       f:
; CHECK-NEXT:    [[UNDEF:%.*]] = icmp eq i32 undef, 0
; CHECK-NEXT:    [[UNDEF2:%.*]] = zext i1 [[UNDEF]] to i32
; CHECK-NEXT:    ret i32 [[UNDEF2]]
;
  br i1 %c, label %t, label %f
t:
  ret i32 0
f:
  %undef = icmp eq i32 undef, 0
  %undef2 = zext i1 %undef to i32
  ret i32 %undef2
}


; FIXME: returned value can be simplified to 0
define i32 @potential_test11(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test11
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[ZERO1:%.*]] = call i32 @optimize_undef_1(i1 [[C]]) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    [[ZERO2:%.*]] = call i32 @optimize_undef_2(i1 [[C]]) #[[ATTR1]], !range [[RNG2:![0-9]+]]
; TUNIT-NEXT:    [[ZERO3:%.*]] = call i32 @optimize_undef_3(i1 [[C]]) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    [[ACC1:%.*]] = add i32 [[ZERO1]], [[ZERO2]]
; TUNIT-NEXT:    [[ACC2:%.*]] = add i32 [[ACC1]], [[ZERO3]]
; TUNIT-NEXT:    ret i32 [[ACC2]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test11
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[ZERO1:%.*]] = call i32 @optimize_undef_1(i1 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[ZERO2:%.*]] = call i32 @optimize_undef_2(i1 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[ZERO3:%.*]] = call i32 @optimize_undef_3(i1 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    [[ACC1:%.*]] = add i32 [[ZERO1]], [[ZERO2]]
; CGSCC-NEXT:    [[ACC2:%.*]] = add i32 [[ACC1]], [[ZERO3]]
; CGSCC-NEXT:    ret i32 [[ACC2]]
;
  %zero1 = call i32 @optimize_undef_1(i1 %c)
  %zero2 = call i32 @optimize_undef_2(i1 %c)
  %zero3 = call i32 @optimize_undef_3(i1 %c)
  %acc1 = add i32 %zero1, %zero2
  %acc2 = add i32 %acc1, %zero3
  ret i32 %acc2
}

define i32 @optimize_poison_1(i1 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@optimize_poison_1
; CHECK-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    ret i32 0
; CHECK:       f:
; CHECK-NEXT:    [[POISON:%.*]] = sub nuw i32 0, 1
; CHECK-NEXT:    ret i32 [[POISON]]
;
  br i1 %c, label %t, label %f
t:
  ret i32 0
f:
  %poison = sub nuw i32 0, 1
  ret i32 %poison
}

; FIXME: returned value can be simplified to 0
define i32 @potential_test12(i1 %c) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test12
; TUNIT-SAME: (i1 [[C:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    ret i32 0
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test12
; CGSCC-SAME: (i1 [[C:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[ZERO:%.*]] = call i32 @optimize_poison_1(i1 [[C]]) #[[ATTR2]]
; CGSCC-NEXT:    ret i32 [[ZERO]]
;
  %zero = call i32 @optimize_poison_1(i1 %c)
  ret i32 %zero
}

; Test 13
; Do not simplify %ret in the callee to `%c`.
; The potential value of %c is {0, 1} (undef is merged).
; However, we should not simplify `and i32 %c, 3` to `%c`

define internal i32 @potential_test13_callee(i32 %c) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@potential_test13_callee
; CHECK-SAME: (i32 [[C:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[RET:%.*]] = and i32 [[C]], 3
; CHECK-NEXT:    ret i32 [[RET]]
;
  %ret = and i32 %c, 3
  ret i32 %ret
}

define i32 @potential_test13_caller1() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test13_caller1
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 noundef 0) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test13_caller1
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 noundef 0) #[[ATTR2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %ret = call i32 @potential_test13_callee(i32 0)
  ret i32 %ret
}

define i32 @potential_test13_caller2() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test13_caller2
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 noundef 1) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test13_caller2
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 noundef 1) #[[ATTR2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %ret = call i32 @potential_test13_callee(i32 1)
  ret i32 %ret
}

define i32 @potential_test13_caller3() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@potential_test13_caller3
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 undef) #[[ATTR1]], !range [[RNG0]]
; TUNIT-NEXT:    ret i32 [[RET]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@potential_test13_caller3
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:    [[RET:%.*]] = call i32 @potential_test13_callee(i32 undef) #[[ATTR2]]
; CGSCC-NEXT:    ret i32 [[RET]]
;
  %ret = call i32 @potential_test13_callee(i32 undef)
  ret i32 %ret
}

define i1 @potential_test14(i1 %c0, i1 %c1, i1 %c2, i1 %c3) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@potential_test14
; CHECK-SAME: (i1 [[C0:%.*]], i1 [[C1:%.*]], i1 [[C2:%.*]], i1 [[C3:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[X0:%.*]] = select i1 [[C0]], i32 0, i32 1
; CHECK-NEXT:    [[X1:%.*]] = select i1 [[C1]], i32 [[X0]], i32 undef
; CHECK-NEXT:    [[Y2:%.*]] = select i1 [[C2]], i32 0, i32 7
; CHECK-NEXT:    [[Z3:%.*]] = select i1 [[C3]], i32 [[X1]], i32 [[Y2]]
; CHECK-NEXT:    [[RET:%.*]] = icmp slt i32 [[Z3]], 7
; CHECK-NEXT:    ret i1 [[RET]]
;
  %x0 = select i1 %c0, i32 0, i32 1
  %x1 = select i1 %c1, i32 %x0, i32 undef
  %y2 = select i1 %c2, i32 0, i32 7
  %z3 = select i1 %c3, i32 %x1, i32 %y2
  %ret = icmp slt i32 %z3, 7
  ret i1 %ret
}

define i1 @potential_test15(i1 %c0, i1 %c1) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@potential_test15
; CHECK-SAME: (i1 [[C0:%.*]], i1 [[C1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[X0:%.*]] = select i1 [[C0]], i32 0, i32 1
; CHECK-NEXT:    [[X1:%.*]] = select i1 [[C1]], i32 [[X0]], i32 undef
; CHECK-NEXT:    [[RET:%.*]] = icmp eq i32 [[X1]], 7
; CHECK-NEXT:    ret i1 [[RET]]
;
  %x0 = select i1 %c0, i32 0, i32 1
  %x1 = select i1 %c1, i32 %x0, i32 undef
  %ret = icmp eq i32 %x1, 7
  ret i1 %ret
}

define i1 @potential_test16(i1 %c0, i1 %c1) {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@potential_test16
; CHECK-SAME: (i1 [[C0:%.*]], i1 [[C1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[X1:%.*]] = select i1 [[C1]], i32 0, i32 1
; CHECK-NEXT:    [[RET:%.*]] = icmp eq i32 [[X1]], 7
; CHECK-NEXT:    ret i1 [[RET]]
;
  %x0 = select i1 %c0, i32 0, i32 undef
  %x1 = select i1 %c1, i32 %x0, i32 1
  %ret = icmp eq i32 %x1, 7
  ret i1 %ret
}

;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; TUNIT: attributes #[[ATTR1]] = { nofree nosync nounwind readnone willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR1]] = { nofree nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR2]] = { readnone willreturn }
;.
; TUNIT: [[RNG0]] = !{i32 0, i32 2}
; TUNIT: [[RNG1]] = !{i32 0, i32 3}
; TUNIT: [[RNG2]] = !{i32 -1, i32 1}
;.
