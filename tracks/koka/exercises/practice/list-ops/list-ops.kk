// These functions share their names with std's list functions, so they carry the local qualifier `ops/`:
// call them as `ops/map(xs, f)` or `xs.ops/map(f)`, also from inside this module. Implement them without
// the standard list functions.

// ops/append(xs, ys) -> the elements of `xs` followed by those of `ys`
pub fun ops/append(xs : list<a>, ys : list<a>) : exn list<a>
  throw("implement me", ExnTodo)

// ops/concat(xss) -> the elements of every list in `xss`, in order
pub fun ops/concat(xss : list<list<a>>) : exn list<a>
  throw("implement me", ExnTodo)

// ops/filter(xs, pred) -> the elements of `xs` for which `pred` holds
pub fun ops/filter(xs : list<a>, pred : (a) -> e bool) : <exn|e> list<a>
  throw("implement me", ExnTodo)

// ops/length(xs) -> the number of elements in `xs`
pub fun ops/length(xs : list<a>) : exn int
  throw("implement me", ExnTodo)

// ops/map(xs, f) -> `f` applied to each element of `xs`
pub fun ops/map(xs : list<a>, f : (a) -> e b) : <exn|e> list<b>
  throw("implement me", ExnTodo)

// ops/foldl(xs, initial, f) -> `f(acc, x)` applied to each element from the left, starting with `initial`
pub fun ops/foldl(xs : list<a>, initial : b, f : (b, a) -> e b) : <exn|e> b
  throw("implement me", ExnTodo)

// ops/foldr(xs, initial, f) -> `f(x, acc)` applied to each element from the right, starting with `initial`
pub fun ops/foldr(xs : list<a>, initial : b, f : (a, b) -> e b) : <exn|e> b
  throw("implement me", ExnTodo)

// ops/reverse(xs) -> the elements of `xs` in reverse order
pub fun ops/reverse(xs : list<a>) : exn list<a>
  throw("implement me", ExnTodo)
