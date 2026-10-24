// accumulate(xs, f) -> the results of applying `f` to each element of `xs`, in order
pub fun accumulate(xs : list<a>, f : (a) -> e b) : e list<b>
  match xs
    Nil -> Nil
    Cons(x, rest) -> Cons(f(x), rest.accumulate(f))
