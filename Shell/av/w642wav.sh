#!/bin/bash
FILE_LIST="`ls *.w64`"
for f in ${FILE_LIST}
do
	BASENAME=${f/.w64/}
	echo $BASENAME
	ecasound -i $f -o $BASENAME.wav
done
