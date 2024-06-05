// Checks errors generated by passing a bad value for --cuda-gpu-arch.
// REQUIRES: x86-registered-target
// REQUIRES: nvptx-registered-target
// REQUIRES: amdgpu-registered-target

// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=compute_20 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix BAD %s
// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=sm20 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix BAD %s
// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=sm_19 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix BAD %s
// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=gfx900 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix BAD %s

// BAD: error: unsupported CUDA gpu architecture

// RUN: %clang -### -v --target=x86_64-linux-gnu --cuda-gpu-arch=sm_21 \
// RUN:   --cuda-path=%S/Inputs/CUDA_90/usr/local/cuda %s 2>&1 \
// RUN: | FileCheck -check-prefix BAD_CUDA9 %s

// BAD_CUDA9: GPU arch sm_21 is supported by CUDA versions between 7.0 and 8.0

// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=sm_20 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s
// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=sm_52 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s
// RUN: %clang -### -x hip -target x86_64-linux-gnu --cuda-gpu-arch=gfx908 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s
// RUN: %clang -### -x hip -target x86_64-linux-gnu --cuda-gpu-arch=gfx90a -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s
// RUN: %clang -### -target x86_64-linux-gnu --cuda-gpu-arch=gfx940 -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s
// RUN: %clang -### -target x86_64-linux-gnu -c %s 2>&1 \
// RUN: | FileCheck -check-prefix OK %s

// We don't allow using NVPTX/AMDGCN for host compilation.
// RUN: %clang -### --cuda-host-only -target nvptx-nvidia-cuda -c %s 2>&1 \
// RUN: | FileCheck -check-prefix HOST_NVPTX %s
// RUN: %clang -### --cuda-host-only -target amdgcn-amd-amdhsa -c %s 2>&1 \
// RUN: | FileCheck -check-prefix HOST_AMDGCN %s

// OK-NOT: error: Unsupported CUDA gpu architecture
// HOST_NVPTX: error: unsupported architecture 'nvptx' for host compilation
// HOST_AMDGCN: error: unsupported architecture 'amdgcn' for host compilation
