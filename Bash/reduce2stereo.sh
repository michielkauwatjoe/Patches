#!/bin/bash

for i in *.wav
do
mkdir converted
#x=`echo "$i"|sed -e 's/.wav/-stereo.wav/'`
mplayer "$i" -af channels=2 -ao pcm:file="converted/$i"
done

rm *.wav
mv converted/*.wav .
rm -r converted
