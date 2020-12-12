program HelloWorld;
uses crt;

type
row  = string;
grid = array of row;
Slope = record
	xinc : integer;
	yinc : integer;
end;

const
	filename = 'input.txt';

var
	g : grid;
	f : text;
	i,gsize,aux,ans : LongInt;
slps : array [0..4] of Slope = ((xinc:1; yinc:1), (xinc:3; yinc:1), (xinc:5; yinc:1), (xinc:7; yinc:1), (xinc:1; yinc:2));

function trees(var g : grid; slp : Slope) : integer;
var
	y : integer;
	x : integer;
	linesize : integer;
begin
	y := 0;
	x := 0;
	trees:=0;
	linesize := length(g[0]);

	while (y < gsize) do
	begin
		if g[y,x+1] = '#' then
		begin
			{g[y,x+1] := 'X';}
			trees := trees + 1;
		end;
		(*
		else
		begin
			g[y,x+1] := '0';
		end;
		writeln(g[y]);
		*)
		y+=slp.yinc;
		x+=slp.xinc;
		x := x mod linesize;
	end;
end;
	
begin {main program}
	i := 0;
	gsize := 0;
	SetLength(g, 2048);

	Assign(f, filename); {bind filename to f}

	reset(f); { open f for reading }
	
	repeat
		readln(f,g[i]);
		i:=i+1;
	until eof(f);
	close(f);
	gsize := i;

	for i:= 0 to gsize-1 do
	begin
{	writeln(g[i]);}
	end;
(*
	With slp do
	begin
		xinc := 3;
		yinc := 1;
	end;
*)
	ans := 1;
	for i:= 0 to Length(slps)-1 do
	begin 
		aux := trees(g,slps[i]);
		ans *= aux;
		writeln('Slope ',slps[i].xinc,', ',slps[i].yinc,': ',aux);
	end;

	writeln('Part 2 ans: ',ans);
end.
