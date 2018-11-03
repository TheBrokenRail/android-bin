#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/lua
mkdir ${OUT_DIR}
LUA_VER=5.3.5
curl --retry 5 -L -o lua.tar.gz http://www.lua.org/ftp/lua-${LUA_VER}.tar.gz
tar zxf lua.tar.gz
cd lua-${LUA_VER}

make CC=${TARGET}-gcc posix local
cp -r ./install/* ${OUT_DIR}
