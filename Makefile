.PHONY: default

# docker manifest command will work with Docker CLI 18.03 or newer
# but for now it's still experimental feature so we need to enable that
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1

export DOCKER_IMAGE=kaissi/ms-video-catalog-backend
export DOCKER_TAG=latest
export DOCKER_NAME=ms-video-catalog-backend
export DOCKER_PORT=9000

export ARCHS_ALL=amd64 arm64 armv7 armhf

default: build

get-archs: ## return all architectures that can be used
	@echo $(ARCHS_ALL)

generate-laravel-files: ## generate Laravel files (execute this only once)
	@.scripts-make/generate-laravel-files.sh

copy-laravel-files: ## copy the generated Laravel files to the root project folder
	@.scripts-make/copy-laravel-files.sh

build: ## build Docker for the local platform (default target)
	@.scripts-make/build-default.sh

#build-%: ## build Docker for a specific platform (See 'make get-archs')
#	@.scripts-make/build-multi-arch.sh ${*}

#build-all: ## build Docker for multiple architectures (See 'make get-archs'). You can build for a specific platform using 'make build-armv7', for example
#	@.scripts-make/build-multi-arch.sh all

#release: build-all ## execute 'build-all', push all the images to Docker Hub and generate manifest
#	@.scripts-make/release.sh

run: ## run standalone
	@.scripts-make/run-standalone.sh

delete: ## delete standalone running docker
	@.scripts-make/delete-standalone.sh

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)