#include <bits/stdc++.h>
using namespace std;

typedef map<int, vector<int>> AdjList;
AdjList adj;
map<int ,int> inDegree;

bool checkUpdateOrder(vector<int> &update,map<int,vector<int>> &adj){
    const int n=update.size();
    for( int i=0;i<n;i++){
        int p1 = update[i];
        for(int j=i+1;j<n;j++){
            int p2 = update[j];
            vector<int> l = adj[p1];
            if (find(l.begin(),l.end(),p2) == l.end()) {
                return false;
            }
        }
    }
    return true;
}

void dfs(int root, set<int> &visited,vector<int> &result,set<int>& present){
    cout << root << "-> " ;
    visited.insert(root);
    for(auto child : adj[root]){
        if(present.count(child)==0) continue;
        if(visited.find(child)== visited.end())
            dfs(child, visited,result,present);
    }
    cout << "inserting " << root  <<endl ;
    result.push_back(root);
}

vector<int> toposort(set<int> &present){
    set<int> visited;
    vector<int> result;

    for(auto p : adj){
        int v=p.first;
        if(present.count(v)>0 && inDegree[v] == 0 && visited.find(v) == visited.end()){
            cout << "Try node " << v << endl;
            dfs(v,visited,result,present);
        }
    }
    cout << endl;
    reverse(result.begin(),result.end());
    return result;
}

int main(int argc, char ** argv){
    string inputfile(argv[1]);
    ifstream file(inputfile);
    if(!file){
        cerr << "Error opening file!"<< endl;
        return 1;
    }

    string line;
    int ans=0,ans2=0;
    vector<int> sorted;
    while(getline(file, line)) {
        if(line.empty()){
            continue;
        } 
        if(line.find('|')!=string::npos){
            int a,b;
            char sep;
            stringstream ss(line); 
            ss >> a >> sep >> b;
            adj[a].push_back(b);
            //cout << "a=" << a << " b=" <<  b<<  "sep="<< sep <<endl;
        } else{
            vector<int> update; 
            //cout << "update: " << line << endl;
            stringstream ss(line); 
            string page;
            while(getline(ss,page,',')){
                update.push_back(stoi(page));
            }

            if(checkUpdateOrder(update,adj)){
                ans += update[update.size()/2];
            }
            else{
                set<int> present(update.begin(),update.end());
                for(auto p : adj){ inDegree[p.first] = 0; }
                for(auto p : adj){
                    for(int c : p.second)
                        if(present.count(c)>0 && present.count(p.first)>0)
                            inDegree[c] += 1;
                }
                for(auto p : inDegree){
                    cout << "in degree of " << p.first << " is " << p.second << endl;
                }
                sorted = toposort(present);
                copy(sorted.begin(),sorted.end(),ostream_iterator<int>(cout, " "));
                ans2 += sorted[sorted.size()/2];
            }

        }
    }
    cout << "Part1: "<< ans << endl;
    cout << "Part2: "<< ans2 << endl;

}