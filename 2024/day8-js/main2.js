const fs = require('fs');

try {
  var args = process.argv.slice(2);
  const data = fs.readFileSync(args[0], 'utf-8');
  const lines = data.split('\n');
  rows = lines.length
  cols = lines[0].length

  res = []
  compareFunc = (va, vb) => { return va.x == vb.x && va.y == vb.y }
  inbound = (an,cols,rows) => {return an.x < cols && an.x >= 0 && an.y < rows && an.y >= 0};

  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++) {
      c = lines[i][j]
      if (c !== '.') {
        p={x:i,y:j}
        if (res.find((x) => compareFunc(x, p)) === undefined) {
          res.push(p)
        }
        console.log(`Found ${c} in ${i},${j}`)
        for (oi = 0; oi < rows; oi++) {
          for (oj = 0; oj < cols; oj++) {
            oc = lines[oi][oj]
            if (oi != i && oj != j && c === oc) {
              console.log(`Match ${oc} in ${oi},${oj}`)
              v = { x: oi - i, y: oj - j }
              console.log(`Vec ${JSON.stringify(v)}`)
              an = { x: oi + v.x, y: oj + v.y }
              while(inbound(an,cols,rows)){
                console.log(`new Antinode in ${JSON.stringify(an)}`)
                if (res.find((x) => compareFunc(x, an)) === undefined) {
                  res.push(Object.assign({}, an))
                }
                an.x += v.x
                an.y += v.y
              }
            }
          }
        }
      }
    }
  }
  for(let i=0;i<res.length;i++){
    console.log(res[i])
    s = lines[res[i].x]
    idx = res[i].y
    lines[res[i].x]= s.slice(0, idx) + '#' + s.slice(idx + 1);
  }
  for(let l of lines){
    console.log(l)
  }
  console.log(`Part2 answer: ` + res.length)
} catch (err) {
  console.error(err);
}