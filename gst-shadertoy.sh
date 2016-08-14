#! /bin/bash

if [ "$#" -ne 1 ] ; then
    echo "Usage: $0 <shader-file>" >&2
    exit 1
fi

set -eu

SHADER_FILE="$1"

exec gst-launch-1.0 -v \
  v4l2src device=/dev/video0 ! 'video/x-raw,width=640,height=480,framerate=30/1' ! \
  videoscale ! 'video/x-raw,width=128,height=96,framerate=30/1' ! \
  glupload ! \
  glcolorconvert ! \
  glshader vertex="\"$(cat myshader.vs)\"" fragment="\"$(cat "$SHADER_FILE" | sed 's/\"/\\"/g' )\""  ! \
  glimagesink
