#!/bin/bash

set -e
set -x

OUT_DIR=${DEPLOY_DIR}/jerryscript
mkdir ${OUT_DIR}
git clone --depth=1 https://github.com/jerryscript-project/jerryscript.git
cd jerryscript

echo ${TOOLCHAIN_FILE}
cat ${TOOLCHAIN_FILE}
python tools/build.py --toolchain=${TOOLCHAIN_FILE} --install=${OUT_DIR}
