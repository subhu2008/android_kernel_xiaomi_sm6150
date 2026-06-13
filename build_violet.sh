#!/bin/bash

# 1. Setup toolchain flags for violet.

export ARCH=arm64
export SUBARCH=arm64
export CC=clang
export HOSTCC=clang
export CXX=clang++
export HOSTCXX=clang++
export LTO=thin
export CROSS_COMPILE=aarch64-linux-gnu-
export CLANG_TRIPLE=aarch64-linux-gnu-

# 2. remove existing .config (if any) and create manually first so we don't run into .config issue.

rm .config

touch .config

# 3. Run mrproper (just in case).

make -j$(nproc --all) ARCH=arm64 SUBARCH=arm64 CC=clang HOSTCC=clang CXX=clang++ HOSTCXX=clang++ LTO=thin CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- clean mrproper

# 4. Again create empty .config so we don't run into problem.

touch .config

# 5. Setup defconfig with droidspaces support. (touch .config again too)

touch .config; make -j$(nproc --all) ARCH=arm64 SUBARCH=arm64 CC=clang HOSTCC=clang CXX=clang++ HOSTCXX=clang++ LTO=thin CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- violet-los.config droidspaces.config version.config

# 6. Cook kernel.

make -j$(nproc --all) ARCH=arm64 SUBARCH=arm64 CC=clang HOSTCC=clang CXX=clang++ HOSTCXX=clang++ LTO=thin CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu-
