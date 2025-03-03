#!/bin/bash -u                              
PATH=/bin:/usr/bin ; export PATH
umask 022


# Introduction Message
echo -e "\n\033[1;4;2m	Welcome to the Number Sorting Program\033[0m"


# Test for Integers in command line.
if test "$#" -gt 1; then
	for arg in "$@"; do
	       re="^[0-9]+$"    #This is the creation of a regular expression variable
		if [[ "$arg" =~ "$re" ]]; then    #In Bash shell [[ double brackets are needed for certain expansions. ie regex operations.
			echo "Success: There is more than one argument, and all arguments are numbers."
     		fi
  	done
else
	echo -e "\033[95mExit Condition 1:\033[0m\033[2m Too few or invalid arguments provided.\033[0m" >&2
	echo -e "\033[95mProgram terminated.\033[0m" >&2
	exit 1
fi


# Deletes existing output folder.
outdir="output"
eCond2="\033[95mExit Condition 2:\033[0m\033[2m You do not have the appropriate permissions.\033[0m\r\033[95mProgram Terminated\033[0m"
if [ -d "output" ]; then
	if test -w "$PWD"; then
		rm -rf "$PWD"/"$outdir"
		echo "The output folder has been deleted."
	else
		echo -e "$eCond2" >&2
		exit 2
	fi
fi


# Makes an ouput folder
if [ ! -d "$PWD"/"$outdir" ]; then
        if test -w "$PWD"; then
	   	mkdir "$PWD"/"$outdir"
		echo "The output folder has been created."
	else
		echo -e "$eCond2" >&2
		exit 2
        fi

fi


# Set threshold variable X.
X=$1

# A variable range test for Exit Condition 3 of threshold X.
if [ ! "$X" -gt 0 ]; then
	echo -e "\033[95mExit Condition 3:\033[0m\033[2m First argument is not in the proper range. It must be above 0.\033[0m\n\033[95mProgram Terminated.\033[0m" >&2
	exit 3
fi


# Instantiation of even and odd *number* arrays.
evenNumber=()
oddNumber=()


# Sort numbers into their even/odd arrays.
for argument in "${@:2}"; do
	if [ $(( argument % 2 )) -eq 0 ]; then
		evenNumber+=("$argument")
	else
		oddNumber+=("$argument")
	fi
done


# Sort the Even Number Array into the appropriate files
for number in "${evenNumber[@]}"; do
	if [ -w "$PWD"/"$outdir" ]; then
		if [ "$number" -lt 0 ]; then
			echo "$number" >> "$PWD"/"$outdir"/sect0_even.txt
	
		elif [ "$number" -ge 0 ] && [ "$number" -lt $(( "$X"/4 )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect1_even.txt
        
		elif [ "$number" -ge $(( "$X"/4 )) ] && [ "$number" -lt $(( "$X"/2 )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect2_even.txt
	
		elif [ "$number" -ge $(( "$X"/2 )) ] && [ "$number" -lt $(( "$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect3_even.txt
        
		elif [ "$number" -ge "$X" ] && [ "$number" -lt $(( 2*"$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect4_even.txt
	
		elif [ "$number" -ge $(( 2*"$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect5_even.txt
		fi
	else
		echo -e "$eCond2" >&2
                exit 2
	fi
done


# Sort the Even Number Array into the appropriate files
for number in "${oddNumber[@]}"; do
        if [ -w "$PWD"/"$outdir" ]; then
        	if [ "$number" -lt 0 ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect0_odd.txt

        	elif [ "$number" -ge 0 ] && [ "$number" -lt $(( "$X"/4 )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect1_odd.txt

        	elif [ "$number" -ge $(( "$X"/4 )) ] && [ "$number" -lt $(( "$X"/2 )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect2_odd.txt

        	elif [ "$number" -ge $(( "$X"/2 )) ] && [ "$number" -lt $(( "$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect3_odd.txt

        	elif [ "$number" -ge "$X" ] && [ "$number" -lt $(( 2*"$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect4_odd.txt

        	elif [ "$number" -ge $(( 2*"$X" )) ]; then
                	echo "$number" >> "$PWD"/"$outdir"/sect5_odd.txt
        	fi
        else
                echo -e "$eCond2" >&2
                exit 2
        fi
done

echo -e "The program has run to completion with the values provided.\n\n\n\033[1;2m	Here is your sorted output.\033[0m"
grep . output/* | sort -t ':' -k 2 -n
exit 0
