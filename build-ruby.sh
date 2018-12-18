#!/bin/bash

set -e

RUBY_VER=2.5
RUBY_VER_MINOR=3

source ~/.rvm/scripts/rvm
rvm install ${RUBY_VER}.${RUBY_VER_MINOR}
rvm use ${RUBY_VER}.${RUBY_VER_MINOR}

OUT_DIR=${DEPLOY_DIR}/ruby
mkdir ${OUT_DIR}
curl --retry 5 -L -o ruby.tar.gz https://cache.ruby-lang.org/pub/ruby/${RUBY_VER}/ruby-${RUBY_VER}.${RUBY_VER_MINOR}.tar.gz
tar zxf ruby.tar.gz
cd ruby-${RUBY_VER}.${RUBY_VER_MINOR}

./configure --prefix=${OUT_DIR} --host=${TARGET} cflags='-DIOV_MAX=1024 -D_SETKEY_DECLARED'
make
make install
