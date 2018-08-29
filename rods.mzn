include "alldifferent.mzn";

set of int: DIGIT = 1..9;
array[DIGIT] of int: rods = [1,2,3,4,5,2,3,4,5];

var DIGIT: M1;
var DIGIT: M2;
var DIGIT: M3;
var DIGIT: M4;
var DIGIT: M5;

constraint 2300 + M1*10 + 3 + M2*1000 + 980 + M3 = 1000*M4 + 301 + M5*10;

constraint rods[M1] + rods[M2] + rods[M3] + rods[M4] + rods[M5] = 12;

constraint alldifferent([M1, M2, M3, M4, M5]);

solve satisfy;