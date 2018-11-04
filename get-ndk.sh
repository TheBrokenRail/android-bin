#!/bin/bash

set -e

echo 'Downloading NDK...'
NDK_VER='android-ndk-r18b'
curl --retry 5 -L -o ndk.zip "https://dl.google.com/android/repository/${NDK_VER}-linux-x86_64.zip"
unzip ndk.zip > /dev/null
export NDK_HOME=$(pwd)/${NDK_VER}

echo 'Building Toolchain...'
${NDK_HOME}/build/tools/make_standalone_toolchain.py \
  --arch=${ARCH} \
  --api=21 \
  --install-dir=${NDK_HOME}/generated-toolchains/${ARCH}
export PATH=${NDK_HOME}/generated-toolchains/${ARCH}/bin:${PATH}
export TARGET=$(cd ${NDK_HOME}/build/tools; python -c 'import make_standalone_toolchain; print make_standalone_toolchain.get_triple("'"${ARCH}"'")')

echo 'Creationg CMake Toolchain File...'
echo -e 'set(CMAKE_SYSTEM_NAME Android)\nset(CMAKE_ANDROID_STANDALONE_TOOLCHAIN '"${NDK_HOME}/generated-toolchains/${ARCH}"')' > toolchain.cmake
export TOOLCHAIN_FILE=$(pwd)/toolchain.cmake

echo "NDK_HOME: ${NDK_HOME}"
echo "TARGET: ${TARGET}"
echo "TOOLCHAIN_FILE: ${TOOLCHAIN_FILE}"
echo "PATH: ${PATH}"
