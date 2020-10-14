#!/bin/bash

echo ">> Deleting the standalone docker '${DOCKER_NAME}' <<"

CONTAINER_NAME=$(
    docker rm --force ${DOCKER_NAME}
)
if [ $? == 0 ]; then
    echo "Container '${CONTAINER_NAME}' deleted"
fi