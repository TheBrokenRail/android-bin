#!/bin/bash

set -e

wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py && python bootstrap.py --no-interactive --application-choice=mobile_android

OUT_DIR=${DEPLOY_DIR}/spidermonkey
mkdir ${OUT_DIR}
git clone --depth=1 https://github.com/mozilla/gecko-dev.git
cd gecko-dev/js/src

autoconf2.13

mkdir build-dir
cd build-dir
../configure \
  --target=${TARGET} \
  --with-android-ndk=${NDK_HOME}
  --prefix=${OUT_DIR}
make
make install
