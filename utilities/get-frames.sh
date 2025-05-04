#!/bin/bash

# Set output frame format
EXT="png"

# Get first sign timestamp
TIMESTAMP=$(mpv --term-status-msg='${=time-pos:0.01f}' $1 | tail -2 | head -1)
FILENAME=$(basename -- "$1" ".${1##*.}")
mkdir -p $FILENAME
# Extract all sign frames from input starting from $TIMESTAMP
ffmpeg -an -ss $TIMESTAMP -i $1 -r 1 -start_number 0 $FILENAME/$FILENAME-%d.$EXT

# (6) There are six signs
# (*2) Each sign is preceded by a base sign
# (*2 - 1) There's a transition between each sign
SIGN_COUNT=$((6*2*2 - 1))

# Move $SIGN_COUNT files to the base set directory.
# We omit the 0th file since it's an unnecessary FFMPEG artifact
mkdir -p $FILENAME/base
for (( i=1; i<=SIGN_COUNT; i++ )); do
	FILE=$FILENAME-$i.$EXT
	mv $FILENAME/$FILE $FILENAME/base/
done

# Move all remaining frames to another directory
mkdir -p $FILENAME/other
mv $FILENAME/*.$EXT $FILENAME/other/
