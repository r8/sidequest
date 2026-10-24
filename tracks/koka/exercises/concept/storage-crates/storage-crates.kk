// A storage space in the warehouse: vacant, or holding one item of type `a`.
pub type crate<a>
  Vacant
  Holding(item : a)

// swap(pair) -> `pair` with its two halves exchanged
pub fun swap(pair : (a, b)) : exn (b, a)
  throw("implement me", ExnTodo)

// fill(items) -> one crate holding each of `items`, in order
pub fun fill(items : list<a>) : exn list<crate<a>>
  throw("implement me", ExnTodo)

// unpack(c, fallback) -> the item in `c`, or `fallback` if `c` is vacant
pub fun unpack(c : crate<a>, fallback : a) : exn a
  throw("implement me", ExnTodo)

// repack(c, f) -> a crate holding `f` of the item in `c`; vacant if `c` is
pub fun repack(c : crate<a>, f : (a) -> b) : exn crate<b>
  throw("implement me", ExnTodo)

// holds(crates, wanted, same) -> whether a crate in `crates` holds an item that is `same` as `wanted`
pub fun holds(crates : list<crate<a>>, wanted : a, same : (a, a) -> bool) : exn bool
  throw("implement me", ExnTodo)
