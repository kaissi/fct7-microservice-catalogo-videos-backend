#!/bin/bash

echo ">> Generating Laravel files in a temporary folder '.laravel-files-tmp' <<"

docker volume create \
    --driver local \
    --opt type=none \
    --opt device=$(pwd)/.laravel-files-tmp \
    --opt o=bind \
    laravel-files-tmp-data

docker-compose \
	-f .docker/laravel/docker-compose.yaml \
	build --no-cache --parallel --force-rm --compress

docker-compose \
    -f .docker/laravel/docker-compose.yaml \
    up --force-recreate

docker-compose \
	-f .docker/laravel/docker-compose.yaml \
	down --volumes --rmi all --remove-orphans

docker-compose \
    -f .docker/laravel/docker-compose.yaml \
    rm -f -v

docker volume rm laravel-files-tmp-data

echo ">> Attention! <<"
echo "The process to generate Laravel files is not finished. The generated files is in the folder '.laravel-files-tmp' inside the project."
echo "They will be put in the root project folder, after you making changes if necessary, by executing 'make copy-laravel-files'"
