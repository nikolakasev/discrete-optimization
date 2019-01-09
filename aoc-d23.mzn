int: nBots;

int: minx;
int: maxx;
int: miny;
int: maxy;
int: minz;
int: maxz;

set of int: BOT = 1..nBots;
array[BOT] of int: range;
array[BOT, 1..3] of int: coordinates;

var minx..maxx: x;
var miny..maxy: y;
var minz..maxz: z;

function var int: manhattan(var int: x1, var int: y1, var int: z1,
                                           var int: x2, var int: y2, var int: z2) = abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2);

% the chosen coordinates must not be the same as those of any of the nano-bots
constraint forall (b in BOT) (
  (not (x = coordinates[b, 1] /\ y = coordinates[b, 2] /\ z = coordinates[b, 3]))
);

var int: inRange = sum (b in BOT) (
  range[b] >= manhattan(x, y, z, coordinates[b, 1], coordinates[b, 2], coordinates[b, 3])
);

%added a search annotation, randomly trying different areas of the search space and then fixing one or two of the dimensions and doing a local search
solve :: int_search([x,y,z], anti_first_fail, indomain_split, complete) maximize inRange;