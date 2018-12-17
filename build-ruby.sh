#!/bin/bash

set -e

OUT_DIR=${DEPLOY_DIR}/ruby
mkdir ${OUT_DIR}
RUBY_VER=2.5
RUBY_VER_MINOR=3
curl --retry 5 -L -o ruby.tar.gz https://cache.ruby-lang.org/pub/ruby/${RUBY_VER}/ruby-${RUBY_VER}.${RUBY_VER_MINOR}.tar.gz
tar zxf ruby.tar.gz
cd ruby-${RUBY_VER}.${RUBY_VER_MINOR}

./configure --prefix=${OUT_DIR} --enable-shared --host=${TARGET}
make
make install