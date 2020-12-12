#!/bin/bash

input=$1
lines=`fmt -w 512 $input `
FIELDS='/ecl/ && /pid/ && /eyr/ && /hcl/ && /byr/ && /iyr/ && /hgt/'
IFS=$'\n'

ans=0

for l in $lines
do
	t=`echo $l | awk $FIELDS | wc -c` ;
	if test $t -ne 0 
	then
		ans=$(( ans + 1 )) ;
	fi
done

echo $ans


