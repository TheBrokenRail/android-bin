#!/bin/bash

set +e

EXIT=0

run() {
  local RESET='\033[0m'
  local COLOR='\e[32m\e[1m'
  echo "${COLOR}Running $1${RESET}"
  if [[ $? != 0 ]]; then
    EXIT=1
  fi
}

run ./build-jerryscript.sh
run ./build-lua.sh
run ./build-python.sh

exit ${EXIT}
