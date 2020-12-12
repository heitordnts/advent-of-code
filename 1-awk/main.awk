#!/usr/bin/awk -f

function bsearch(a,target){
	n = length(a)
	l = 0;
	h = n-1;
	while(l<h){
		mid = int((l+h)/2);
		if(a[mid] == target){
			return mid;
		}
		else if(target > a[mid]){
			l = mid+1
		}
		else{
			h = mid-1
		}
	}
	return -1;
}

function part1_sol1(a){
	for(i = 0;i<length(a);i++){
		for(j = 0;j<length(a);j++){
			if(a[i] + a[j] == 2020){
				return a[i]*a[j]
			}
		}
	}
}

function part1_sol2(a){
	asort(a,sorted)
	for(i = 1;i<length(sorted);i++){
		x = bsearch(sorted,2020-sorted[i]);
		if(x != -1){
			return sorted[x] * sorted[i]
		}
	}
}
function part1_sol3(a){
	for(i=0;i<length(arr);i++){
		if(complementExists[2020-arr[i]] == 1){
			return arr[i] * (2020-arr[i])
		}
	}
}

function part2_sol1(a){
#On^3
	for(i = 0;i<length(a);i++){
		for(j = 0;j<length(a);j++){
			for(k = 0;k<length(a);k++){
				if(a[i] + a[j] + a[k] == 2020){
					return a[i]*a[j]*a[k]
				}
			}
		}
	}
}
function part2_sol2(a){
#On^2 logn
	asort(a,sorted)
	for(i = 1;i<length(sorted);i++){
		for(j = 1;j<length(sorted);j++){
			x = bsearch(sorted,2020-sorted[i]-sorted[j]);
			if(x != -1 && x!=0){
				return sorted[x]*sorted[i]*sorted[j]
			}
		}
	}
}

BEGIN {print "++ AOC2020 DAY1 ++\n" }
{ #fills the array
	arr[i++] = $1
	complementExists[$1] =1 
}
END {
	print "Part1: O(n^2):",part1_sol1(arr)
	print "Part1: O(n*logn):"part1_sol2(arr)
	print "Part1: O(n) using set:"part1_sol3(arr)
	print "Part2: O(n^3):"part2_sol1(arr)
	print "Part2: O(n^2*logn):"part2_sol2(arr)

}
