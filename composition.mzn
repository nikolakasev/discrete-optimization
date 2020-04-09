include "globals.mzn";

int: n;
set of int: NOTE = 1..n;

set of int: POS = 1..n;

array[NOTE] of var POS: order;

% positions are all different
constraint alldifferent(order);

% the differences between adjacent notes are also all different
constraint alldifferent([abs(order[p] - order[p+1]) | p in 1..n-1]);