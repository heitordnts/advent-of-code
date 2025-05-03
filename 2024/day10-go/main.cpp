#include <bits/stdc++.h>
#include <vector>
using namespace std;
typedef int dir_t[][2];

//#define PART1

dir_t dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

inline bool ok(int x, int y, int c, vector<string> &grid) {
  int rows = grid.size();
  int cols = grid[0].size();
  bool in = x >= 0 && y >= 0 && x < rows && y < cols;
  return in && grid[x][y] == c + 1;
}

int score(int x, int y, vector<string> &grid, set<pair<int, int>> &nines) {
  char c = grid[x][y];
  if (c == '9') {
    /*cout << "<end in " << x << ", " << y << endl;*/
    if (nines.count({x, y}) > 0) {
      return 0;
    }
    #ifdef PART1
    nines.insert({x,y});
    #endif
    return 1;
  }
  int ans = 0;
  for (int d = 0; d < 4; d++) {
    int *dir = dirs[d];
    if (ok(x + dir[0], y + dir[1], c, grid)) {
      /*cout << "go for " << x+dir[0]<<" "<<y+dir[1]<<endl;*/
      ans += score(x + dir[0], y + dir[1], grid, nines);
    }
  }
  /*cout << "ret"<< ans << c << endl;*/
  return ans;
}

int main(int argc, char **argv) {
  string inputfile(argv[1]);
  ifstream file(inputfile);
  if (!file) {
    cerr << "Error opening file!" << endl;
    return 1;
  }
  string line;
  vector<string> grid;
  while (getline(file, line)) {
    grid.push_back(line);
  }

  int ans = 0;
  for (int i = 0; i < grid.size(); i++) {
    for (int j = 0; j < grid[0].size(); j++) {
      if (grid[i][j] == '0') {
        /*cout << "Tentando em " << i << ", " << j << endl;*/
        set<pair<int, int>> nines;
        nines.clear();
        ans += score(i, j, grid, nines);
        /*cout << "TEMOS: " << ans << endl;*/
      }
    }
  }
#ifdef PART1
  cout << "Part1 " << ans << endl;
#else
  cout << "Part2 " << ans << endl;
#endif

}
