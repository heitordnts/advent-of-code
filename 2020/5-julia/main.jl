println("AOC 2020 DAY 5 - JULIA")
# %inputfile="smallinput.txt"
inputfile="input.txt"

f=open(inputfile,"r")
entries=readlines(f)
close(f);

ans=0
ids=[]

# %Part 1
for entry in entries
	global ans,ids;
	s=entry
	col="0b"*join(map(x -> x=="R" ? 1 : 0, split(s[8:10],"")))
	row="0b"*join(map(x -> x=="B" ? 1 : 0, split(s[1:7]  ,"")))
	col = parse(Int,col)
	row = parse(Int,row)
	seatId = row*8 + col
	push!(ids,seatId);
	println("[",row,", ",col,"] -> seatId: ",seatId)
	ans=max(ans,seatId)
end

println("Part 1 Answer: ",ans);

# %Part 2
possibleSeats = [x*8 + y for x in 0:127, y in 0:7]

# %if x not exists and x-1 and x+1 exists, then x is my seat
for i in possibleSeats[2:end-1]
	if !(i in ids) && i-1 in ids && i+1 in ids
		println("Part 2 Answer: ",i);
	end
end


