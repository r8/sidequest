fun windows(cs : list<char>, n : int) : list<string>
  match cs
    Cons(_, rest) | cs.length >= n -> Cons(cs.take(n).string, windows(rest, n))
    _ -> []

// slices(series, slice-length) -> every run of `slice-length` consecutive characters of `series`,
// in order; throws "series cannot be empty", "slice length cannot be zero",
// "slice length cannot be negative" or "slice length cannot be greater than series length"
pub fun slices(series : string, slice-length : int) : exn list<string>
  val cs = series.list
  if cs.is-empty then throw("series cannot be empty")
  if slice-length == 0 then throw("slice length cannot be zero")
  if slice-length < 0 then throw("slice length cannot be negative")
  if slice-length > cs.length then throw("slice length cannot be greater than series length")
  windows(cs, slice-length)
