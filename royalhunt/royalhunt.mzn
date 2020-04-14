int: n; % number of court members
set of int: COURT = 1..n;
int: emperor = 1;
array[COURT] of int: rank;
array[COURT] of int: ability;

int: m; % number of horses
set of int: HORSE = 1..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;

array[COURT,HORSE] of int: enjoy;

int: limit = max(m, n);
array[COURT] of var 0..m: horse;
array[HORSE] of var 0..n: rider;

% the emperor must enjoy the day more than anyone else
constraint forall(c in COURT)
                 (c != emperor -> horse[c] = 0 \/ (enjoy[c, horse[c]] < enjoy[emperor, horse[emperor]]));

% everyone enjoys the day
constraint forall(c in COURT)(horse[c] = 0 \/ enjoy[c, horse[c]] > 0);

constraint forall(c, c2 in COURT)
                 ((c != c2 /\ rank[c] > rank[c2]) -> 
                                                     (beauty[horse[c]] >= beauty[horse[c2]])
                                                  \/ (horse[c2] = 0)
                                                  \/ (horse[c2] = 0 /\ horse[c] = 0));

constraint forall(h, h2 in HORSE)
                 ((h != h2 /\ speed[h] > speed[h2]) ->
                                                     (ability[rider[h]] >= ability[rider[h2]])
                                                  \/ (rider[h] = 0)
                                                  \/ (rider[h] = 0 /\ rider[h2] = 0));

constraint forall(c in COURT, h in HORSE)(horse[c] = h <-> rider[h] = c);

include "globals.mzn";
% constraint inverse(horse, rider);
constraint alldifferent_except_0(horse);

var int: obj = sum(c in COURT)(if horse[c] = 0 then 0 else enjoy[c, horse[c]] endif);

solve maximize obj;

output ["horse = \(horse);\nrider = \(rider); \nobj = \(obj);"];