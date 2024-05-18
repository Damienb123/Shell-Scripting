# Course Management System (Shell-Scripting)

## Table of Contents
1. [Overview](#Overview)
2. [Main Features](#Main-Features)
3. [Installation](#Installation)
4. [Usage](#Usage)
5. [Script Descriptions](#Script-Descriptions)
	- assign1.bash
	- create.bash
	- delete.bash
	- enroll.bash
	- read.bash
	- total.bash
	- update.bash
6. [Example Output](#Example-Output)

## Overview
The Course Management System is a collection of bash scripts that allow users to manage course records efficiently. Users can create, read, update, delete, enroll students, and get the total number of courses through a command-line interface.

## Main Features
Create a Course Record
	- Add a new course with specific details such as department code, course number, name, schedule, dates, credit hours, and enrollment.

Read a Course Record
	- Retrieve and display information about an existing course.

Update a Course Record
	- Modify the details of an existing course.

Delete a Course Record
	- Remove an existing course from the records.

Enroll Students
	- Update the enrolled student count for a course.

Total Course Count
	- Display the total number of course records.

 ## Usage
 Run the assign1.bash script to start the Course Management System. You will be prompted to enter one of the following actions:
 
- C to create a new course record.
- R to read an existing course record.
- U to update an existing course record.
- D to delete an existing course record.
- E to update the enrolled student count of an existing course.
- T to show the total course count.
- Press CTRL-D to exit the program.

Example:
```
$ ./assign1.bash
```

## Script Descriptions (Purpose and Functionality)
assign1.bash
- This is the main script that provides a menu interface for users to manage course records by selecting various actions.
- Displays the menu and prompts the user to enter an action.
- Executes the corresponding script based on the user's input.
```
#!/bin/bash
while true; do
    clear
    echo "Enter one of the following actions or press CTRL-D to exit."
    echo "C - create a new course record"
    echo "R - read an existing course record"
    echo "U - update an existing course record"
    echo "D - delete an existing course record"
    echo "E - update enrolled student count of existing course"
    echo "T - show total course count"

    read -n 1 action

    case $action in
        C|c)
            ./create.bash
            ;;
        R|r)
            ./read.bash
            ;;
        U|u)
            ./update.bash
            ;;
        D|d)
            ./delete.bash
            ;;
        E|e)
            ./enroll.bash
            ;;
        T|t)
            ./total.bash
            ;;
        *)
            echo "ERROR: invalid option"
            ;;
    esac
done

```

create.bash
- Creates a new course record with user-provided details.
- Prompts the user to enter course details.
- Checks if the course already exists.
- Saves the new course record to a file.
```
#!/bin/bash
read -p "Enter department code (2-3 characters): " dept_code
read -p "Enter department name: " dept_name
read -p "Enter course number (4 digits): " course_num
read -p "Enter course name: " course_name
read -p "Enter course schedule (MWF or TH): " course_sched
read -p "Enter course start date: " course_start
read -p "Enter course end date: " course_end
read -p "Enter course credit hours: " credit_hours
read -p "Enter initial course enrollment: " course_size

filename="data/${dept_code^^}${course_num}.crs"

if [ -e "$filename" ]; then
    echo "ERROR: course already exists"
else
    echo -e "$dept_code $dept_name\n$course_name\n$course_sched $course_start $course_end\n$credit_hours\n$course_size" > "$filename"
    echo "[ $(date) ] CREATED: $dept_code $course_num $course_name" >> data/queries.log
    echo "Course Created successfully."
fi

```

delete.bash
- Deletes an existing course record.
- Prompts the user to enter the department code and course number.
- Deletes the corresponding course file if it exists.
```
#!/bin/bash
read -p "Enter a course department code and number (e.g., 'cs 3424'): " input

IFS=' ' read -r dept_code course_num <<< $input

filename="data/${dept_code^^}${course_num}.crs"

if [ -e "$filename" ]; then 
    rm "$filename"
    echo "[ $(date) ] DELETED: $dept_code $course_num" >> data/queries.log
    echo "Course $course_num was successfully deleted."
else
    echo "ERROR: course not found"
fi

```

enroll.bash
- Updates the enrolled student count for an existing course.
- Prompts the user to enter the department code, course number, and enrollment change amount.
- Updates the enrollment count in the course file.
```
#!/bin/bash
read -p "Enter a course department code and number (e.g., 'cs 3424'): " input_dept
read -p "Enter an enrollment change amount: " change_amt

IFS=' ' read -r dept_code course_num <<< $input_dept

filename="data/${dept_code^^}${course_num}.crs"

if [ -e "$filename" ]; then
    # Read current enrollment count
    read -r old_dept_code old_dept_name old_course_name old_course_sched old_course_start old_course_end old_course_hours old_course_size < "$filename"

    # Update enrollment count
    new_course_size=$((old_course_size + change_amt))

    # Write back to file
    echo -e "$dept_code $old_dept_name\n$old_course_name\n$old_course_sched $old_course_start $old_course_end\n$old_course_hours\n$new_course_size" > "$filename"
    echo "[ $(date) ] ENROLLMENT: $dept_code $course_num $old_course_name changed by $change_amt" >> data/queries.log
    echo "Enrollment updated successfully."
else
    echo "ERROR: course not found"
fi
```

read.bash
- Reads and displays the details of an existing course.
- Prompts the user to enter the department code and course number.
- Reads and displays the content of the corresponding course file.
```
#!/bin/bash
read -p "Enter a department code and course number (e.g., 'cs 3424'): " input

IFS=' ' read -r dept_code course_num <<< $input

filename="data/${dept_code^^}${course_num}.crs"

if [ -e "$filename" ]; then
    while IFS= read -r line; do 
        echo "$line"
    done < "$filename"
else
    echo "ERROR: course not found"
fi

```

total.bash
- Displays the total number of course records.
- Counts the number of course files in the data directory.
- Displays the total count.
```
#!/bin/bash
total=$(find data -maxdepth 1 -type f -name "*.crs" | wc -l)

echo "Total course records: $total"

```

update.bash
- Updates the details of an existing course.
- Prompts the user to enter new course details.
- Updates the course file with the new details.
```
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

filename="data/${dept_code^^}${course_num}.crs"

if [ -e "$filename" ]; then
    # Read existing values
    read -r old_dept_code old_dept_name old_course_name old_course_sched old_course_start old_course_end old_course_hours old_course_size < "$filename"

    # Update values with new input if not blank
    dept_code="${dept_code:-$old_dept_code}"
    dept_name="${dept_name:-$old_dept_name}"
    course_num="${course_num:-$old_course_num}"
    course_name="${course_name:-$old_course_name}"
    course_sched="${course_sched:-$old_course_sched}"
    course_start="${course_start:-$old_course_start}"
    course_end="${course_end:-$old_course_end}"
    course_hours="${course_hours:-$old_course_hours}"
    course_size="${course_size:-$old_course_size}"

    # Write back to file
    echo -e "$dept_code $dept_name\n$course_name\n$course_sched $course_start $course_end\n$course_hours\n$course_size" > "$filename"
    echo "[ $(date) ] UPDATE: $dept_code $course_num $course_name" >> data/queries.log
    echo "Course updated successfully."
else
    echo "ERROR: course not found"
fi

```

## Example Output
```
$ ./assign1.bash
Enter one of the following actions or press CTRL-D to exit.
C - create a new course record
R - read an existing course record
U - update an existing course record
D - delete an existing course record
E - update enrolled student count of existing course
T - show total course count
c
Enter department code (2-3 characters): cs
Enter department name: Computer Science
Enter course number (4 digits): 1010
Enter course name: Introduction to Programming
Enter course schedule (MWF or TH): MWF
Enter course start date: 2024-09-01
Enter course end date: 2024-12-15
Enter course credit hours: 3
Enter initial course enrollment: 30
Course Created successfully.

$ ./assign1.bash
Enter one of the following actions or press CTRL-D to exit.
C - create a new course record
R - read an existing course record
U - update an existing course record
D - delete an existing course record
E - update enrolled student count of existing course
T - show total course count
t
Total course records: 1

```
