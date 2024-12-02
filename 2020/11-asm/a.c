#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>


char grid[100][100];
char gridcopy[100][100];
int rowlen=0;
int lines=0;
int fd;
int x=0,y=0;
char c; 
int ret;
FILE* file;

void printgrid(){
	printf("%d %d\n",rowlen, lines);
	for(int i=0;i<lines;i++){
		for(int j=0;j<rowlen;j++){
			printf("%c",grid[i][j]);
		}
		puts("");
	}
}

int read_char(char* c){
		int ret  = read(fd, c,1);
		if( -1 == ret ){
			puts("Erro read");
		}
		return ret;
}

int read_grid2(){
	//com libc
	file = fopen("input.txt","r");
	
	char c; 
	int x=0,y=0;
	int ret;
	while(fscanf(file,"%s",grid[lines]) != -1){
		lines++;
	}

	rowlen = strlen(grid[0]);
	fclose(file);
}
void update(){
	rowlen = x;
	lines++;
	x=0;
}
int read_grid(){

	while(ret=read_char(&c) && ret != -1){
		if( c == '\n'){
			update();
			continue;
		}
		grid[lines][x++] = c;
	}

}
int dx[8] = {-1,-1,-1, 0,0,  1,1,1};
int dy[8] = {-1, 0, 1,-1,1 ,-1,0,1};
int adj_occupied_seats(int x, int y){
	int ret=0;
	for(int i=0;i<8;i++){
		int nx = x+dx[i];
		int ny = y+dy[i];
		if(nx < 0 || nx >=lines || ny < 0 || ny >=rowlen){
			continue;
		}
		if(grid[nx][ny] == '#'){
			ret++;
		}
	}
	return ret;
}

int main(){
	fd = open("input.txt",O_RDONLY);

	read_grid();

	int changed=1;

	printgrid();
	puts("");
	memcpy(gridcopy,grid,100*100);
	while(changed){
		changed=0;
		for(int i=0;i<lines;i++){
			for(int j=0;j<rowlen;j++){
				if(grid[i][j]=='.') continue;
				int os = adj_occupied_seats(i,j);
				if(grid[i][j] == 'L'){
					if(os == 0){
						gridcopy[i][j]='#';
						changed = 1;
					}
				}
				else if(grid[i][j] == '#'){
					if(os >= 4){
						gridcopy[i][j]='L';
						changed = 1;
					}
				}
			}
		}
		memcpy(grid,gridcopy,100*100);
		printgrid();
		puts("");
	}
	int ans1=0;
		for(int i=0;i<lines;i++){
			for(int j=0;j<rowlen;j++){
				ans1+=grid[i][j]=='#';
			}
		}

	printf("Part 1 answer: %d\n",ans1);
	close(fd);
	return 0;
}
