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

