#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/python
mkdir ${OUT_DIR}

pip install --user git+https://github.com/kivy/python-for-android.git cython
mkdir -p py-build/build/python-installs/build

p4a create --sdk-dir ${ANDROID_HOME} --ndk-dir ${NDK_HOME} --ndk-version ${NDK_VER} --android-api 26 --arch ${ABI} --requirements python3 --storage-dir $(pwd)/py-build --dist-name build
cp -r py-build/* ${OUT_DIR}
