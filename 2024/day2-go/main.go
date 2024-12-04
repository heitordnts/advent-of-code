package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func convertToList(input string) ([]int, error) {
	parts := strings.Split(input, " ")
	numbers := make([]int, 0, len(parts))
	for _, str := range parts {
		num, err := strconv.Atoi(str)
		if err != nil {
			return nil, err
		}
		numbers = append(numbers, num)
	}
	return numbers, nil
}

func isReportOk(report []int) bool {
	only_dec, only_inc := true, true
	for i := 0; i < len(report)-1; i++ {
		diff := report[i] - report[i+1]
		if math.Abs(float64(diff)) < 1 || math.Abs(float64(diff)) > 3 {
			return false
		}
		if diff < 0 {
			only_inc = false
		}
		if diff > 0 {
			only_dec = false
		}
	}
	return only_inc || only_dec
}

func isReportOkIgnoringIdx(report []int, ignoreIdx int) bool {
	only_dec, only_inc := true, true
	var end int = len(report) - 1
	if ignoreIdx == end {
		end--
	}
	var start int = 0
	if ignoreIdx == 0 {
		start = 1
	}
	for i := start; i < end; {
		nxt := i + 1
		if nxt == ignoreIdx {
			nxt++
		}

		diff := float64(report[i] - report[nxt])
		if math.Abs(diff) < 1 || math.Abs(diff) > 3 {
			return false
		}
		if diff < 0 {
			only_inc = false
		}
		if diff > 0 {
			only_dec = false
		}

		i = nxt
	}
	return only_inc || only_dec
}

func readFile(filename string) string {
	data, e := os.ReadFile(filename)
	if e != nil {
		panic(e)
	}
	return string(data)
}

func main() {
	var dataStr = readFile(os.Args[1])

	ans, ans2 := 0, 0
	for _, report := range strings.Split(dataStr, "\n") {
		if report != "" {
			nums, _ := convertToList(report)
			//Part 1
			if isReportOk(nums) {
				ans++
			}
			//Part 2
			for i, _ := range nums {
				if isReportOkIgnoringIdx(nums, i) {
					ans2++
					break
				}
			}
		}
	}
	fmt.Println("Part1 answer: ", ans)
	fmt.Println("Part2 answer: ", ans2)
}
