#!/bin/bash
#get input from the following actions avaliable
read -p "Enter department code (2-3 characters): " dept_code
read -p "Enter department name: " dept_name
read -p "Enter course number (4 digits): " course_num
read -p "Enter course name: " course_name
read -p "Enter course schedule (MWF or TH): " course_sched
read -p "Enter course start date: " course_start
read -p "Enter course start end: " course_end
read -p "Enter course credit hours: " credit_hours
read -p "Enter initial course enrollement: " course_size

filename="${dept_code^^}${course_num}.crs"

if [ -e "data/filename" ]; then
	echo "ERROR: course already exists"
else
	echo -e "$dept_code $dept_name\n$course_name\n$course_sched $course_start $course_end\n$course_hours\n$course_size"
	echo "[ $(data) ] CREATED: $dept_code $course_num $course_name" >> data/queries.log
	echo "Course Created successfully."
fi

