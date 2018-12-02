#!/bin/bash

set -e

export API_LEVEL=21

echo 'Downloading NDK...'
export NDK_VER='10.3.2'
curl --retry 5 -L -o ndk.tar.xz "https://www.crystax.net/download/crystax-ndk-${NDK_VER}-linux-x86_64.tar.xz"
tar xJf ndk.tar.xz > /dev/null
export NDK_HOME=$(pwd)/crystax-ndk-${NDK_VER}

echo 'Building Toolchain...'
export TOOLCHAIN_ROOT="${NDK_HOME}/generated-toolchains/${ARCH}"
${NDK_HOME}/build/tools/make-standalone-toolchain.sh \
  --arch=${ARCH} \
  --platform=android-${API_LEVEL} \
  --install-dir=${TOOLCHAIN_ROOT}
NDK_BUILDTOOLS_PATH=${NDK_HOME}/build/tools
source ${NDK_HOME}/build/tools/prebuilt-common.sh
export PATH=${TOOLCHAIN_ROOT}/bin:${PATH}
export TARGET=$(get_toolchain_name_for_arch ${ARCH})
echo "TARGET: ${TARGET}"
export ABI=$(IFS=',' read -r -a abis <<< "$(convert_arch_to_abi ${ARCH})"; echo ${abis[0]})
echo "ABI: ${ABI}"

echo 'Creationg CMake Toolchain File...'
echo -e 'set(CMAKE_C_COMPILER '"${TARGET}"'-gcc)\nset(CMAKE_C_FLAGS -O2)\nset(CMAKE_SYSTEM_NAME Linux)\nset(CMAKE_SYSROOT '"${TOOLCHAIN_ROOT}"'/sysroot)' > toolchain.cmake
export TOOLCHAIN_FILE=$(pwd)/toolchain.cmake

echo "NDK_HOME: ${NDK_HOME}"
echo "TOOLCHAIN_FILE: ${TOOLCHAIN_FILE}"
echo "PATH: ${PATH}"
echo "TOOLCHAIN_ROOT: ${TOOLCHAIN_ROOT}"
