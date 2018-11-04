#!/bin/bash

set -e

echo 'Downloading NDK...'
NDK_VER='android-ndk-r18b'
curl --retry 5 -L -o ndk.zip "https://dl.google.com/android/repository/${NDK_VER}-linux-x86_64.zip"
unzip ndk.zip > /dev/null
export NDK_HOME=$(pwd)/${NDK_VER}

echo 'Building Toolchain...'
export TOOLCHAIN_ROOT="${NDK_HOME}/generated-toolchains/${ARCH}"
${NDK_HOME}/build/tools/make_standalone_toolchain.py \
  --arch=${ARCH} \
  --api=21 \
  --install-dir=${TOOLCHAIN_ROOT}
export PATH=${TOOLCHAIN_ROOT}/bin:${PATH}
export TARGET=$(cd ${NDK_HOME}/build/tools; python -c 'import make_standalone_toolchain; print make_standalone_toolchain.get_triple("'"${ARCH}"'")')

echo 'Creationg CMake Toolchain File...'
echo -e 'set(CMAKE_SYSTEM_NAME Android)\nset(CMAKE_ANDROID_STANDALONE_TOOLCHAIN '"${TOOLCHAIN_ROOT}"')' > toolchain.cmake
ls ${TOOLCHAIN_ROOT}/sysroot || sleep 60
export TOOLCHAIN_FILE=$(pwd)/toolchain.cmake

echo "NDK_HOME: ${NDK_HOME}"
echo "TARGET: ${TARGET}"
echo "TOOLCHAIN_FILE: ${TOOLCHAIN_FILE}"
echo "PATH: ${PATH}"
echo "TOOLCHAIN_ROOT: ${TOOLCHAIN_ROOT}"
