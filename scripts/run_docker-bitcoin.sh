#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -e "$0")"
DOCKER_BITCOIN_USERNAME="bitcoin"
DOCKER_BITCOIN_DATADIR_MOUNTPOINT="/home/${DOCKER_BITCOIN_USERNAME}/datadir"
DOCKER_BITCOIN_IMAGE_TAG="bitcoin-qt"

if [ $# -lt 1 ]; then
	echo "Incorrect number of parameters."
	echo "Usage: $(basename "$0") [docker-bitcoin datadir] <docker run parameters...>"
	echo "Exiting now."
	exit 1
fi

DOCKER_BITCOIN_DATADIR="$(readlink -e "$1")"
if [ ! -d "$DOCKER_BITCOIN_DATADIR" ]; then
	echo "Error: [docker-bitcoin datadir] ${DOCKER_BITCOIN_DATADIR} not found."
	echo "Exiting now."
	exit 2
fi

docker run -it \
	-e "DISPLAY=${DISPLAY}" \
	-e "XAUTHORITY=/tmp/.Xauthority" \
	-v "${HOME}/.Xauthority:/tmp/.Xauthority" \
	-v "/tmp/.X11-unix:/tmp/.X11-unix" \
	-v "${DOCKER_BITCOIN_DATADIR}:${DOCKER_BITCOIN_DATADIR_MOUNTPOINT}" \
	${@:2} \
	"$DOCKER_BITCOIN_IMAGE_TAG"

