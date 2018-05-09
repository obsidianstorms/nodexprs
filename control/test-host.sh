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
CONTROL_UPDATE="/repo/control/test-internal.sh"


# This will update the host directory/repo through the docker container
# This process avoids the host from needing to be configured with node
docker run -t -i \
        -v "$HOST_REPO:/repo" \
        ${DOCKER_NAME} /bin/bash ${CONTROL_UPDATE}
cleanup
