#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/lua-jit
mkdir ${OUT_DIR}
LUA_VER=2.0.5
curl --retry 5 -L -o lua-jit.tar.gz http://luajit.org/download/LuaJIT-${LUA_VER}.tar.gz
tar zxf lua-jit.tar.gz
cd LuaJIT-${LUA_VER}

make HOST_CC="gcc -m32" CROSS=${TARGET}- PREFIX=${OUT_DIR}
