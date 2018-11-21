#!/bin/bash

set +e

run() {
  local RESET='\033[0m'
  local START='\e[33m\e[1m'
  local FAIL='\e[31m\e[1m'
  local SUCCESS='\e[32m\e[1m'
  echo -e "${START}Running $1${RESET}"
  $1
  if [[ $? != 0 ]]; then
    echo -e "${FAIL}$1 Failed${RESET}"
  else
    echo -e "${SUCCESS}$1 Succeeded${RESET}"
  fi
}

run ./build-jerryscript.sh
run ./build-lua.sh
run ./build-python.sh
