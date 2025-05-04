#!/bin/bash

readonly SIGNS=("B" "M" "N" "O" "S" "T")
readonly UNKNOWN_SIGN="Nieznane"

# Output: Sign for a given video frame
# Params:
# $1 - frame index
# $2 - base sign
function video_frame_sign {
	local sign

	if [[ $(( $idx % 2 )) -eq 1 ]]; then
		sign=$UNKNOWN_SIGN
	elif [[ $(( ($idx/2) % 2 )) -eq 0 ]]; then
		sign=$2
	else
		sign=${SIGNS[$((idx / 4 % ${#SIGNS[@]}))]}
	fi

	echo $sign
}

# Output: CSV of single video frames in format (sign, filename\r\n)*
# Params:
# $1 - path to extracted video base sign set
# $2 - base sign
function init_video_csv {
	local signs
	local filenames
	
	local idx=0
	for filename in $(eval ls $1 | sort -t '-' -n -k2); do
		signs+=($(video_frame_sign $idx $2))
		filenames+=($filename)
		((idx++))
	done

	# If next and previous signs are the same then set
	# the intermediate sign to their value
	for (( idx=1; idx<${#signs[@]}; idx+=2 )); do
		if [[ "${signs[$(( $idx - 1 ))]}" == "${signs[$(( $idx + 1 ))]}" ]]; then
			signs[$idx]=${signs[$(( $idx - 1 ))]}
		fi
	done

	local csv=""

	for (( idx=0; idx<${#signs[@]}; idx++ )); do
		csv+="${signs[$idx]},${filenames[$idx]}\r\n"
	done

	echo $csv
}

# Output: CSV for a whole video set in format (sign, filename\r\n)*
# Params:
# $1 - path to a sign set
function init_video_set_csv {
	local csv=""

	local directory
	local idx=0
	for directory in $(eval ls $1 | sort -t '-' -n -k2); do
		csv+=$(init_video_csv $1/$directory/base ${SIGNS[$idx]})
		((idx++))
	done

	echo $csv
}

# Output: Initialized CSV for all sets
# Params:
# $1 - path to all sign sets
function init_all_sets_csv {
	local csv="choice,image_name\r\n"
	for directory in $(eval ls $1); do
		csv+=$(init_video_set_csv $1/$directory/extracted)
	done

	echo $csv
}

printf $(init_all_sets_csv $1)
