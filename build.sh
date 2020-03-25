#!/bin/bash

# Color
green='\033[0;32m'
echo -e "$green"

# Clone depedencies
#git clone --depth=1 https://github.com/sujitroy/clang.git -b 10.0.1 ~/ether/clang
#git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-10.0.0_r20 ~/ether/gcc64
#git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-10.0.0_r14 ~/ether/gcc32

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="SonalSingh18"
export KBUILD_BUILD_HOST="Etherious"
export CROSS_COMPILE=/home/ubuntu/ether/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/ubuntu/ether/gcc32/bin/arm-linux-androideabi-
export KBUILD_COMPILER_STRING=$(/home/ubuntu/ether/clang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')

mkdir -p out

make O=out ARCH=arm64 etherious_defconfig

make -j$(nproc --all) O=out ARCH=arm64 \
                        CC="/home/ubuntu/ether/clang/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
