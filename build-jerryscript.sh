#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/jerryscript
mkdir ${OUT_DIR}
git clone --depth=1 https://github.com/jerryscript-project/jerryscript.git
cd jerryscript

python tools/build.py --toolchain=${TOOLCHAIN_FILE}
cp -r ./build/bin ${OUT_DIR}
cp -r ./build/lib ${OUT_DIR}
