#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -e "$0")"
THIS_SCRIPT_DIR="$(dirname "$THIS_SCRIPT")"
DOCKER_RUN_DIR="${THIS_SCRIPT_DIR}/run"
DOCKER_SCRIPTS_DIR="${THIS_SCRIPT_DIR}/scripts"

(cd "$DOCKER_RUN_DIR"
	export PATH="${DOCKER_SCRIPTS_DIR}:${PATH}"
	"run_docker-bitcoin.sh" ./datadir ${@:2}
)

