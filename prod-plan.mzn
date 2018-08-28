% products
enum PRODUCT;
array[PRODUCT] of float: profit;

% resources
enum RESOURCE;
array[RESOURCE] of float: available;

% two-dimensional array declaration
array[PRODUCT, RESOURCE] of float: requiredQuantity;

% how much of each product should we make?
array[PRODUCT] of var int: produce;

% must produce a non-negative amount
constraint forall (p in PRODUCT) (produce[p] >= 0);

% production can only use resources available
constraint forall (r in RESOURCE) (
  sum (p in PRODUCT) (requiredQuantity[p, r] * produce[p]) <= available[r]
);

% maximize profit
solve maximize sum(p in PRODUCT) (profit[p] * produce[p]);
 
output ["\(p): \(produce[p])\n" | p in PRODUCT];