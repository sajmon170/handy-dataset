#!/bin/bash
labels=('0' 'B' 'M' 'N' 'O' 'S' 'T')

echo "Total count:"

for label in ${labels[@]}; do
	echo "$label:"
	du --inodes | grep /$label | cut -f 1 | awk '{ sum += $1 } END { print sum }'
done

