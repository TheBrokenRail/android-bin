#!/bin/bash

set -e

RUBY_VER=2.5
RUBY_VER_MINOR=3

git clone https://github.com/rbenv/ruby-build.git
ruby-build/install.sh
ruby-build ${RUBY_VER}.${RUBY_VER_MINOR} $(pwd)/ruby

OUT_DIR=${DEPLOY_DIR}/ruby
mkdir ${OUT_DIR}
curl --retry 5 -L -o ruby.tar.gz https://cache.ruby-lang.org/pub/ruby/${RUBY_VER}/ruby-${RUBY_VER}.${RUBY_VER_MINOR}.tar.gz
tar zxf ruby.tar.gz
cd ruby-${RUBY_VER}.${RUBY_VER_MINOR}

./configure --prefix=${OUT_DIR} --enable-shared --host=${TARGET} cflags='-DIOV_MAX=1024 -D_SETKEY_DECLARED'
make
make install
