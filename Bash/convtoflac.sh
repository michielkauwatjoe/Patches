#!/bin/bash

# -----------------------------------------------------------------------------
#
#	App Title:      convtoflac.sh
#	App Version:    1.1
#	Author:         Jared Breland <jbreland@legroom.net>
#	Homepage:       http://www.legroom.net/mysoft
#
#	Script Function:
#		Convert losslessly compressed audio file to FLAC format, preserving tags
#		Currently supports FLAC, Monkey's Audio (APE), Shorten, WAV, and WavPack
#
#	Instructions:
#		Ensure that all programs are properly set in "Setup environment"
#
#	Caveats:
#		Transcoded files will retain original file name, but use .flac extension
#		The one exception is for FLAC input files - the original input file will
#			be renamed <name>_old.flac, and the transcoded file will be named
#			<name>.flac.
#
#	Requirements:
#		The following programs must be installed and available
#		sed (http://sed.sourceforge.net/)
#			used to handle case sensitivity and tag processing
#		flac/metaflac (http://flac.sourceforge.net/)
#			used to create and tag new FLAC files
#		mac (http://sourceforge.net/projects/mac-port/)
#			used to decompress APE files
#		apeinfo (http://www.legroom.net/mysoft)
#			used to read tags from APE files
#		shorten (http://etree.org/shnutils/shorten/)
#			used to decompress Shorten files
#		wvunpack (http://www.wavpack.com/)
#			used to decompress WavPack files
#
#	Please visit the application's homepage for additional information.
#
# -----------------------------------------------------------------------------

# Setup environment
PROG=`basename $0`
SED=/usr/bin/sed
FLAC=/usr/bin/flac
METAFLAC=/usr/bin/metaflac
MAC=/usr/bin/mac
APEINFO=/usr/local/bin/apeinfo
SHORTEN=/usr/bin/shorten
WVUNPACK=/usr/bin/wvunpack
DELETE=""
COMPRESS="8"

# Function to display usage information
function warning() {
	echo -ne "Usage: $PROG [-h] [-cN] [-d|-p] <filename>\n"
	echo -ne "Convert losslessly compressed audio file to FLAC format, preserving tags\n"
	echo -ne "\nOptions:\n"
	echo -ne "   -h   Display this help information\n"
	echo -ne "   -cN  Set FLAC compression level, where N = 0 (fast) - 8 (best); default is 8\n"
	echo -ne "   -d   Delete file after conversion\n"
	echo -ne "   -p   Prompt to delete file after conversion\n"
	echo -ne "\nSupported input formats:\n"
	echo -ne "   FLAC (.flac)\n"
	echo -ne "   Monkey's Audio (.ape)\n"
	echo -ne "   Shorten (.shn)\n"
	echo -ne "   WAV (.wav)\n"
	echo -ne "   WavPack (.wv)\n"
	exit
}

# Function to parse wvunpack output to find tags and convert to VORBISCOMMENT
function wvtags() {
	TAGS2=${TAGS}.wv
	$SED -i "/ = /w${TAGS2}" $TAGS
	$SED -i "s/ = /=/" $TAGS2
	$SED -i 's/\(.*\)=/\U\1=/' $TAGS2
	$SED -i "s/TRACK=/TRACKNUMBER=/;s/YEAR=/DATE=/;s/COMMENT=/DESCRIPTION=/" $TAGS2
	mv $TAGS2 $TAGS
}

# Process arguments
if [[ $# -eq 0 ]]; then
	warning
else
	while [ $# -ne 0 ]; do
		[ "$1" == "-h" ] && warning
		[ "$1" == "-d" ] && DELETE=force
		[ "$1" == "-p" ] && DELETE=prompt
		[ "${1:0:2}" == "-c" ] && COMPRESS="${1:2}"
		FILE=$1
		shift
	done
fi

# Validate COMPRESS setting
if [[ "$COMPRESS" != [0-8] ]]; then
	echo "Error: FLAC compression level must be between 0 and 8"
	exit
fi

# Determine file type and base filename
NAME=${FILE%.*}
EXT=`echo "${FILE##*.}" | $SED 's/\(.*\)/\L\1/'`

# Exit if wrong file passed
if [[ "$EXT" != "ape" && "$EXT" != "flac" && "$EXT" != "shn" && "$EXT" != "wav" && "$EXT" != "wv" ]]; then
	echo "Error: $FILE is not a supported input format"
	exit
fi

# Verify apps exist
if [ ! -e $FLAC ]; then
	echo "Error: cannot find flac binary"
	MISSING=true
fi
if [ ! -e $METAFLAC ]; then
	echo "Error: cannot find metaflac binary"
	MISSING=true
fi
if [[ "$EXT" == "ape" && ! -e $APEINFO ]]; then
	echo "Error: cannot find apeinfo binary"
	MISSING=true
fi
if [[ "$EXT" == "ape" && ! -e $MAC ]]; then
	echo "Error: cannot find mac binary"
	MISSING=true
fi
if [[ "$EXT" == "shn" && ! -e $SHORTEN ]]; then
	echo "Error: cannot find shorten binary"
	MISSING=true
fi
if [[ "$EXT" == "wv" && ! -e $WVUNPACK ]]; then
	echo "Error: cannot find wvunpack binary"
	MISSING=true
fi
[ -n "$MISSING" ] && exit

# Original FLAC file will need to be renamed - abort of file already exists
if [[ "$EXT" == "flac" ]]; then
	if [[ -e "${NAME}_old.flac" ]]; then
		echo -e "Error: \"${NAME}_old.flac\" already exists: could not rename input file"
		exit
	else
		mv -i "$FILE" "${NAME}_old.flac"
		FILE="${NAME}_old.flac"
	fi
fi

# Transcode file
if [ "$EXT" == "ape" ]; then
	$MAC "$FILE" - -d | $FLAC -$COMPRESS -s -o "$NAME.flac" -
elif [ "$EXT" == "flac" ]; then
	$FLAC -d "$FILE" -c | $FLAC -$COMPRESS -s -o "$NAME.flac" -
elif [ "$EXT" == "shn" ]; then
	$SHORTEN -x "$FILE" - | $FLAC -$COMPRESS -s -o "$NAME.flac" -
elif [ "$EXT" == "wav" ]; then
	$FLAC -$COMPRESS -o "$NAME.flac" "$FILE"
elif [ "$EXT" == "wv" ]; then
	$WVUNPACK "$FILE" -o - | $FLAC -$COMPRESS -s -o "$NAME.flac" -
fi

# Abort if transcode failed
if [ $? -ne 0 ]; then
	echo -e "\nError: \"$FILE\" could not be converted to a FLAC file"
	if [[ "$EXT" == "flac" ]]; then
		mv "$FILE" "$NAME.flac"
	fi
	exit
fi

# Copy tags
if [[ "$EXT" == "ape" || "$EXT" == "flac" || "$EXT" == "wv" ]]; then
	echo -ne "\nCopying tags..."
	TAGS=/tmp/$PROG.$RANDOM.tags
	if [ "$EXT" == "ape" ]; then
		$APEINFO -t "$FILE" >$TAGS
	elif [ "$EXT" == "flac" ]; then
		$METAFLAC --export-tags-to=$TAGS "$FILE"
	elif [ "$EXT" == "wv" ]; then
		$WVUNPACK -qss "$FILE" >$TAGS
		wvtags
	fi
	if [[ $? -ne 0 || ! -s "$TAGS" ]]; then
		echo -ne "\nWarning: tags could not be read from \"$FILE\"\n"
	else
		$METAFLAC --import-tags-from=$TAGS "$NAME.flac"
		if [[ $? -ne 0 ]]; then
			echo -ne "\nWarning: tags could not be written to \"$NAME.flac\"\n"
		else
			echo -ne "  complete\n"
		fi
	fi
	rm $TAGS
fi

# Delete old file
if [ "$DELETE" == "prompt" ]; then
	echo -ne "\nDelete \"$FILE\"? "
	read -e DELPROMPT
	if [[ "$DELPROMPT" == "y" || "$DELPROMPT" == "Y" ]]; then
		DELETE=force
	fi
fi
echo -ne "\nConversion complete - "
if [ "$DELETE" == "force" ]; then
	rm "$FILE"
	echo -ne "deleted"
else
	echo -ne "kept"
fi
echo -ne " \"$FILE\"\n"
