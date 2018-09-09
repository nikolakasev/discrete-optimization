int: l;
int: u;
int: m;

enum NEGOTIATOR;
NEGOTIATOR: dummy;

array[NEGOTIATOR] of int: honor; 
array[NEGOTIATOR, NEGOTIATOR] of int: joint;

%u is the largest possible cardinality
array[1..u] of var NEGOTIATOR: party;

%forcing to get strictly smaller and not dummy
constraint forall(i in 1..u-1)(party[i] >= party[i + 1] + (party[i] != dummy));

%constraint sum(i in 1..u)(party[i] != dummy) >= l;
%same as above, but more explicit because dummy come at the end, right after l
constraint forall(i in 1..l)(party[i] != dummy);

constraint sum(i,j in 1..u where i < j)(joint[party[i],party[j]]) >= m;

var int: obj;
constraint obj = min(i in 1..u)(honor[party[i]] );

solve maximize obj;