include "alldifferent.mzn";

set of int: DIGIT = 0..9;

var DIGIT: S;
var DIGIT: E;
var DIGIT: N;
var DIGIT: D;
var DIGIT: M;
var DIGIT: O;
var DIGIT: R;
var DIGIT: Y;

constraint M != 0;
constraint alldifferent([S, E, N, D, M, O, R, Y]);

constraint (S*1000 + E*100 + N*10 + D) + (M*1000 + O*100 + R*10 + E) = (M*10000 + O*1000 + N*100 + E*10 + Y);

solve satisfy;  