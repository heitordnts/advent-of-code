import sys
import re
from math import prod

def readInput(filename):
    with open(filename, 'r') as file:
        return file.readlines()

def execMult(inst):
    return prod(map(int,inst[4:-1].split(',')))
    
def part1(prg):
    pattern = r"(mul\(\d{0,3},\d{0,3}\))"

    ans=0
    matches = re.findall(pattern, prg)
    ans += sum(map(execMult,matches))
    print("Part 1 answer:",ans)

def part2(prg):
    pattern = r"(mul\(\d{0,3},\d{0,3}\))|(do\(\))|(don't\(\))"
    ans=0
    matches = [m.group() for m in re.finditer(pattern, prg)]

    multEnabled=True

    for inst in matches:
        if inst == "do()":
            multEnabled = True
        elif inst == "don't()":
            multEnabled = False
        elif inst.startswith('mul') and multEnabled:
            ans+=execMult(inst)

    print("Part 2 answer:",ans)

def main():
    inputfile = sys.argv[1]
    program = ''.join(readInput(inputfile))
    part1(program)
    part2(program)

if __name__ == "__main__":
    main()