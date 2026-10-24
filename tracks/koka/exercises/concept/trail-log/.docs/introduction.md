# Introduction

## Functions that call themselves

To do something for every element of a list, a function can deal with the first element and then call itself
on the rest of the list. That is _recursion_. A recursive function has two kinds of cases:

- a **base case** that answers directly, such as the empty list, and
- a **recursive case** that does a little work and leaves the rest to a call of the same function on something
  smaller.

```koka
fun count(xs : list<string>) : int
  match xs
    Nil -> 0
    Cons(_, rest) -> 1 + count(rest)
```

`count(["a", "b"])` is `1 + count(["b"])`, which is `1 + (1 + count([]))`, which is `1 + (1 + 0)`.

Patterns can look further ahead. Here a list is taken two elements at a time, and the second element is put
back in front of the rest with `name as pattern`, which binds `more` to the whole tail while also matching it
against `Cons(b, _)`:

```koka
fun rises(xs : list<int>) : int
  match xs
    Cons(a, more as Cons(b, _)) | b > a -> 1 + rises(more)
    Cons(_, more) -> rises(more)
    Nil -> 0
```

## Accumulators

Instead of combining the result after the recursive call, a function can carry a running result along in an
extra parameter, the _accumulator_, and return it in the base case:

```koka
fun count-acc(xs : list<string>, acc : int) : int
  match xs
    Nil -> acc
    Cons(_, rest) -> count-acc(rest, acc + 1)
```

A call that is the very last thing a function does is a _tail call_, and Koka runs it without using more stack,
so accumulator-style functions work on lists of any length. A local helper keeps the extra parameter out of the
public signature:

```koka
pub fun count(xs : list<string>) : int
  fun go(ys : list<string>, acc : int) : int
    match ys
      Nil -> acc
      Cons(_, rest) -> go(rest, acc + 1)
  go(xs, 0)
```

## Termination and `div`

Koka checks that a function terminates. A function that only ever recurses on a part of its argument taken
apart by a pattern — `rest` in `Cons(_, rest)`, or `more` above — must stop, because each list is shorter than
the one it came from. Such a function is _total_, and its type is plain: `(list<string>) -> int`.

Recursion on numbers is different. Koka cannot prove that counting down `n - 1` ever stops (with a missing or
wrong base case it would not), so it says the function may _diverge_ and gives it the `div` effect. The effect
has to be in the result type, before the result:

```koka
fun countdown(n : int) : div list<int>
  if n <= 0 then [] else Cons(n, countdown(n - 1))
```

Leave out `div` and the compiler stops with an error like this, which reads backwards — it means "this
function needs `div`, but its type says it is total":

```
type error: effects do not match
  inferred effect: total
  expected effect: <div|_e>
```

The same happens when you recurse on a list that you rebuilt or shortened with a function, as in
`go(Cons(b, rest))` or `go(xs.drop(2))`: those are not parts taken apart by a pattern. Either add `div`, or
restructure the recursion so that it calls itself on a pattern variable, as `rises` does with `as`.

A function that calls a `div` function is itself `div`. That is no problem for the code that uses it: the tests
can call it, like any function. Later lessons show that `div` is one of several _effects_ Koka tracks in types.

## Pitfalls

- A missing base case does not make the program loop forever on a list — the `match` is incomplete instead,
  and Koka reports it. On numbers it can loop forever: check that the base case is reached for every input.
- Each recursive call should make progress towards the base case.
