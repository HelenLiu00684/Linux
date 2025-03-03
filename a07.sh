#!/bin/sh -u                              
PATH=/bin:/usr/bin ; export PATH         
umask 022

# A Program to run calculations on input variables (done as arguments on execution)
# Program by Taylor Houstoun, 2024/11/07

# Deletes any existing in the CWD
rm -rf $PWD/calculator 2>/dev/null

#Makes directories in a relative position.
mkdir -p calculator/{addsub,muldivmod} 2>/dev/null
touch average.txt calculator/addsub/add.txt calculator/addsub/sub.txt calculator/muldivmod/div.txt calculator/muldivmod/mod.txt calculator/muldivmod/mul.txt

#Gatekeeps variables and then performs arithmetic on them.
if [ $# -ge 3 ]; then
	echo $(($1 + $2 + $3)) >> calculator/addsub/add.txt 2>/dev/null
	fi

if [ $# -ge 2 ]; then
	if [ $# -ge 3 ]; then
		echo $(($3 - $2)) >> calculator/addsub/sub.txt 2>/dev/null
		fi
	if [ $# = 2 ]; then
                echo $(($2 - $1)) >> calculator/addsub/sub.txt 2>/dev/null
                fi
	fi

if [ $# -ge 3 ]; then
	echo $(($1 * $2 * $3)) >> calculator/muldivmod/mul.txt 2>/dev/null
	fi

if [ $# -ge 2 ]; then
	if [ $# -ge 3 ] && [ $3 -ne 0 ]; then
		echo $(($2 / $3)) >> calculator/muldivmod/div.txt 2>/dev/null
		fi
	if [ $# = 2 ] && [ $2 -ne 0 ]; then
		echo $(($1 / $2)) >> calculator/muldivmod/div.txt 2>/dev/null
                fi
	fi

if [ $# -ge 2 ]; then
	if [ $# -ge 3 ] && [ $3 -ne 0 ]; then
		echo $(( $2 % $3 )) >> calculator/muldivmod/mod.txt 2>/dev/null
		fi
	if [ $# = 2 ] && [ $2 -ne 0 ]; then
		echo $(( $1 % $2 )) >> calculator/muldivmod/mod.txt 2>/dev/null
                fi
	fi

#A function to sum variables, average them, and display the average.
sum=0
for arg in "$@"; do
	((sum+=$arg))
done
if [ $sum != 0 ]; then
	average=$(echo "$sum / $#" | bc -l)
	echo "average=$average" > average.txt 2>/dev/null
	fi

