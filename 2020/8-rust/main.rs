use std::env;
use std::fs::File;
use std::path::Path;
use std::io::{ prelude::*, BufReader};
use std::collections::HashSet;

struct Instruction{
	op : String,
	arg: i32,
}

fn main(){
	let args: Vec<String> = env::args().collect();
	if args.len() <= 1{
		println!("USAGE: ./main inputfile");
		return;
	}
	let filename = &args[1];
	let path = Path::new(filename);
	let display = path.display();

	let file = match File::open(&path) {
		Err(why) => panic!("couldn't open {}: {}", display, why),
		Ok(file) => file,
	};

	let reader = BufReader::new(file);

	let mut pc : i32 = 0;
	let mut acc: i32 = 0;
	let mut set: HashSet<i32> = HashSet::new();
	let lines  = reader.lines();
	let mut program: Vec<Instruction> = Vec::new();

	for line in lines{
		let s: String = line.unwrap();
		let s: Vec<&str> = s.split(' ').collect();
		let op: String  = String::from(s[0]);
		let arg: String = String::from(s[1]);
		let arg: i32 = match arg.parse(){
			Ok(num) => num,
			Err(_)  => continue,
		};
		program.push(Instruction{op: op,arg: arg});
	}

	loop {
		let inst = &program[pc as usize];
		let op = &inst.op;
		let arg = &inst.arg;

		if set.contains(&pc) == true {
			println!("Ans: {}",acc);
			break;
		}
		println!("{}:{}, {}",pc, op, arg);

		set.insert(pc);

		if op == "acc" {
			acc += arg;		
		}
		else if op == "jmp" {
			pc += arg;
			continue;
		}
		pc+=1;
	}
}
