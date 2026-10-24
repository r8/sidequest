# Introduction

## Type variables

Many functions do not care what kind of value they are handling. Swapping the two halves of a pair works the
same whether they are numbers, strings or lists. Koka expresses that with _type variables_: lower-case names
such as `a` and `b` that stand for any type.

```koka
fun identity(x : a) : a
  x

fun first(p : (a, b)) : a
  p.fst
```

`identity` takes a value of some type `a` and returns a value of the same type. Each call picks the types:
`identity(3)` is an `int`, `identity("hi")` a `string`. A function with type variables is _polymorphic_ — it has
many forms. The library is full of them: `length` works on a `list<a>` of any `a`, and `map` has the type
`(list<a>, (a) -> b) -> list<b>`.

Type variables are introduced just by using them in a signature; Koka reads `fun identity(x : a) : a` as "for all
types `a`". Using the same variable twice says the two types must be equal, using different ones says they may
differ (but need not).

## Polymorphic types

Types can take type parameters too. You already know `list<a>`, `maybe<a>` and `either<a, b>`; your own types
are declared the same way, with the parameters in angle brackets:

```koka
type parcel<a>
  Unsent
  Sent(contents : a, postcode : string)
```

`Sent(3, "1011")` is a `parcel<int>`, and `Sent("letter", "1011")` a `parcel<string>`. A constructor without
fields, like `Unsent`, belongs to every `parcel<a>` at once. When nothing tells Koka which `a` is meant — an empty
list, say — add an annotation: `([] : list<int>)`.

Functions over such types are written exactly like the ones over `list<a>`, by matching:

```koka
fun postcode(p : parcel<a>) : maybe<string>
  match p
    Sent(_, code) -> Just(code)
    Unsent -> Nothing
```

## Polymorphic higher-order functions

Type variables come into their own with functions as parameters. This applies a function to a value and pairs
the result with the original:

```koka
fun tagged(x : a, f : (a) -> b) : (a, b)
  (x, f(x))

tagged(4, fn(n) n * n)            // (4, 16)
tagged("koka", fn(s) s.count)     // ("koka", 4)
```

The signature tells the whole story: whatever `f` returns, of type `b`, ends up in the pair.

## What a polymorphic function cannot do

Inside `identity`, nothing is known about `a`: it could be a number, a string, or a type that does not exist yet.
So a polymorphic function cannot compare two `a`s, add them, or show one:

```koka
fun same(x : a, y : a) : bool
  x == y    // error: identifier (==) cannot be resolved
```

`==` exists for `int`, `string`, `char` and others, but there is no `==` that works for every type. The
straightforward fix is to ask the caller for the operation, as one more parameter:

```koka
fun same(x : a, y : a, eq : (a, a) -> bool) : bool
  eq(x, y)

same(3, 3, fn(p, q) p == q)       // True
```

At the call site the type is known, so the caller's lambda can use `int`'s `==`. Passing such functions by hand
gets repetitive; the next lesson shows how Koka can pass them for you.

As before, a parameter written `(a) -> b` is a function without effects; the lesson on effect types shows how to
accept functions that throw or print.
