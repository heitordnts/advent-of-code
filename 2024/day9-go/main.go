package main

import (
	"fmt"
	"os"
	"slices"
)

type ContiguosBlock struct {
	id   int
	size int
}

type Disk []ContiguosBlock

func filledSlice(initvalue int, size int) []int {
	ret := make([]int, size)
	for i := range ret {
		ret[i] = initvalue
	}
	return ret
}

func readFileAsString(filename string) string {
	data, e := os.ReadFile(filename)
	if e != nil {
		panic(e)
	}
	return string(data)
}

func fillDisk(data string) Disk {
	disk := make(Disk, 0)
	var id int = 0
	var i = 0
	for i = 0; i < len(data)-1; i += 2 {
		u, f := int(data[i]-'0'), int(data[i+1]-'0')
		used := ContiguosBlock{id, u}
		free := ContiguosBlock{-1, f}
		disk = append(disk, used)
		disk = append(disk, free)
		id++
	}
	if i < len(data) {
		sz := int(data[i] - '0')
		used := ContiguosBlock{id, sz}
		disk = append(disk, used)
	}
	return disk
}

func getMem(dataStr string) []int {

	var id int = 0
	longFormat := make([]int, 0)
	var i = 0

	for i = 0; i < len(dataStr)-1; i += 2 {
		fmt.Println(id, string(dataStr[i]), string(dataStr[i+1]))
		u, f := int(dataStr[i]-'0'), int(dataStr[i+1]-'0')
		x := append(filledSlice(id, u), filledSlice(-1, f)...)
		fmt.Println(id, u, f, string(dataStr[i]), string(dataStr[i+1]), x[0:0])
		longFormat = append(longFormat, x...)
		id++
	}
	if i < len(dataStr) {
		sz := int(dataStr[i] - '0')
		x := filledSlice(id, sz)
		fmt.Println(id, string(dataStr[i]), 0)
		longFormat = append(longFormat, x...)
	}
	fmt.Printf("in size %d\n", len(longFormat))
	fmt.Printf("in size %d\n", len(dataStr))
	return longFormat

}

func toStringArray(nums []int) []string {
	ret := make([]string, 0)
	for _, x := range nums {
		ret = append(ret, fmt.Sprintf("%c", x))
	}
	return ret
}

func rearrange(s []int) {
	i, j := 0, len(s)-1
	for i < j {
		a := s[i] == -1
		b := s[j] == -1
		if a && !b {
			temp := s[i]
			s[i] = s[j]
			s[j] = temp
			i++
			j--
		} else if !a {
			i++
		} else if b {
			j--
		}
	}
}

func checksum(v []int) int {
	ans := 0
	for i, id := range v {
		if id != -1 {
			ans += id * i
		}
	}
	return ans
}
func checksum2(d Disk) int {
	ans := 0
	pos := 0
	for _, blk := range d {
		for j := 0; j < blk.size; j++ {
			if blk.id != -1 {
				ans += blk.id * pos
			}
			pos++
		}
	}
	return ans
}

func main() {
	data := readFileAsString(os.Args[1])
	s := getMem(data)
	rearrange(s)
	fmt.Println("Part1 :", checksum(s))
	disk := fillDisk(data)
	fmt.Println(disk)
	maxId := -1
	for _, b := range disk {
		maxId = max(maxId, b.id)
	}
	for i := len(disk) - 1; i >= 0; i-- {
		blk := &disk[i]
		if blk.id != -1 {
			for j := 0; j < i; j++ {
				if disk[j].id == -1 {
					freeBlk := disk[j]
					fmt.Println(i, j, blk, freeBlk)
					if freeBlk.size == blk.size {
						temp := disk[i]
						disk[i] = disk[j]
						disk[j] = temp
						fmt.Println(disk, "r1")
						break
					} else if freeBlk.size > blk.size {
						disk[j] = *blk
						blk.id = -1
						disk = slices.Insert(disk, j+1, ContiguosBlock{-1, freeBlk.size - blk.size})
						fmt.Println(disk, "r2")
						break
					}

				}
			}
		}
	}

	fmt.Println(disk)
	fmt.Println("PArt2: ", checksum2(disk))
}
