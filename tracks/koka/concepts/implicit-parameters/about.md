# About

## What an implicit parameter is

An implicit parameter is an ordinary parameter with a default that the compiler computes. In

```koka
fun all-same(xs : list<a>, ?(==) : (a, a) -> bool) : bool
  match xs
    Cons(x, rest) -> rest.all(fn(y) y == x)
    Nil -> True
```

a call `all-same([1, 1])` is compiled as `all-same([1, 1], ?(==) = int/(==))`. Inside the function the
parameter is in scope under the plain name `==`, and because it is the innermost definition it wins over the
global ones.

## Resolution

At a call, the compiler looks for definitions named like the parameter (`show`, `==`, `cmp`, …) whose type fits
once the call's type variables are known. Resolution is recursive: a candidate may have implicit parameters of its
own, which are resolved in turn. `[(1, "a")] == [(1, "a")]` resolves `list/(==)`, whose element `==` resolves to
the tuple's `==`, whose components resolve to `int/(==)` and `string/(==)`.

A call inside a function that itself has an implicit `?show` will pass that parameter on, so implicits flow
through layers of polymorphic code without being mentioned.

If no candidate fits, or more than one fits equally well, the call is rejected; pass the argument explicitly
then.

## Passing explicitly

`?name = expr` overrides resolution, for a different behaviour (a case-insensitive comparison, a show with units)
or to settle an ambiguity:

```koka
cheapest(items, ?cmp = fn(x, y) cmp(x.weight, y.weight))
```

## Effects

Library functions declare implicits with an effect variable — `?show : (a) -> e string` — so a `show` with
effects can be passed, and the caller gets its effect. Declaring your own implicits the same way keeps them as
flexible.

## The order type

`cmp` returns an `order`: `Lt`, `Eq` or `Gt`. It has `==` (so `cmp(a, b) == Lt` tests "less than") but no
`show`. Given a `cmp` for a type, the library derives `<`, `<=`, `>`, `>=` and `==` for it through its
`default/cmp/…` conversions.

## Implicits and the test harness

`assert-equal(expected, actual)` takes `?(==)` and `?show` for the compared type, total ones: a type can be
compared in a test only when both exist for it. That is why earlier exercises hand you a `show` and `==` next to
their types.

Implicit parameters are a recent and still evolving part of Koka; the samples in Koka's repository
(`samples/learn/implicits.kk`) show the full rules.
