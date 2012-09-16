#!/bin/sh

FILE=$1
shift

rm -f __tmp.avi
mencoder "$FILE" \
    -oac pcm \
    -ovc lavc \
    -lavcopts vcodec=mjpeg \
    -sws 2 \
    -vf scale=176:144 \
    -o __tmp.avi \
    -font ~/.mplayer/subfont.ttf  \
    -subfont-text-scale 4 \
    -subfont-blur 2 \
    -subfont-outline 1 \
    $*

rm -f "$FILE".3gp
ffmpeg \
    -i __tmp.avi \
    -ar 8000 \
    -ac 1 \
    -acodec amr_nb \
    -vcodec h263 \
    -s 176x144 \
    -r 12 \
    -b 30 \
    -ab 12 \
    "$FILE".3gp
