// count-if(baskets, keep) -> how many of `baskets` pass the test `keep`
pub fun count-if(baskets : list<int>, keep : (int) -> bool) : exn int
  throw("implement me", ExnTodo)

// bruise(baskets, lost) -> `baskets` with `lost` apples taken from each, down to at least 0
pub fun bruise(baskets : list<int>, lost : int) : exn list<int>
  throw("implement me", ExnTodo)

// ready-to-sell(baskets, minimum) -> the baskets holding at least `minimum` apples
pub fun ready-to-sell(baskets : list<int>, minimum : int) : exn list<int>
  throw("implement me", ExnTodo)

// all-full(baskets, capacity) -> whether every basket holds `capacity` apples
pub fun all-full(baskets : list<int>, capacity : int) : exn bool
  throw("implement me", ExnTodo)

// crates-needed(baskets, size) -> the crates of `size` apples needed to pack every basket separately
pub fun crates-needed(baskets : list<int>, size : int) : exn int
  throw("implement me", ExnTodo)
