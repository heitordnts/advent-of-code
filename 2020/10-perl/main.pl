#!/usr/bin/perl
use warnings;

my @adapters = ();

while($num = <STDIN>){
	push(@adapters, $num);
}

@adapters = sort {$a <=> $b} @adapters;

$prev = 0;
$threes = 0;
$ones = 0;
for ($i=0;$i<(scalar @adapters);$i=$i+1){
	$diff = $adapters[$i] - $prev;
	if($diff == 3){
		$threes = $threes + 1;
	}
	elsif($diff == 1){
		$ones = $ones + 1;
	}
	$prev = $adapters[$i];
}
$threes = $threes + 1;

print "Part 1 answer: " .$ones*$threes . "\n";
