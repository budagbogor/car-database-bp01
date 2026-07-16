const fs=require('fs');
const sql1=fs.readFileSync('sql/002_seed_data.sql', 'utf8');
const sql2=fs.readFileSync('sql/008_add_more_toyota_models.sql', 'utf8');
const m = [...sql1.matchAll(/\('([^']+)','([^']+)'/g), ...sql2.matchAll(/\('([^']+)','([^']+)'/g)];
const res={};
m.forEach(x => { res[x[1]] = res[x[1]] || new Set(); res[x[1]].add(x[2]); });
for(let k in res){
  console.log('\n==== ' + k + ' ====');
  res[k].forEach(v => console.log(v));
}
