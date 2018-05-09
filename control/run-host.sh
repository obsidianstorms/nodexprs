#!/usr/bin/env bash
# This file is used by the docker container for execution

ERROR_COLOR="\033[0;31m"
SUCCESS_COLOR="\033[0;32m"
WARNING_COLOR="\033[1;33m"
CAUTION_COLOR="\033[0;36m"
NC="\033[0m"

####################################
# INTERACTIVE BREAK
####################################
function cleanup() {
    printf "Shutting down stack...\n"
#    docker stack rm $TEST_SERVICE # Ensure everything is cleaned up, including active secrets
    docker stop $(docker inspect --format="{{.Id}}" ${DOCKER_NAME})
    printf "Waiting on stack to clear...\n"
    sleep 5 # It takes a few seconds to let docker finish flushing the stack
    docker rm $(docker inspect --format="{{.Id}}" ${DOCKER_NAME})
    printf "Done.\n"
}

control_c()
# run if user hits control-c
{
    echo -en "\n*** Exiting...\n"
    cleanup
    exit $?
}
trap control_c SIGINT


####################################
# Run Docker
####################################
HOST_REPO="$(pwd)"
DOCKER_NAME=$1
CONTROL_HARNESS="/repo/control/run-internal.sh"
HOST_PORT=8081
APP_PORT=8080

docker run -t -i -v "$HOST_REPO:/repo" --name ${DOCKER_NAME}  -p ${HOST_PORT}:${APP_PORT} ${DOCKER_NAME} /bin/bash ${CONTROL_HARNESS}
cleanup
