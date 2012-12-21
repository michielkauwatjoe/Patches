#!/bin/bash
#########################################################
# Flac to Mp3 Conversion Software #
# Script Created by Nick Sklavenitis #
# Date: September 18 2007 #
#########################################################
# modify the lame options to your preference example change -b 320 to -b 128 or -b 192 or -b 256
lame_opts=" --vbr-new -V 2 -b 320 "

# Creates the loop that allows more than 1 file to be specified, Can use single file name or example *.flac
for x in "${@}"
do
FLAC=${x}
MP3=`basename "${FLAC%.flac}.mp3"`
[ -r "$FLAC" ] || { echo can not read file \"$FLAC\" >&1 ; exit 1 ; } ;

#This section pulls the Tag info from flac and stores it as a variable.

TITLE="`metaflac --show-tag=TITLE "$FLAC" | awk -F = '{ printf($2) }'`"
ALBUM="`metaflac --show-tag=ALBUM "$FLAC" | awk -F = '{ printf($2) }'`"
ARTIST="`metaflac --show-tag=ARTIST "$FLAC" | awk -F = '{ printf($2) }'`"
TRACKNUMBER="`metaflac --show-tag=TRACKNUMBER "$FLAC" | awk -F = '{ printf($2) }'`"
GENRE="`metaflac --show-tag=GENRE "$FLAC" | awk -F = '{ printf($2) }'`"
COMMENT="`metaflac --show-tag=COMMENT "$FLAC" | awk -F = '{ printf($2) }'`"
DATE="`metaflac --show-tag=DATE "$FLAC" | awk -F = '{ printf($2) }'`"

#This section handles the conversion of the Flac file to MP3

flac -dc "$FLAC" | lame${lame_opts} \
--tt "$TITLE" \
--tn "$TRACKNUMBER" \
--tg "$GENRE" \
--ty "$DATE" \
--ta "$ARTIST" \
--tl "$ALBUM" \
--add-id3v2 \
- "$MP3"

done
