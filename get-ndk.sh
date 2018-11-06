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
  --api=${API_LEVEL} \
  --install-dir=${TOOLCHAIN_ROOT}
export PATH=${TOOLCHAIN_ROOT}/bin:${PATH}
export TARGET=$(cd ${NDK_HOME}/build/tools; python -c 'import make_standalone_toolchain; print make_standalone_toolchain.get_triple("'"${ARCH}"'")')
export ABI=$(cd ${NDK_HOME}/build/tools; python -c 'import make_standalone_toolchain; print make_standalone_toolchain.get_abis("'"${ARCH}"'")[0]')

echo 'Creationg CMake Toolchain File...'
echo -e 'set(CMAKE_C_COMPILER '"${TARGET}"'-clang)\nset(CMAKE_C_FLAGS -O3)\nset(CMAKE_SYSTEM_NAME Linux)\nset(CMAKE_SYSROOT '"${TOOLCHAIN_ROOT}"'/sysroot)' > toolchain.cmake
export TOOLCHAIN_FILE=$(pwd)/toolchain.cmake

echo "NDK_HOME: ${NDK_HOME}"
echo "TARGET: ${TARGET}"
echo "TOOLCHAIN_FILE: ${TOOLCHAIN_FILE}"
echo "PATH: ${PATH}"
echo "TOOLCHAIN_ROOT: ${TOOLCHAIN_ROOT}"
