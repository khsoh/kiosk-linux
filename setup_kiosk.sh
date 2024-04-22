#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

SDIR="$(source print_distro.sh)" || return $?

pushd "$SDIR" >/dev/null

source setup_kiosk.sh

popd >/dev/null
