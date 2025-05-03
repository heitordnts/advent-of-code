package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func Solve() {
	stones := readInput(os.Args[1])
	fmt.Println(stones)
	for i := 0; i < 25; i++ {
		stones = blink(stones)
		//fmt.Println(stones)
		fmt.Println("i", i, " size: ", len(stones))
	}
	fmt.Println("Part1: ", len(stones))

}

func trimWord(s string) string {
	res := strings.TrimLeft(s, "0")
	if res != "" {
		return res
	}
	return "0"

}

func blink(stones []string) []string {
	var newStones []string
	for _, x := range stones {
		switch {
		case x == "0":
			newStones = append(newStones, "1")
		case len(x)%2 == 0:
			newStones = append(newStones, trimWord(x[:len(x)/2]), trimWord(x[len(x)/2:]))
		default:
			xInt, _ := strconv.Atoi(x)
			y := strconv.Itoa(xInt * 2024)
			newStones = append(newStones, y)
		}
	}
	return newStones
}
