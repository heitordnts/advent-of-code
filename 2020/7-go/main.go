package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"strconv"
	"os"
)

type Node struct{
	x int;
	color string;
}

func countShiny(m map[string][]string) int{
	start := "shiny gold"
	queue := []string{}
	queue = append(queue,start);
	visited := make(map[string]int);
	known := make(map[string]int);
	visited[start] = 1;
	known[start] = 1;
	count := 0
	// BFS
	for len(queue) != 0 {
		top := queue[0];
		queue = queue[1:];
		visited[top] = 1

		for _,v := range m[top]{
			if _,ok2 := known[v]; !ok2 {
				known[v] = 1
				if _,ok := visited[v]; !ok{
					queue = append(queue, v);	
					count++;
				}
			}
		}
	}
	return count
}
func helper(start string,m map[string][]Node) int {
	if len(m[start]) == 0{
		return 1;
	}
	sum := 0
	for _,v := range m[start]{
		sum += v.x*helper(v.color,m);
	}
	return 1+sum;
}
func countBags(m map[string][]Node) int{
	return helper("shiny gold", m) - 1;
}

func main(){
	fmt.Println("AOC 2020 - DAY 7");

	filename := os.Args[1];

	dat, err := ioutil.ReadFile(filename);
	if(err != nil){
		panic(err);
	}
	var m map[string][]string
	m = make(map[string][]string)

	var m2 map[string][]Node
	m2 = make(map[string][]Node)

	sdat := string(dat);
	lista := strings.Split(sdat,".\n");
	
	for _, s := range lista{
		if len(s) != 0{
			aux := strings.Split(s," bags contain ");
			bag := aux[0]

			m2[bag] = []Node{};

			inbags := strings.Split(aux[1], ", ");
			//fmt.Println(bag);
			for _,v := range inbags{
				if !strings.HasPrefix(v,"no") {
					temp := strings.Fields(v)[0:3]
					value :=strings.Join(temp[1:3]," ");
					num,_ := strconv.Atoi(temp[0]);
					//fmt.Println(num)
					m2[bag] = append(m2[bag],Node{num,value});

					_, ok := m[value];
					if !ok{
						m[value] = []string{};
					}
					m[value] = append(m[value], bag);
					//fmt.Println("\t",value);
				}
			}
			//for key, value := range m{
			//	fmt.Println(key,"->",value);
			//}
		}
	}
	fmt.Println("Part 1 answer:",countShiny(m));
	fmt.Println("Part 2 answer:",countBags(m2));
}

