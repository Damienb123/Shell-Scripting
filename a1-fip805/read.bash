#!/bin/bash

read -p "Enter a department code and course number (e.g., 'cs 3424'): " input

IFS= ' ' read -r dept_code course_num <<< $input

filename="${dept_code^^}${course_num}.crs"
if [ -e "data/$filename" ]; then
	while IFS= read -r line; do 
		echo "$line"
	done < "data/$filename"
else
	echo "ERROR: course not found"
fi

