#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/dash
mkdir ${OUT_DIR}
DASH_VER=0.5.10.2
curl --retry 5 -L -o dash.tar.gz https://git.kernel.org/pub/scm/utils/dash/dash.git/snapshot/dash-${DASH_VER}.tar.gz
tar zxf dash.tar.gz
cd dash-${DASH_VER}

./autogen.sh
./configure --host=${TARGET} --prefix=${OUT_DIR} CFLAGS="--sysroot=${NDK_HOME}/generated-toolchains/${ARCH}/sysroot"
make
make install
