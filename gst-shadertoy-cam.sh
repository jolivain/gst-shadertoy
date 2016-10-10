#! /bin/bash

set -e
set -u

BASE_DIR="$(dirname "$0")"
SCRIPT_NAME="$(basename "$0")"
GST_VERSION="$(gst-launch-1.0 --version | head -1 | sed 's/^gst-launch-1.0 version \([^ ]*\)/\1/')"

IFS='.' read GST_MAJOR GST_MINOR GST_PATCH <<< "${GST_VERSION}"

if [[ "${GST_MAJOR}" -lt 1 ]] ; then
    echo "GStreamer major version is expecter to be at least 1"
    exit 1
fi

if [[ "${GST_MINOR}" -lt 8 ]] ; then
    SCRIPT="${SCRIPT_NAME::-3}-1.6.sh"
else
    SCRIPT="${SCRIPT_NAME::-3}-1.8.sh"
fi

exec "$BASE_DIR/$SCRIPT" "${@}"
