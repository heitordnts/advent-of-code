package main

import (
	"fmt"
	"os"
	"strconv"
)

const MAXDEPTH int = 75

var memo map[int]map[string]uint64

func dfs(node string, depth, maxDepth int) uint64 {
	print(node)
	if x, ok := memo[depth][node]; ok {
		return x
	}
	if depth == maxDepth {
		print("*\n")
		return 1
	}
	print("\n")
	var total uint64 = 0
	switch {
	case node == "0":
		total += dfs("1", depth+1, maxDepth)
	case len(node)%2 == 0:
		total += dfs(trimWord(node[:len(node)/2]), depth+1, maxDepth) + dfs(trimWord(node[len(node)/2:]), depth+1, maxDepth)
	default:
		nodeInt, _ := strconv.Atoi(node)
		y := strconv.Itoa(nodeInt * 2024)
		total += dfs(y, depth+1, maxDepth)
	}
	memo[depth][node] = total
	return total
}

func Solve2() {
	memo = make(map[int]map[string]uint64)
	for d := range MAXDEPTH {
		memo[d] = make(map[string]uint64)
	}
	stones := readInput(os.Args[1])
	fmt.Println(stones)
	var res uint64 = 0
	for _, stn := range stones {
		res += dfs(stn, 0, MAXDEPTH)
	}
	fmt.Println("Part2: ", res)

}
