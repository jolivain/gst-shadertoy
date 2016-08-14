#! /bin/bash

gst-launch-1.0 -v \
  v4l2src device=/dev/video0 ! 'video/x-raw,width=640,height=480,framerate=30/1' ! \
  videoscale ! 'video/x-raw,width=128,height=96,framerate=30/1' ! \
  glupload ! \
  glcolorconvert ! \
  glshader vertex="\"$(cat myshader.vs)\"" fragment="\"$(cat myshader.fs | sed 's/\"/\\"/g' )\""  ! \
  glimagesink
