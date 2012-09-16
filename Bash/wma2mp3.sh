#!/bin/bash
#
# wma to wav

for i in *.wma
do
x=`echo "$i"|sed -e 's/.wma/.wav/'`
y=`echo "$i"|sed -e 's/.wma/.mp3/'`
t=`echo "$i"|sed -e 's/.wma//'`
title=`echo "$t"|sed -e 's/.. \(.*\)/\1/'`
track=`echo "$t"|sed -e 's/\(..\).*/\1/'`
artist="Caetano Veloso"
album="Caetano Veloso"
genre="Latin"
year="1967"

mplayer -ao pcm:file="$x" "$i"
lame --preset cbr 320 --tt "$title" --ta "$artist" --tl "$album" --tg "$genre" --tn "$track" --ty "$year" "$x" "$y"
rm "$x"
done
