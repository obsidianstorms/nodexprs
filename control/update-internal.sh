#!/usr/bin/env bash
# This file is used by the docker container for execution

ERROR_COLOR="\033[0;31m"
SUCCESS_COLOR="\033[0;32m"
WARNING_COLOR="\033[1;33m"
CAUTION_COLOR="\033[0;36m"
NC="\033[0m"

####################################
# Environment
####################################
cd /repo
if [ -d lib ]; then
    rm -r lib  # Remove lib folder to ensure it contains only most updated code
fi
npm run build
CODE=$?
exit ${CODE}
