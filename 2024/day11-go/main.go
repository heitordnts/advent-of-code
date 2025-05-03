package main

import (
	"bufio"
	"os"
)

func readInput(filename string) []string {
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanWords)

	var stones []string

	for scanner.Scan() {
		num := scanner.Text()
		stones = append(stones, num)
	}

	return stones
}

func main() {
	Solve()
	Solve2()
}
