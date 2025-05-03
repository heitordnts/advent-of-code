package main

import (
	"fmt"
	"os"
)

var visited [][]bool

func main() {
	x, e := os.ReadFile(os.Args[1])
	if e != nil {
		panic(e)
	}
	//	print("size of x : ", len(x))
	var n = len(x)
	var m [][]byte
	var t []byte
	for i := 0; i < n; i++ {
		if x[i] == '\n' {
			m = append(m, t)
			t = []byte{}
		} else {
			t = append(t, x[i])
			//			println(len(t))
		}
	}
	rows := len(m)
	cols := len(m[0])

	visited = make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	var ans = 0
	println(dfs2(0, 0, m))

	// for i := 0; i < rows; i++ {
	// 	for j := 0; j < cols; j++ {
	// 		if !visited[i][j] {
	// 			var a, p int
	// 			dfs(i, j, m, &a, &p)
	// 			fmt.Println(">>", a, p)
	// 			ans += a * p
	// 		}
	// 	}
	// }
	fmt.Println("Part 1: ", ans)

}

var dirs = [][]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

func inside(x, y int, m [][]byte) bool {
	rows := len(m)
	cols := len(m[0])
	return !(x < 0 || y < 0 || x >= rows || y >= cols)
}
func dfs2(x, y int, m [][]byte) (a, p int) {
	visited[x][y] = true
	fmt.Printf("m(%d,%d) = %c\n", x, y, m[x][y])
	a = 1
	p = 0
	for _, dir := range dirs {
		nx := x + dir[0]
		ny := y + dir[1]
		if !inside(nx, ny, m) || m[nx][ny] != m[x][y] {
			p++
		}
		if inside(nx, ny, m) && !visited[nx][ny] && m[nx][ny] == m[x][y] {
			aa, pp := dfs2(nx, ny, m)
			a += aa
			p += pp
		}
	}
	return
}

func dfs(x, y int, m [][]byte, area *int, perim *int) {
	visited[x][y] = true
	fmt.Printf("m(%d,%d) = %c\n", x, y, m[x][y])
	*area++
	for _, dir := range dirs {
		nx := x + dir[0]
		ny := y + dir[1]
		if !inside(nx, ny, m) || m[nx][ny] != m[x][y] {
			*perim++
		}
		if inside(nx, ny, m) && !visited[nx][ny] && m[nx][ny] == m[x][y] {
			dfs(nx, ny, m, area, perim)
		}
	}
	return
}
