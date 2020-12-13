#!/bin/bash

input=$1

# put it in lines
lines=`fmt -w 512 $input `
# fields needed
FIELDS='/ecl/ && /pid/ && /eyr/ && /hcl/ && /byr/ && /iyr/ && /hgt/'
# change the separator to endline ( default was space )
IFS=$'\n'

ans=0

# test each line
for l in $lines
do
	# match the fields
	t=`echo $l | awk $FIELDS | wc -c`;

	# test if line is valid
	if test $t -ne 0 
	then
		ans=$(( ans + 1 )) ;
	fi
done

# part 1
echo $ans

# validators
valid_ecl () {
	echo ECL;
#	e='ecl:gry'
#	e ~ /ecl:{gry|asd|dfg|fgh}/
}
