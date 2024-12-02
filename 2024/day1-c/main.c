#include <stdio.h>
#include <stdlib.h>


int compare (const void * a, const void * b)
{
  return ( *(int*)a - *(int*)b );
}

void part1(int *a, int *b, size_t size);
void part2(int *a, int *b, size_t size);

int main(int argc, char *argv[]){
	FILE* file=fopen(argv[1],"r");

	if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

	#define MAX 10000
	int a[MAX],b[MAX];
	//if I want to allocate just enough memory, I would have to count the lines of the file
	// and then allocate the arrays in the heap

	int size=0;
	while(fscanf(file,"%d %d",&a[size],&b[size]) == 2){
		size++;
	}

	qsort(a,size,sizeof(int), compare);
	qsort(b,size,sizeof(int), compare);

	part1(a,b,size);
	part2(a,b,size);

	fclose(file);
}

void part1(int *a, int *b, size_t size){
	int ans=0;
	for(int i=0;i<size;i++){
		ans += abs(a[i]-b[i]);
	}
	printf("Part 1 answer: %d\n",ans);
}

void part2(int *a, int *b, size_t size){
	int right_counts[100000]={0};//greater number at input is less than 99999
	for(int i=0;i<size;i++){
		right_counts[b[i]]++;
	}
	int ans=0;
	for(int i=0;i<size;i++){
		ans += right_counts[a[i]] * a[i];
	}
	printf("Part 2 answer: %d\n",ans);
}

