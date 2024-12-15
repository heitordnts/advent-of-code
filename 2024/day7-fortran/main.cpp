#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long ull ;

ull calc(vector<ull> &operands ,string ops){
    unsigned long long ans=operands[0];
    int i=1;
    for(char op : ops){
        if(op == '+'){
            ans += operands[i];
        } else if(op == '*'){
            ans *= operands[i];
        } else{
            ans = stoll(to_string(ans)+to_string(operands[i]));
        }
        i++;
    }
    return ans;
}

bool bt(int k,vector<ull> &operands ,string ops,ull target){
    if(k == operands.size()-1){
        return calc(operands,ops) == target;
    }
    return bt(k+1,operands, ops+"*",target) || bt(k+1,operands, ops+"+",target) || bt(k+1,operands, ops+".",target);
}

int main(int argc, char** argv){
    string inputfile(argv[1]);
    ifstream file(inputfile);
    if(!file){
        cerr << "Error opening file!"<< endl;
        return 1;
    }
    string line;
    unsigned long long ans=0;
    while(getline(file, line)){
        ull t;
        char colon;
        stringstream ss(line);
        ss >> t >> colon;
        vector<ull> v;
        int x;
        while(ss >> x){
            v.push_back(x);
        }
        if(bt(0,v,"",t)){
            ans += t;
        }
    }

    cout << "Part1 answer: " << ans << endl;
}