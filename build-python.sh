#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/python
mkdir ${OUT_DIR}

pip install --user git+https://github.com/TheBrokenRail/python-for-android.git@patch-3 cython
mkdir -p py-build/build/python-installs/build

p4a create --sdk-dir ${ANDROID_HOME} --ndk-dir ${NDK_HOME} --ndk-version ${NDK_VER} --android-api 26 --ndk-api 21 --arch ${ABI} --requirements python3 --storage-dir $(pwd)/py-build --dist-name build || :

PY_INCLUDE=py-build/build/other_builds/python3/${ABI}__ndk_target_${API_LEVEL}/python3/Include
PY_LIBS=py-build/dists/build/libs/${ABI}
PY_BUNDLE=py-build/dists/build/_python_bundle/_python_bundle
PY_BUILD=py-build/build/other_builds/python3/${ABI}__ndk_target_${API_LEVEL}/python3/android-build

mkdir ${OUT_DIR}/build
cp -r ${PY_BUILD}/* ${OUT_DIR}/build
mkdir ${OUT_DIR}/include
cp -r ${PY_INCLUDE}/* ${OUT_DIR}/include
mkdir ${OUT_DIR}/libs
cp ${PY_LIBS}/* ${OUT_DIR}/libs
mkdir ${OUT_DIR}/bundle
cp -r ${PY_BUNDLE}/* ${OUT_DIR}/bundle
