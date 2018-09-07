int: l;
int: u;
int: m;

enum NEGOTIATOR;
NEGOTIATOR: dummy;

array[NEGOTIATOR] of int: honor; 

array[NEGOTIATOR, NEGOTIATOR] of int: joint;

var set of NEGOTIATOR: negotiators;

constraint card(negotiators) >= l;
constraint card(negotiators) <= u;

constraint sum(i,j in negotiators where i < j) (joint[i, j]) >= m;

var int: minHonor;
constraint minHonor = min([honor[i] | i in NEGOTIATOR where i in negotiators]);
solve maximize(minHonor);