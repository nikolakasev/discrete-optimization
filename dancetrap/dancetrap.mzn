% Beauty Trap
% Perform the most seductive dance

enum LEGS = {spin, leap, waltz, curtsey, prep, stand};
enum ARMS = {beckon, out, up, wrapped, neutral};
enum FACE = {smile, wink, batt, think, glow, blank};

int: maxlen;
set of int: STEP = 1..maxlen;
array[LEGS] of int: maxlegs;
array[ARMS] of int: maxarms;
array[FACE] of int: maxface;
constraint assert(maxlegs[stand] >= maxlen, "maxlegs[stand] smaller than maxlen");
constraint assert(maxarms[neutral] >= maxlen, "maxarms[neutral] smaller than maxlen");
constraint assert(maxface[blank] >= maxlen, "maxface[blank] smaller than maxlen");
array[LEGS,ARMS] of int: dance_value;
array[ARMS,FACE] of int: entice_value;
constraint assert(dance_value[stand,neutral] = 0, "incorrect dance_value array");
constraint assert(entice_value[neutral,blank] = 0, "incorrect entice_value array");
int: boredom; % how bored each step make the viewer

var STEP: len;
array[STEP] of var LEGS: legs;
array[STEP] of var ARMS: arms;
array[STEP] of var FACE: face;

array[1..7,LEGS] of 0..7: tLegs = 
     [| 2, 0, 4, 5, 6, 7
      | 0, 0, 0, 5, 6, 7
      | 2, 0, 4, 0, 0, 7
      | 2, 0, 4, 0, 6, 7
      | 2, 0, 4, 5, 0, 7
      | 0, 3, 0, 0, 6, 0
      | 2, 0, 4, 5, 6, 7 |];
      
array[1..6,ARMS] of 0..6: tArms =
     [| 0, 3, 4, 5, 6
      | 0, 3, 4, 5, 6
      | 2, 0, 4, 0, 6
      | 2, 3, 0, 0, 6
      | 0, 3, 4, 0, 6
      | 0, 3, 4, 5, 6 |];
      
array[1..7,FACE] of 0..7: tFace =
     [| 2, 3, 4, 5, 6, 7
      | 2, 3, 4, 0, 6, 7
      | 2, 3, 4, 5, 6, 7
      | 2, 3, 4, 0, 6, 7
      | 2, 3, 4, 5, 6, 7
      | 2, 3, 4, 5, 6, 7
      | 2, 3, 4, 5, 6, 7 |];

include "regular.mzn";
constraint regular(legs, 7, card(LEGS), tLegs, 1, {7});
constraint regular(arms, 6, card(ARMS), tArms, 1, {6});
constraint regular(face, 7, card(FACE), tFace, 1, {7});

% waltz at most three times in a row
constraint forall(s in 1..len-3)
                 (legs[s] = waltz /\ legs[s] = legs[s+1] /\ legs[s] = legs[s+2] -> legs[s+3] != waltz);

% between any waltz and a following curtsey there must be a stand
constraint forall(i in 1..len-1)
                 (legs[i] = waltz ->
                      forall(j in i+1..len)
                            (legs[j] = curtsey ->
                                  exists(k in i+1..j-1)(legs[k] = stand)));
                                  
% cannot make more than two gestures except for blank
constraint forall(s in 1..len-2)
                 (face[s] = face[s+1] -> ((face[s] != face[s+2]) \/ (face[s+2] = blank)));

% limit moves
constraint forall(l in LEGS)
                 (sum(s in 1..len)(legs[s] = l) <= maxlegs[l]);
constraint forall(a in ARMS)
                 (sum(s in 1..len)(arms[s] = a) <= maxarms[a]);
constraint forall(f in FACE)
                 (sum(s in 1..len)(face[s] = f) <= maxface[f]);

% dance and entice values must not be negative
array[STEP] of var int: danceV;
danceV = [dance_value[legs[s], arms[s]] | s in STEP];

array[STEP] of var int: enticeV;
enticeV = [entice_value[arms[s], face[s]] | s in STEP];

constraint forall(s in 1..len)
                 (danceV[s] >= 0 /\ enticeV[s] >= 0);


var int: obj = sum(s in 1..len)(danceV[s] + enticeV[s]) - (boredom * len);

solve maximize obj;

output ["len = \(len);\nlegs = \([legs[l] | l in 1..len] ++ [legs[maxlen]]);\narms = \([arms[l] | l in 1..len] ++ [arms[maxlen]]);\nface = \([face[l] | l in 1..len] ++ [face[maxlen]]);\nobj = \(obj);"];