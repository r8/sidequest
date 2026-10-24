// These functions share their names with std's list functions, so they carry the local qualifier `ops/`:
// call them as `ops/map(xs, f)` or `xs.ops/map(f)`, also from inside this module. Implement them without
// the standard list functions.

// ops/append(xs, ys) -> the elements of `xs` followed by those of `ys`
pub fun ops/append(xs : list<a>, ys : list<a>) : list<a>
  xs.ops/foldr(ys, Cons)

// ops/concat(xss) -> the elements of every list in `xss`, in order
pub fun ops/concat(xss : list<list<a>>) : list<a>
  xss.ops/foldr([], ops/append)

// ops/filter(xs, pred) -> the elements of `xs` for which `pred` holds
pub fun ops/filter(xs : list<a>, pred : (a) -> e bool) : e list<a>
  xs.ops/foldr([], fn(x, acc) if pred(x) then Cons(x, acc) else acc)

// ops/length(xs) -> the number of elements in `xs`
pub fun ops/length(xs : list<a>) : int
  xs.ops/foldl(0, fn(n, _) n + 1)

// ops/map(xs, f) -> `f` applied to each element of `xs`
pub fun ops/map(xs : list<a>, f : (a) -> e b) : e list<b>
  xs.ops/foldr([], fn(x, acc) Cons(f(x), acc))

// ops/foldl(xs, initial, f) -> `f(acc, x)` applied to each element from the left, starting with `initial`
pub fun ops/foldl(xs : list<a>, initial : b, f : (b, a) -> e b) : e b
  match xs
    Nil -> initial
    Cons(x, rest) -> rest.ops/foldl(f(initial, x), f)

// ops/foldr(xs, initial, f) -> `f(x, acc)` applied to each element from the right, starting with `initial`
pub fun ops/foldr(xs : list<a>, initial : b, f : (a, b) -> e b) : e b
  match xs
    Nil -> initial
    Cons(x, rest) -> f(x, rest.ops/foldr(initial, f))

// ops/reverse(xs) -> the elements of `xs` in reverse order
pub fun ops/reverse(xs : list<a>) : list<a>
  xs.ops/foldl([], fn(acc, x) Cons(x, acc))
