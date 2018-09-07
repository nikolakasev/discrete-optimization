int: nSpots;

set of int: SPOT = 1..nSpots;
array[SPOT] of int: damage;

int: size = 3;

enum SYMB;
array[SYMB] of set of SPOT: group;

array[1..size] of var SPOT: attacks;

constraint forall(i in 1..size-1) (attacks[i] < attacks[i + 1]);
constraint forall(s in SYMB) (sum(i in 1..size)(attacks[i] in group[s]) <= 1);

var int: totalDamages = sum(i in 1..size)(damage[attacks[i]]);
solve maximize (totalDamages);