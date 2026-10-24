// count-if(baskets, keep) -> how many of `baskets` pass the test `keep`
pub fun count-if(baskets : list<int>, keep : (int) -> bool) : int
  baskets.filter(keep).length

// bruise(baskets, lost) -> `baskets` with `lost` apples taken from each, down to at least 0
pub fun bruise(baskets : list<int>, lost : int) : list<int>
  baskets.map fn(apples) max(apples - lost, 0)

// ready-to-sell(baskets, minimum) -> the baskets holding at least `minimum` apples
pub fun ready-to-sell(baskets : list<int>, minimum : int) : list<int>
  baskets.filter fn(apples) apples >= minimum

// all-full(baskets, capacity) -> whether every basket holds `capacity` apples
pub fun all-full(baskets : list<int>, capacity : int) : bool
  baskets.all fn(apples) apples == capacity

// crates-needed(baskets, size) -> the crates of `size` apples needed to pack every basket separately
pub fun crates-needed(baskets : list<int>, size : int) : int
  baskets.foldl(0) fn(crates, apples)
    crates + (apples + size - 1) / size
