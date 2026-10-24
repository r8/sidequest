// Searches the half-open index range [lo, hi).
fun search(xs : vector<int>, value : int, lo : int, hi : int) : div maybe<int>
  if lo >= hi then return Nothing
  val mid = (lo + hi) / 2
  match xs.at(mid)
    Just(x) | x < value -> search(xs, value, mid + 1, hi)
    Just(x) | x > value -> search(xs, value, lo, mid)
    Just(_) -> Just(mid)
    Nothing -> Nothing

// find(xs, value) -> the index of `value` in the ascending vector `xs`, found by binary search,
// or Nothing when it isn't there
pub fun find(xs : vector<int>, value : int) : div maybe<int>
  search(xs, value, 0, xs.length)
