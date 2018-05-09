#!/usr/bin/env bash

####################################
# INTERACTIVE BREAK
####################################
# Needed in the harness if using `docker run`
control_c()
# run if user hits control-c
{
    echo -en "\n*** Exiting...\n"
    exit $?
}
trap control_c SIGINT


####################################
# RUN TESTS
####################################
RUN_SCRIPT="/repo/server.js"

# All Tests
node ${RUN_SCRIPT}
CODE=$?
exit $CODE
