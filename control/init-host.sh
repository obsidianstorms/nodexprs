#!/usr/bin/env bash

ERROR_COLOR="\033[0;31m"
SUCCESS_COLOR="\033[0;32m"
WARNING_COLOR="\033[1;33m"
CAUTION_COLOR="\033[0;36m"
NC="\033[0m"

####################################
# Local Folders
####################################
declare -a DIR_LIST=(
"$(pwd)/log"
#"$(pwd)/screenshot"
#"$(pwd)/screenshot/single"
#"$(pwd)/screenshot/multi"
)
for dir in "${DIR_LIST[@]}"
do
    if [ ! -d $dir ]; then
        printf "${WARNING_COLOR} WARNING: No $dir directory found in the Docker image.  Attempting to create...${NC}\n"
        mkdir "$dir"
        if [ ! -d $dir ]; then
            printf "${ERROR_COLOR} FATAL: No $dir directory found in the Docker image."
            printf "Auto-create failed, $dir folder might need to be manually created.${NC}\n"
            exit 1
        fi
        printf "${SUCCESS_COLOR} OK: Successfully created $dir directory.${NC}\n"
    fi
done

####################################
# Git Secret
####################################
#GIT_FILE_SECRET="$(pwd)/config/git-secret.txt"
#declare -a FILE_LIST=(
#${GIT_FILE_SECRET}
#)
#for file in "${FILE_LIST[@]}"
#do
#    if [ ! -f $file ]; then
#        printf "${WARNING_COLOR} WARNING: No $file file found in the Docker image.  Attempting to create...${NC}\n"
#        touch "$file"
#        if [ ! -d $dir ]; then
#            printf "${ERROR_COLOR} FATAL: No $file file found in the Docker image.
#            printf "Please create $file and fill with necessary content. ${NC}\n"
#            exit 1
#        fi
#        printf "${WARNING_COLOR} OK: Successfully created $file file.
#        printf "Please fill with necessary content and rerun `make build`. ${NC}\n"
#        exit 1
#    fi
#done
#
## Swap Git Secret in package.json
#GITSECRET=$(<${GIT_FILE_SECRET})
#if [ -z "${GITSECRET}" ]; then
#    printf "${ERROR_COLOR} FATAL: No git secret defined.  Please fill in ${GIT_FILE_SECRET} ${NC}\n"
#    exit 1
#fi
#NEEDLE="{git-secret}"
#printf "${WARNING_COLOR} WARN: Swapping Git secret in package.json.${NC}\n"
#echo "%s/${NEEDLE}/${GITSECRET}/g
#w
#q
#" | ex $(pwd)/package.json

####################################
# Site Secret
####################################
ADMIN_FILE="$(pwd)/config/secrets.json"
JSON_TEMPLATE="$(cat $(pwd)/res/creds.jtpl)"

if [ ! -f $ADMIN_FILE ]; then
    printf "${WARNING_COLOR} WARN: $ADMIN_FILE wasn't found.  Creating from template...${NC}\n"
    echo "$JSON_TEMPLATE" > $ADMIN_FILE
    printf "${SUCCESS_COLOR} OK: Created file.  ${NC}\n"
    printf "${WARNING_COLOR} WARN: Please add information to $ADMIN_FILE ${NC}\n"
fi


####################################
# Docker
####################################
# Check docker
DOCKER="$(docker -v)"
if [[ ! $DOCKER == *"Docker version"* ]]; then
    printf "${ERROR_COLOR} FATAL: Docker not found.  Please install Docker.${NC}\n"
    exit 1
fi

# Build docker
SUCCESSFUL_BUILD=0
DOCKER_FILE="Dockerfile.express"
CONTROL_INIT="/repo/control/init-internal.sh"
DOCKER_NAME=$1
HOST_REPO="$(pwd)"
DOCKER_FILEPATH="${HOST_REPO}/${DOCKER_FILE}"
#docker build --no-cache -t $DOCKER_NAME .
docker build -t ${DOCKER_NAME} -f ${DOCKER_FILEPATH} .

# This will update the host directory/repo through the docker container
# This process avoids the host from needing to be configured with node
docker run -t -i \
        -v "$HOST_REPO:/repo" \
        ${DOCKER_NAME} /bin/bash ${CONTROL_INIT}
CODE=$?
if [ ${CODE} -ne 0 ]; then
    printf "${ERROR_COLOR} FATAL: Docker or internal initialization build failed with code: ${CODE}. ${NC}\n"
    SUCCESSFUL_BUILD=${CODE}
fi

####################################
# Git Secret Cleanup
####################################

## Reverse git secret substitution in package.json
#printf "${WARNING_COLOR} WARN: Reversing Git secret in package.json.${NC}\n"
#echo "%s/${GITSECRET}/${NEEDLE}/g
#w
#q
#" | ex $(pwd)/package.json
#
#if [ ${SUCCESSFUL_BUILD} -ne 0 ]; then
#    printf "${ERROR_COLOR} FATAL: Errors building. ${NC}\n"
#    exit ${SUCCESSFUL_BUILD}
#fi

printf "${SUCCESS_COLOR} OK: No errors during build. ${NC}\n"