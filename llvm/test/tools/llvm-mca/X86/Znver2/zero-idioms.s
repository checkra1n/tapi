# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=znver2 -timeline -register-file-stats -iterations=1 < %s | FileCheck %s

subl  %eax, %eax
subq  %rax, %rax
xorl  %eax, %eax
xorq  %rax, %rax

pcmpgtb   %mm2, %mm2
pcmpgtd   %mm2, %mm2
# pcmpgtq   %mm2, %mm2 # invalid operand for instruction
pcmpgtw   %mm2, %mm2

pcmpgtb   %xmm2, %xmm2
pcmpgtd   %xmm2, %xmm2
pcmpgtq   %xmm2, %xmm2
pcmpgtw   %xmm2, %xmm2

vpcmpgtb  %xmm3, %xmm3, %xmm3
vpcmpgtd  %xmm3, %xmm3, %xmm3
vpcmpgtq  %xmm3, %xmm3, %xmm3
vpcmpgtw  %xmm3, %xmm3, %xmm3

vpcmpgtb  %xmm3, %xmm3, %xmm5
vpcmpgtd  %xmm3, %xmm3, %xmm5
vpcmpgtq  %xmm3, %xmm3, %xmm5
vpcmpgtw  %xmm3, %xmm3, %xmm5

vpcmpgtb  %ymm3, %ymm3, %ymm3
vpcmpgtd  %ymm3, %ymm3, %ymm3
vpcmpgtq  %ymm3, %ymm3, %ymm3
vpcmpgtw  %ymm3, %ymm3, %ymm3

vpcmpgtb  %ymm3, %ymm3, %ymm5
vpcmpgtd  %ymm3, %ymm3, %ymm5
vpcmpgtq  %ymm3, %ymm3, %ymm5
vpcmpgtw  %ymm3, %ymm3, %ymm5

psubb   %mm2, %mm2
psubd   %mm2, %mm2
psubq   %mm2, %mm2
psubw   %mm2, %mm2
psubb   %xmm2, %xmm2
psubd   %xmm2, %xmm2
psubq   %xmm2, %xmm2
psubw   %xmm2, %xmm2
vpsubb  %xmm3, %xmm3, %xmm3
vpsubd  %xmm3, %xmm3, %xmm3
vpsubq  %xmm3, %xmm3, %xmm3
vpsubw  %xmm3, %xmm3, %xmm3
vpsubb  %ymm3, %ymm3, %ymm3
vpsubd  %ymm3, %ymm3, %ymm3
vpsubq  %ymm3, %ymm3, %ymm3
vpsubw  %ymm3, %ymm3, %ymm3

vpsubb  %xmm3, %xmm3, %xmm5
vpsubd  %xmm3, %xmm3, %xmm5
vpsubq  %xmm3, %xmm3, %xmm5
vpsubw  %xmm3, %xmm3, %xmm5
vpsubb  %ymm3, %ymm3, %ymm5
vpsubd  %ymm3, %ymm3, %ymm5
vpsubq  %ymm3, %ymm3, %ymm5
vpsubw  %ymm3, %ymm3, %ymm5

andnps  %xmm0, %xmm0
andnpd  %xmm1, %xmm1
vandnps %xmm2, %xmm2, %xmm2
vandnpd %xmm1, %xmm1, %xmm1
vandnps %ymm2, %ymm2, %ymm2
vandnpd %ymm1, %ymm1, %ymm1
pandn   %mm2, %mm2
pandn   %xmm2, %xmm2
vpandn  %xmm3, %xmm3, %xmm3
vpandn  %ymm3, %ymm3, %ymm3

vandnps %xmm2, %xmm2, %xmm5
vandnpd %xmm1, %xmm1, %xmm5
vpandn  %xmm3, %xmm3, %xmm5
vandnps %ymm2, %ymm2, %ymm5
vandnpd %ymm1, %ymm1, %ymm5
vpandn  %ymm3, %ymm3, %ymm5

xorps  %xmm0, %xmm0
xorpd  %xmm1, %xmm1
vxorps %xmm2, %xmm2, %xmm2
vxorpd %xmm1, %xmm1, %xmm1
vxorps %ymm2, %ymm2, %ymm2
vxorpd %ymm1, %ymm1, %ymm1
pxor   %mm2, %mm2
pxor   %xmm2, %xmm2
vpxor  %xmm3, %xmm3, %xmm3
vpxor  %ymm3, %ymm3, %ymm3

vxorps %xmm4, %xmm4, %xmm5
vxorpd %xmm1, %xmm1, %xmm3
vxorps %ymm4, %ymm4, %ymm5
vxorpd %ymm1, %ymm1, %ymm3
vpxor  %xmm3, %xmm3, %xmm5
vpxor  %ymm3, %ymm3, %ymm5

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      83
# CHECK-NEXT: Total Cycles:      27
# CHECK-NEXT: Total uOps:        83

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    3.07
# CHECK-NEXT: IPC:               3.07
# CHECK-NEXT: Block RThroughput: 20.8

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.25                        subl	%eax, %eax
# CHECK-NEXT:  1      1     0.25                        subq	%rax, %rax
# CHECK-NEXT:  1      1     0.25                        xorl	%eax, %eax
# CHECK-NEXT:  1      1     0.25                        xorq	%rax, %rax
# CHECK-NEXT:  1      1     0.33                        pcmpgtb	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        pcmpgtd	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        pcmpgtw	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpcmpgtb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.50                        vpcmpgtq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpcmpgtb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpcmpgtd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.50                        vpcmpgtq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpcmpgtw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        psubb	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        psubd	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        psubq	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        psubw	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        psubb	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        psubd	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        psubq	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        psubw	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.25                        andnps	%xmm0, %xmm0
# CHECK-NEXT:  1      1     0.25                        andnpd	%xmm1, %xmm1
# CHECK-NEXT:  1      1     0.25                        vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  1      1     0.25                        vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  1      1     0.25                        vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  1      1     0.25                        vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  1      1     0.25                        pandn	%mm2, %mm2
# CHECK-NEXT:  1      1     0.25                        pandn	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.25                        vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.25                        vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.25                        vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT:  1      1     0.25                        vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT:  1      1     0.25                        vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.25                        vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT:  1      1     0.25                        vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT:  1      1     0.25                        vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.25                        xorps	%xmm0, %xmm0
# CHECK-NEXT:  1      1     0.25                        xorpd	%xmm1, %xmm1
# CHECK-NEXT:  1      1     0.25                        vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  1      1     0.25                        vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  1      1     0.25                        vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  1      1     0.25                        vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  1      1     0.25                        pxor	%mm2, %mm2
# CHECK-NEXT:  1      1     0.25                        pxor	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.25                        vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.25                        vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.25                        vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT:  1      1     0.25                        vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT:  1      1     0.25                        vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT:  1      1     0.25                        vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT:  1      1     0.25                        vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.25                        vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Register File statistics:
# CHECK-NEXT: Total number of mappings created:    0
# CHECK-NEXT: Max number of mappings used:         0

# CHECK:      *  Register File #1 -- Zn2FpuPRF:
# CHECK-NEXT:    Number of physical registers:     160
# CHECK-NEXT:    Total number of mappings created: 0
# CHECK-NEXT:    Max number of mappings used:      0

# CHECK:      *  Register File #2 -- Zn2IntegerPRF:
# CHECK-NEXT:    Number of physical registers:     168
# CHECK-NEXT:    Total number of mappings created: 0
# CHECK-NEXT:    Max number of mappings used:      0

# CHECK:      Resources:
# CHECK-NEXT: [0]   - Zn2AGU0
# CHECK-NEXT: [1]   - Zn2AGU1
# CHECK-NEXT: [2]   - Zn2AGU2
# CHECK-NEXT: [3]   - Zn2ALU0
# CHECK-NEXT: [4]   - Zn2ALU1
# CHECK-NEXT: [5]   - Zn2ALU2
# CHECK-NEXT: [6]   - Zn2ALU3
# CHECK-NEXT: [7]   - Zn2Divider
# CHECK-NEXT: [8]   - Zn2FPU0
# CHECK-NEXT: [9]   - Zn2FPU1
# CHECK-NEXT: [10]  - Zn2FPU2
# CHECK-NEXT: [11]  - Zn2FPU3
# CHECK-NEXT: [12]  - Zn2Multiplier

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -     22.00  23.00  12.00  22.00   -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT:  -      -      -      -      -      -     1.00    -      -      -      -      -      -     subl	%eax, %eax
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -      -      -      -      -      -     subq	%rax, %rax
# CHECK-NEXT:  -      -      -      -     1.00    -      -      -      -      -      -      -      -     xorl	%eax, %eax
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -      -      -      -     xorq	%rax, %rax
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     pcmpgtb	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     pcmpgtd	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     pcmpgtw	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpcmpgtb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpcmpgtq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpcmpgtw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpcmpgtd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpcmpgtq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpcmpgtw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     psubb	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     psubd	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     psubq	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     psubw	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     psubb	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     psubd	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     psubq	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     psubw	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     andnps	%xmm0, %xmm0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     andnpd	%xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     pandn	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     pandn	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     xorps	%xmm0, %xmm0
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     xorpd	%xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     pxor	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     pxor	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -      -      -      -     vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -     vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     1.00    -      -     vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -      -     vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          0123456

# CHECK:      [0,0]     DeER .    .    .    .    ..   subl	%eax, %eax
# CHECK-NEXT: [0,1]     DeER .    .    .    .    ..   subq	%rax, %rax
# CHECK-NEXT: [0,2]     DeER .    .    .    .    ..   xorl	%eax, %eax
# CHECK-NEXT: [0,3]     DeER .    .    .    .    ..   xorq	%rax, %rax
# CHECK-NEXT: [0,4]     .DeER.    .    .    .    ..   pcmpgtb	%mm2, %mm2
# CHECK-NEXT: [0,5]     .DeER.    .    .    .    ..   pcmpgtd	%mm2, %mm2
# CHECK-NEXT: [0,6]     .DeER.    .    .    .    ..   pcmpgtw	%mm2, %mm2
# CHECK-NEXT: [0,7]     .D=eER    .    .    .    ..   pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT: [0,8]     . DeER    .    .    .    ..   pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT: [0,9]     . DeER    .    .    .    ..   pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT: [0,10]    . D=eER   .    .    .    ..   pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT: [0,11]    . D=eER   .    .    .    ..   vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,12]    .  DeER   .    .    .    ..   vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,13]    .  D=eER  .    .    .    ..   vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,14]    .  D=eER  .    .    .    ..   vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,15]    .  D=eER  .    .    .    ..   vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,16]    .   D=eER .    .    .    ..   vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,17]    .   D=eER .    .    .    ..   vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,18]    .   D=eER .    .    .    ..   vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,19]    .   D==eER.    .    .    ..   vpcmpgtb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,20]    .    D=eER.    .    .    ..   vpcmpgtd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,21]    .    D=eER.    .    .    ..   vpcmpgtq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,22]    .    D==eER    .    .    ..   vpcmpgtw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,23]    .    D==eER    .    .    ..   vpcmpgtb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,24]    .    .D=eER    .    .    ..   vpcmpgtd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,25]    .    .D==eER   .    .    ..   vpcmpgtq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,26]    .    .D==eER   .    .    ..   vpcmpgtw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,27]    .    .D==eER   .    .    ..   psubb	%mm2, %mm2
# CHECK-NEXT: [0,28]    .    . D==eER  .    .    ..   psubd	%mm2, %mm2
# CHECK-NEXT: [0,29]    .    . D==eER  .    .    ..   psubq	%mm2, %mm2
# CHECK-NEXT: [0,30]    .    . D==eER  .    .    ..   psubw	%mm2, %mm2
# CHECK-NEXT: [0,31]    .    . D===eER .    .    ..   psubb	%xmm2, %xmm2
# CHECK-NEXT: [0,32]    .    .  D==eER .    .    ..   psubd	%xmm2, %xmm2
# CHECK-NEXT: [0,33]    .    .  D==eER .    .    ..   psubq	%xmm2, %xmm2
# CHECK-NEXT: [0,34]    .    .  D===eER.    .    ..   psubw	%xmm2, %xmm2
# CHECK-NEXT: [0,35]    .    .  D===eER.    .    ..   vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,36]    .    .   D==eER.    .    ..   vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,37]    .    .   D===eER    .    ..   vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,38]    .    .   D===eER    .    ..   vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,39]    .    .   D===eER    .    ..   vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,40]    .    .    D===eER   .    ..   vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,41]    .    .    D===eER   .    ..   vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,42]    .    .    D===eER   .    ..   vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,43]    .    .    D====eER  .    ..   vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,44]    .    .    .D===eER  .    ..   vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,45]    .    .    .D===eER  .    ..   vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,46]    .    .    .D====eER .    ..   vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,47]    .    .    .D====eER .    ..   vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,48]    .    .    . D===eER .    ..   vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,49]    .    .    . D====eER.    ..   vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,50]    .    .    . D====eER.    ..   vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,51]    .    .    . DeE----R.    ..   andnps	%xmm0, %xmm0
# CHECK-NEXT: [0,52]    .    .    .  DeE---R.    ..   andnpd	%xmm1, %xmm1
# CHECK-NEXT: [0,53]    .    .    .  D=eE--R.    ..   vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: [0,54]    .    .    .  D==eE-R.    ..   vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: [0,55]    .    .    .  D===eER.    ..   vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: [0,56]    .    .    .   D==eER.    ..   vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: [0,57]    .    .    .   D===eER    ..   pandn	%mm2, %mm2
# CHECK-NEXT: [0,58]    .    .    .   D===eER    ..   pandn	%xmm2, %xmm2
# CHECK-NEXT: [0,59]    .    .    .   D===eER    ..   vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,60]    .    .    .    D==eER    ..   vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,61]    .    .    .    D===eER   ..   vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT: [0,62]    .    .    .    D===eER   ..   vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT: [0,63]    .    .    .    D===eER   ..   vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,64]    .    .    .    .D==eER   ..   vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT: [0,65]    .    .    .    .D===eER  ..   vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT: [0,66]    .    .    .    .D===eER  ..   vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,67]    .    .    .    .D===eER  ..   xorps	%xmm0, %xmm0
# CHECK-NEXT: [0,68]    .    .    .    . D==eER  ..   xorpd	%xmm1, %xmm1
# CHECK-NEXT: [0,69]    .    .    .    . D===eER ..   vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: [0,70]    .    .    .    . D===eER ..   vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: [0,71]    .    .    .    . D===eER ..   vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: [0,72]    .    .    .    .  D==eER ..   vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: [0,73]    .    .    .    .  D===eER..   pxor	%mm2, %mm2
# CHECK-NEXT: [0,74]    .    .    .    .  D===eER..   pxor	%xmm2, %xmm2
# CHECK-NEXT: [0,75]    .    .    .    .  D===eER..   vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,76]    .    .    .    .   D==eER..   vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,77]    .    .    .    .   D===eER.   vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT: [0,78]    .    .    .    .   D===eER.   vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT: [0,79]    .    .    .    .   D===eER.   vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT: [0,80]    .    .    .    .    D==eER.   vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT: [0,81]    .    .    .    .    D===eER   vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,82]    .    .    .    .    D===eER   vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       subl	%eax, %eax
# CHECK-NEXT: 1.     1     1.0    1.0    0.0       subq	%rax, %rax
# CHECK-NEXT: 2.     1     1.0    1.0    0.0       xorl	%eax, %eax
# CHECK-NEXT: 3.     1     1.0    1.0    0.0       xorq	%rax, %rax
# CHECK-NEXT: 4.     1     1.0    1.0    0.0       pcmpgtb	%mm2, %mm2
# CHECK-NEXT: 5.     1     1.0    1.0    0.0       pcmpgtd	%mm2, %mm2
# CHECK-NEXT: 6.     1     1.0    1.0    0.0       pcmpgtw	%mm2, %mm2
# CHECK-NEXT: 7.     1     2.0    2.0    0.0       pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT: 8.     1     1.0    1.0    0.0       pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT: 9.     1     1.0    1.0    0.0       pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT: 10.    1     2.0    2.0    0.0       pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT: 11.    1     2.0    2.0    0.0       vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 12.    1     1.0    1.0    0.0       vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 13.    1     2.0    2.0    0.0       vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 14.    1     2.0    2.0    0.0       vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 15.    1     2.0    2.0    0.0       vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 16.    1     2.0    2.0    0.0       vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 17.    1     2.0    2.0    0.0       vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 18.    1     2.0    2.0    0.0       vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 19.    1     3.0    3.0    0.0       vpcmpgtb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 20.    1     2.0    2.0    0.0       vpcmpgtd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 21.    1     2.0    2.0    0.0       vpcmpgtq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 22.    1     3.0    3.0    0.0       vpcmpgtw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 23.    1     3.0    3.0    0.0       vpcmpgtb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 24.    1     2.0    2.0    0.0       vpcmpgtd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 25.    1     3.0    3.0    0.0       vpcmpgtq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 26.    1     3.0    3.0    0.0       vpcmpgtw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 27.    1     3.0    3.0    0.0       psubb	%mm2, %mm2
# CHECK-NEXT: 28.    1     3.0    3.0    0.0       psubd	%mm2, %mm2
# CHECK-NEXT: 29.    1     3.0    3.0    0.0       psubq	%mm2, %mm2
# CHECK-NEXT: 30.    1     3.0    3.0    0.0       psubw	%mm2, %mm2
# CHECK-NEXT: 31.    1     4.0    4.0    0.0       psubb	%xmm2, %xmm2
# CHECK-NEXT: 32.    1     3.0    3.0    0.0       psubd	%xmm2, %xmm2
# CHECK-NEXT: 33.    1     3.0    3.0    0.0       psubq	%xmm2, %xmm2
# CHECK-NEXT: 34.    1     4.0    4.0    0.0       psubw	%xmm2, %xmm2
# CHECK-NEXT: 35.    1     4.0    4.0    0.0       vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 36.    1     3.0    3.0    0.0       vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 37.    1     4.0    4.0    0.0       vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 38.    1     4.0    4.0    0.0       vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 39.    1     4.0    4.0    0.0       vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 40.    1     4.0    4.0    0.0       vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 41.    1     4.0    4.0    0.0       vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 42.    1     4.0    4.0    0.0       vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 43.    1     5.0    5.0    0.0       vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 44.    1     4.0    4.0    0.0       vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 45.    1     4.0    4.0    0.0       vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 46.    1     5.0    5.0    0.0       vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 47.    1     5.0    5.0    0.0       vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 48.    1     4.0    4.0    0.0       vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 49.    1     5.0    5.0    0.0       vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 50.    1     5.0    5.0    0.0       vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 51.    1     1.0    1.0    4.0       andnps	%xmm0, %xmm0
# CHECK-NEXT: 52.    1     1.0    1.0    3.0       andnpd	%xmm1, %xmm1
# CHECK-NEXT: 53.    1     2.0    2.0    2.0       vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: 54.    1     3.0    3.0    1.0       vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: 55.    1     4.0    4.0    0.0       vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: 56.    1     3.0    3.0    0.0       vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: 57.    1     4.0    4.0    0.0       pandn	%mm2, %mm2
# CHECK-NEXT: 58.    1     4.0    4.0    0.0       pandn	%xmm2, %xmm2
# CHECK-NEXT: 59.    1     4.0    4.0    0.0       vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 60.    1     3.0    3.0    0.0       vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 61.    1     4.0    4.0    0.0       vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT: 62.    1     4.0    4.0    0.0       vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT: 63.    1     4.0    4.0    0.0       vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 64.    1     3.0    3.0    0.0       vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT: 65.    1     4.0    4.0    0.0       vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT: 66.    1     4.0    4.0    0.0       vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 67.    1     4.0    4.0    0.0       xorps	%xmm0, %xmm0
# CHECK-NEXT: 68.    1     3.0    3.0    0.0       xorpd	%xmm1, %xmm1
# CHECK-NEXT: 69.    1     4.0    4.0    0.0       vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: 70.    1     4.0    4.0    0.0       vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: 71.    1     4.0    4.0    0.0       vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: 72.    1     3.0    3.0    0.0       vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: 73.    1     4.0    4.0    0.0       pxor	%mm2, %mm2
# CHECK-NEXT: 74.    1     4.0    4.0    0.0       pxor	%xmm2, %xmm2
# CHECK-NEXT: 75.    1     4.0    4.0    0.0       vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 76.    1     3.0    3.0    0.0       vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 77.    1     4.0    4.0    0.0       vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT: 78.    1     4.0    4.0    0.0       vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT: 79.    1     4.0    4.0    0.0       vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT: 80.    1     3.0    3.0    0.0       vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT: 81.    1     4.0    4.0    0.0       vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 82.    1     4.0    4.0    0.0       vpxor	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:        1     3.1    3.1    0.1       <total>
