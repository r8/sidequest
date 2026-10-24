// keep(xs, pred) -> the elements of `xs` for which `pred` holds, in their original order
pub fun keep(xs : list<a>, pred : (a) -> e bool) : e list<a>
  match xs
    Nil -> Nil
    Cons(x, rest) ->
      if pred(x) then Cons(x, rest.keep(pred)) else rest.keep(pred)

// discard(xs, pred) -> the elements of `xs` for which `pred` does not hold, in their original order
pub fun discard(xs : list<a>, pred : (a) -> e bool) : e list<a>
  xs.keep(fn(x) !pred(x))
