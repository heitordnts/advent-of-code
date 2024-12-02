let inputfile = "input.txt"
call bufload( bufadd(inputfile))

let lines = getbufline(bufnr(inputfile), 1 , "$")

let n = len(lines)
let t = 25

for k in range(t,n-1)
	let ok = 0 
	for i in range(k-t,k-1)
		for j in range(i+1,k-1)
			if lines[k] == lines[i]+lines[j]
				let ok = 1
			endif
		endfor
	endfor

	if !ok
		echo "Part 1 answer: " . lines[k]
		break
	endif

endfor

