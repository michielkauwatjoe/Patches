#!/bin/bash
#
# mp3 to wav

for i in *.mp3
do
x=`echo "$i"|sed -e 's/.mp3/.wav/'`
mplayer -ao pcm:file="$x" "$i"
done

