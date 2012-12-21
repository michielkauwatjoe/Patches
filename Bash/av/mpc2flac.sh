#!/bin/bash
#
# m4a to wav

for i in *.mpc
do

x=`echo "$i"|sed -e 's/.mpc/.wav/'`
y=`echo "$i"|sed -e 's/.mpc/.flac/'`

# NTSC, 4:3, 22050 Hz.
/home/michiel/bin/mppdec "$i" "$x"
done

shntool conv -o flac *.wav
rm *.wav
