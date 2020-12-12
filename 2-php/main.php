<?php
	$filename = $argv[1];
	echo "Abrindo: " . $filename . "\n";
	if($filename == null){
		echo "Arquivo inexistente\n";
		exit();
	}
	$f = fopen($filename, "r");

	function part1_validPass($passwd, $c, $min, $max){
		$num = substr_count($passwd, $c);
		
		if($num >= $min && $num <= $max){
			return true;
		}
		else{
			return false;
		}
	}
	function part2_validPass($passwd, $c, $min, $max){
		//if($max >= strlen($passwd) ||  $min < 0) return false;
//printf("%s -> %s == %s == %s?\n",$passwd,$passwd[$min],$passwd[$max],$c);
		$A = (strcmp($passwd[$min-1],$c) == 0);
		$B = (strcmp($passwd[$max-1],$c) == 0);
		//$A = ($passwd[$min] == $c);
		//$B = ($passwd[$max] == $c);

		return ($A && !$B) || (!$A && $B);
	}

	$ans = 0;
	$ans2 = 0;

	while($line = fscanf($f,"%d-%d %c: %s")){
		list($min,$max,$c,$pass) = $line;
		//echo $min ." " . $max ." " . $c ." " . $pass . "\n";
		if(part1_validPass($pass,$c,$min,$max)){
			$ans++;
		}
		if(part2_validPass($pass,$c,$min,$max)){
			$ans2++;
		}
	}

	echo "part1 answer:" . $ans . "\n";
	echo "part2 answer:" . $ans2 . "\n";
	fclose($f);
?>
