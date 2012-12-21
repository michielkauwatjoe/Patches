#!/bin/bash
#
# m4a to wav

for i in *
do

# Change extension from flv to mpg.
x=`echo "$i"|sed -e 's/.flv/.mpg/'`

# NTSC, 4:3, 22050 Hz.
mencoder -oac lavc -ovc lavc -of mpeg -mpegopts format=dvd -vf scale=720:480,harddup -srate 22050 -af lavcresample=22050 -lavcopts vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vbitrate=5000:keyint=18:aspect=4/3:acodec=ac3:abitrate=192 -ofps 30000/1001 -o "$x" "$i"
done
