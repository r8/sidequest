// slices(series, slice-length) -> every run of `slice-length` consecutive characters of `series`,
// in order; throws "series cannot be empty", "slice length cannot be zero",
// "slice length cannot be negative" or "slice length cannot be greater than series length"
pub fun slices(series : string, slice-length : int) : exn list<string>
  throw("implement me", ExnTodo)
