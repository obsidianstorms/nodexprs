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
#RUN_SCRIPT="/repo/src/run.js"

# All Tests
#node ${RUN_SCRIPT}
node "/repo/src/bdr.js"
node "/repo/src/pp.js"
node "/repo/src/rb.js"
CODE=$?
exit $CODE
