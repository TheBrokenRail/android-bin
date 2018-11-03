#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/bash
mkdir ${OUT_DIR}
BASH_VER=4.4
curl --retry 5 -L -o bash.tar.gz http://ftp.gnu.org/gnu/bash/bash-${BASH_VER}.tar.gz
tar zxf bash.tar.gz
cd bash-${BASH_VER}

./configure --disable-readline --host=${TARGET} --prefix=${OUT_DIR} CFLAGS="--sysroot=${NDK_HOME}/generated-toolchains/${ARCH}/sysroot"
make
make install
