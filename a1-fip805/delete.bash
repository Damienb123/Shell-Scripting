#!/bin/bash

read -p "Enter a course department code or number (e.g. 'cs 3424'): " input

IFS=' ' read -r dept_code course_num <<< $input

filename="${dept_code^^}${course_num}.crs"

if [ -e "data/$filename" ]; then 
	rm "data/$filename"
	echo "[ $(data) ] DELETED: $dept_code $course_num $course_name" >> data/queries.log
	echo "Course $course_num was successfully deleted."
else
	echo "ERROR: course not found"
fi

