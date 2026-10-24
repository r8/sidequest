# Introduction

## Functions are values

A function can be passed to another function, just like a number or a string. Its type is written with an
arrow, the parameter types in parentheses on the left and the result type on the right:

```koka
(int) -> int            // takes an int, returns an int
(int, int) -> bool      // takes two ints, returns a bool
() -> string            // takes nothing, returns a string
```

A function that takes (or returns) a function is a _higher-order function_:

```koka
fun apply-twice(f : (int) -> int, x : int) : int
  f(f(x))

fun double(n : int) : int
  n * 2

apply-twice(double, 5)     // 20
```

Inside `apply-twice`, `f` is called like any function. A named function is passed by its name alone, without
parentheses: `double`, not `double()`.

## Anonymous functions

Often the function you pass is short and used only once. `fn` writes it in place, with parameters and a body
but no name:

```koka
apply-twice(fn(n) n + 1, 5)       // 7
```

The parameter types are usually inferred from where the function is used; you can write them as
`fn(n : int) n + 1`. An anonymous function can use the values around it — here `extra`, a parameter of the
enclosing function:

```koka
fun add-to-all(xs : list<int>, extra : int) : list<int>
  xs.map(fn(x) x + extra)
```

## The list toolkit

The standard library's list functions take functions to say what to do with each element:

| Call | Result |
| --- | --- |
| `xs.map(f)` | a new list of `f(x)` for every `x` |
| `xs.filter(p)` | the elements for which `p(x)` is `True` |
| `xs.any(p)` / `xs.all(p)` | whether some / every element satisfies `p` |
| `xs.find(p)` | the first element satisfying `p`, as a `maybe` |
| `xs.foldl(init, f)` | combines the elements from the left: `f(f(f(init, x1), x2), x3)` |
| `xs.foldr(init, f)` | combines from the right: `f(x1, f(x2, f(x3, init)))` |

```koka
[3, 1, 2].map(fn(x) x * 10)              // [30, 10, 20]
[3, 1, 2].filter(fn(x) x >= 2)           // [3, 2]
[3, 1, 2].foldl(0, fn(acc, x) acc + x)   // 6
```

`foldl` is the general one: the function receives the result so far (`acc`) and the next element, and returns
the new result so far. Note the order of its parameters, `acc` first; `foldr`'s function takes the element
first.

## Trailing lambdas

When a function's last argument is a function, it can be written _after_ the closing parenthesis. These lines
mean the same thing:

```koka
xs.map(fn(x) x * 10)
xs.map fn(x) x * 10
xs.foldl(0, fn(acc, x) acc + x)
xs.foldl(0) fn(acc, x) acc + x
```

A trailing lambda can have an indented body of several lines:

```koka
val labels = xs.map fn(x)
  val doubled = x * 2
  doubled.show ++ " apples"
```

A function without parameters can be written as a block in braces: `{ 41 }` means `fn() 41`. You have seen this
already in the tests, where `test("name") { … }` passes the test's body as a trailing block.

## Pitfalls

- `fn(acc, x)` in `foldl` takes the accumulator first; mixing the order up compiles when both have the same
  type, and gives the wrong answer.
- `xs.map(f)` returns a new list; `xs` itself is unchanged.
- A function type such as `(int) -> bool` describes a function that only computes its result. Passing one that
  can fail or loop forever needs a more general type, shown in a later lesson about effects.
