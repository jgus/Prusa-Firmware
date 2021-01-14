#!/bin/bash -e

DIR=$(cd $(dirname $0); pwd)
REPO_DIR=$(cd ${DIR}/..; pwd)
IMAGE_NAME="prusa-firmware-build"
CONTAINER_NAME="${IMAGE_NAME}-$(id -u -n)"

ARGS=(
    -ti
    -w /build/Prusa-Firmware
)

if [[ ! "$(docker ps -a | grep ${CONTAINER_NAME})" ]]
then
    docker build \
        --build-arg uid=$(id -u) \
        --build-arg gid=$(id -g) \
        --build-arg user=$(id -u -n) \
        -t ${IMAGE_NAME} \
        -f ${DIR}/Dockerfile \
        ${DIR}

    ARGS+=(
        --rm
        -v "${REPO_DIR}":/build/Prusa-Firmware
        --name "${CONTAINER_NAME}"
    )

    ARGS+=(${IMAGE_NAME})

    if [[ "$*" == "" ]]; then
        docker run "${ARGS[@]}" /bin/bash
    else
        docker run "${ARGS[@]}" /bin/bash -i -c "$*"
    fi
else
    if [[ "$*" == "" ]]; then
        docker exec "${ARGS[@]}" "${CONTAINER_NAME}" /bin/bash
    else
        docker exec "${ARGS[@]}" "${CONTAINER_NAME}" /bin/bash -i -c "$*"
    fi
fi
