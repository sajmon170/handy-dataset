#!/bin/bash

mapfile -t classes < <(dos2unix -O $1 | cut -d ',' -f 1 | tail -n +2)
mapfile -t files < <(dos2unix -O $1 | cut -d ',' -f 2 | tail -n +2)

mkdir -p "B" "M" "N" "O" "S" "T" "Nieznane"

for (( i=0; i<${#files[@]}; ++i )); do
	[ -f ${files[i]} ] && mv ${files[i]} ${classes[i]}/
done
