#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

ll calc_cost(int xa, int xb, int ya, int yb, ll X, ll Y) {
  int k = (xa * yb - xb * ya);
  ll n = (yb * X - xb * Y) / k;
  ll m = (-ya * X + xa * Y) / k;
  ll p1 = n * xa + m * xb;
  ll p2 = n * ya + m * yb;
  if (p1 == X && p2 == Y) {
        return 3*n + m;
  }
  return 0;
}

int read_line(const char *fmt, int *a, int *b) {
  int x = scanf(fmt, a, b);
  return x;
}
 
void read_input(){

}

int main() {
  int a, c, b, d, t1, t2;
  long long xt, yt;
  long long ans = 0;
  long long ans2 = 0;
  while (!feof(stdin)) {
    read_line("Button A: X+%d, Y+%d\n", &a, &c);
    read_line("Button B: X+%d, Y+%d\n", &b, &d);
    read_line("Prize: X=%d, Y=%d\n", &t1, &t2);
    xt = t1 + 10000000000000L;
    yt = t2 + 10000000000000L;
    printf("%lld %lld\n", xt, yt);
      ans += calc_cost(a, b, c, d, t1,t2);
      ans2 += calc_cost(a, b, c, d, xt, yt);
  }
  printf("Part1: %lld\n", ans);
  printf("Part2: %lld\n", ans2);
}
