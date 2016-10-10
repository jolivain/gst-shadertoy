#! /bin/bash

if [ "$#" -ne 2 ] ; then
    echo "Usage: $0 <video-file> <shader-file>" >&2
    exit 1
fi

set -eu

VIDEO_FILE="$1"
SHADER_FILE="$2"

exec gst-launch-1.0 -v \
  filesrc location="${VIDEO_FILE}" ! \
  decodebin ! \
  glupload ! \
  glcolorconvert ! \
  glshader location="$SHADER_FILE" ! \
  glimagesinkelement
