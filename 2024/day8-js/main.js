const fs = require('fs');

try {
  var args = process.argv.slice(2);
  const data = fs.readFileSync(args[0], 'utf-8');
  const lines = data.split('\n');
  rows = lines.length
  cols = lines[0].length

  res = []
  compareFunc = (va, vb) => { return va.x == vb.x && va.y == vb.y }
  for (i = 0; i < rows; i++) {
    for (j = 0; j < cols; j++) {
      c = lines[i][j]
      if (c !== '.') {
        console.log(`Found ${c} in ${i},${j}`)
        for (oi = 0; oi < rows; oi++) {
          for (oj = 0; oj < cols; oj++) {
            oc = lines[oi][oj]
            if (oi != i && oj != j && c === oc) {
              console.log(`Match ${oc} in ${oi},${oj}`)
              v = { x: oi - i, y: oj - j }
              console.log(`Vec ${JSON.stringify(v)}`)
              an = { x: oi + v.x, y: oj + v.y }
              console.log(`new Antinode in ${JSON.stringify(an)}`)
              if (an.x < cols && an.x >= 0 && an.y < rows && an.y >= 0) {
                console.log(`\tinbound`)
                w=res.find((x) => compareFunc(x, an))
                console.log(w)
                if (w === undefined) {
                  console.log(`\tpushed`)
                  res.push(an)
                }
              }
              else {
                console.log("\toutbound")
              }
            }
          }
        }
      }
    }
  }
  console.log(`Part1 answer: ` + res.length)
} catch (err) {
  console.error(err);
}