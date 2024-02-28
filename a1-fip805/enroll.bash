#!/bin/bash

read -p "Enter a course department code and number (e.g., 'cs 3424'): " input_dept
read -p "Enter an enrollment change amount: " change_amt

IFS=' ' read -r dept_code course_num <<< $input_dept

filename="${dept_code^^}${course_num}.crs"

if [ -e "data/$filename" ]; then
	#read current enrollment count
	read -r old_dept_code old_dept_name old_course_num old_course_name old_course_sched old_course_start old_course_end old_course_hours old_course_size < "data/$filename"

	#update enrollment count
	new_course_size=$((old_course_size + change_amt))

	#write back to file
	echo -e "$dept_code $old_dept_name\n$old_course_name\n$old_course_sched $old_course_start $old_course_end\n$old_course_hours\n$new_course_size" > "data/filename"
	echo "[ $(data) ]ENROLLMENT: $dept_code $course_num $old_course_name changed by $change_amt" >> data/queries.log
	echo "Enrollment updated successfully."
else
	echo "ERROR: course not found"
fi

