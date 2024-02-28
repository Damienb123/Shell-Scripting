#!/bin/bash

read -p "Enter department code (2-3 characters): " dept_code
read -p "Enter department name: " dept_name
read -p "Enter course number (4 digits): " course_num
read -p "Enter course name: " course_name
read -p "Enter course meeting days (MWF or TH): " course_sched
read -p "Enter course start date: " course_start
read -p "Enter course end date: " course_end
read -p "Enter course credit hours: " course_hours
read -p "Enter course enrollment: " course_size

filename="$dept_code^^}${course_num}.crs"

if [ -e "data/$filename" ]; then
	#read existing values
	read -r old_dept_code old_dept_name old_course_num old_course_name old_course_sched old_course_start old_course_end old_course_hours old_course_size < "data/$filename"

	#update values with new input if not blank
	dept_code="${dept_code:-$old_course_code}"
	dept_name="${dept_name:-$old_dept_name}"
	course_num="${course_num:-$old_course_num}"
	course_name="${course_name:-$old_course_name}"
	course_sched="${course_sched:-$old_course_sched}"
	course_start="${course_start:-$old_course_start}"
	course_end="${course_end:-$old_course_end}"
	course_hours="${course_hours:-$old_course_hours}"
	course_size="${course_size:-$old_coruse_size}"

	#write back to file
	echo -e "$dept_code $dept_name\n$course_name\n$course_sched $course_start $course_end\n$course_hours\n$course_size" > "data/$filename"
	echo "[ $(data) ] UPDATE: $dept_code $course_num $course_name >> data/queries.log"
	echo "Course updated successfully."
else
	echo "ERROR: course not found"
fi

