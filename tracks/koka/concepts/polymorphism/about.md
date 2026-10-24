# About

## Type variables are universally quantified

A signature such as `fun identity(x : a) : a` means "for all types `a`, given an `a`, return an `a`". Koka's full
type for it is `forall<a> (x : a) -> a`; the `forall` is added for you whenever a signature mentions a type
variable. The type parameters can also be named explicitly, which is occasionally clearer for long signatures:

```koka
fun ident<a>(x : a) : a
  x
```

Using one variable in two places ties the types together: `fun pair-up(x : a, y : a) : list<a>` accepts
`pair-up(1, 2)` but rejects `pair-up(1, "x")` with "types do not match".

## Instantiation and annotations

At each call, Koka _instantiates_ the type variables from the arguments. When the arguments do not determine them —
`[]`, `Nothing`, a constructor without fields — the type stays open until something else does, and an annotation
settles it where needed: `([] : list<int>)`, `(Vacant : crate<string>)`.

## Polymorphic data types

`type crate<a>`, `struct pair<a, b>(first : a, second : b)` and the standard `list<a>`, `maybe<a>`,
`either<a, b>`, `vector<a>` are type constructors: `crate` alone is not a type, `crate<int>` is. Type aliases can
be polymorphic too: `alias pair<a> = (a, a)`.

## Parametricity

A polymorphic function cannot inspect values of a type variable — there are no run-time type tests in Koka. That
restriction is useful: the signature alone says a lot. A function of type `(list<a>) -> list<a>` can only
rearrange, drop or repeat the elements it is given, never invent new ones; a function of type `(a) -> a` that
always terminates can only return its argument.

## Passing operations

To compare, order or print values of an unknown type, a polymorphic function takes the operation as a parameter:

```koka
fun largest(xs : list<a>, fallback : a, greater : (a, a) -> bool) : a
  xs.foldl(fallback) fn(best, x)
    if greater(x, best) then x else best
```

This is the explicit form of what Koka's implicit parameters (the next lesson) do for you: a parameter written
`?(==)`, `?show` or `?cmp` is the same kind of function, filled in by the compiler at the call site.

## Effects

A function parameter written `(a) -> b` must be total. Higher-order functions in the standard library are
polymorphic in effects as well as types, as in `map : (list<a>, (a) -> e b) -> e list<b>`; the lesson on effect
types explains the `e`.
