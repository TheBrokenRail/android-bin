#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/jerryscript
mkdir ${OUT_DIR}
git clone --depth=1 https://github.com/jerryscript-project/jerryscript.git
cd jerryscript

python tools/build.py --toolchain=${TOOLCHAIN_FILE} --install=${OUT_DIR} --cmake-param=-DENABLE_LTO=OFF
