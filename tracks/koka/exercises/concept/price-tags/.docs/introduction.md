# Introduction

## Overloading

Koka lets several functions share a name when their parameter types differ. The standard library has a `show`
for `int`, one for `string`, one for `bool` and many more; `3.show` and `True.show` call different functions, and
the compiler picks the right one from the argument's type.

Every definition has a full name that makes it unique. The library's are `int/show`, `bool/show`, and so on —
the part before the slash is a _qualifier_. In your own module, two definitions with the same plain name must be
given different qualifiers, written before the name:

```koka
struct point(x : int, y : int)

fun point/show(p : point) : string
  "(" ++ p.x.show ++ ", " ++ p.y.show ++ ")"

fun point/(==)(p : point, q : point) : bool
  p.x == q.x && p.y == q.y
```

Without the qualifiers, a second `show` in the module is rejected: "definition show is already defined in this
module". Calls still use the plain name: `Point(1, 2).show` finds `point/show` because the argument is a `point`.
When the types do not decide, write the qualifier yourself: `point/show(p)`, `int/show(3)`.

Operators are names too. `(==)` above defines `==` for points, so `Point(1, 2) == Point(1, 2)` now works.

## Implicit parameters

The previous lesson ended with a polymorphic function asking its caller for an operation:

```koka
fun shout(x : a, show : (a) -> string) : string
  show(x) ++ "!"
```

Writing `shout(3, int/show)` everywhere is tedious when there is only one sensible `show` for each type. Mark the
parameter _implicit_ with a `?` and the compiler passes it for you:

```koka
fun shout(x : a, ?show : (a) -> string) : string
  x.show ++ "!"

shout(3)              // "3!"
shout(Point(1, 2))    // "(1, 2)!"
shout([1, 2])         // "[1,2]!"
```

At each call, Koka looks up a function named `show` with the right type at the call site, and passes it. Inside
`shout`, the parameter is in scope under the plain name, so `x.show` calls it. Resolution goes as deep as needed:
for `shout([1, 2])` it finds the list's `show`, which takes an implicit `?show` for the elements itself, and
resolves that to `int/show`.

The same works for any name. The common ones in the library are:

| Parameter | Type | Used for |
| --- | --- | --- |
| `?show` | `(a) -> string` | turning values into text |
| `?(==)` | `(a, a) -> bool` | equality |
| `?cmp` | `(a, a) -> order` | ordering |

An `order` is one of the constructors `Lt`, `Eq` or `Gt`: the first value is less than, equal to, or greater than
the second. `cmp(3, 5)` is `Lt`. Like vectors, `order` has no `show`, but it has `==`.

An implicit parameter can still be given explicitly, by name, to override the one the compiler would choose:

```koka
shout(3, ?show = fn(n) "#" ++ n.show)    // "#3!"
```

## How the tests use them

The test harness's `assert-equal` is declared as

```koka
pub fun assert-equal(expected : a, actual : a, ?(==) : (a, a) -> bool, ?show : (a) -> string) : exn ()
```

so a test can compare values of a type only when that type has an `==` and a `show` in scope: for the
`clock` or `crate` of earlier exercises, they were written by hand in the stub. Your own `show` and `==`, once
defined, are found exactly like the library's.

## Implicits with effects

An implicit parameter's type may allow effects, as in `?show : (a) -> e string`: the function then accepts a
`show` that throws, and has the same effect `e` itself. The next lesson is about effects; for now, read `e` as
"whatever the given function may do".
