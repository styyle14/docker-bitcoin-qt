#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -e "$0")"
DOCKER_BITCOIN_IMAGE_TAG="bitcoin-qt"

if [ $# -ne 1 ]; then
	echo "Incorrect number of parameters."
	echo "Usage: $(basename "$0") [docker-bitcoin build directory]"
	echo "Exiting now."
	exit 1
fi

DOCKER_BITCOIN_BUILD_DIR="$(readlink -e "$1")"
if [ ! -d "$DOCKER_BITCOIN_BUILD_DIR" ]; then
	echo "Error: [docker-bitcoin build directory] ${DOCKER_BITCOIN_BUILD_DIR} not found."
	echo "Exiting now."
	exit 2
fi

docker build \
	-t "$DOCKER_BITCOIN_IMAGE_TAG" \
	"$DOCKER_BITCOIN_BUILD_DIR"

