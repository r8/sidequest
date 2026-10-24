# About

## Declaring and assigning

```koka
var count := 0          // declare, with its first value
count := count + 1      // assign
```

Declaration and assignment both use `:=`; `var count = 0` is a syntax error. The variable's type is inferred from
its first value, or given explicitly: `var seen : list<string> := []`. Assigning a `val`, or a parameter, is a type
error — only names declared with `var` can change.

## What a `var` is

Under the hood a `var` is a piece of state handled by a local effect (`local<h>`), which the compiler discharges
when the function returns. Because the variable cannot be reached from outside the call, the function's type does
not mention it: a function that uses `var`s internally can be `total`.

The flip side is that a `var` cannot escape. Returning a lambda that refers to it is rejected with "abstract
type(s) escape(s) into the context". To keep state between calls, pass it in and return it, keep it in a data
structure, or — as later lessons show — use a handler or a reference (`ref`), whose effects then appear in the
types.

## Capturing in lambdas

The bodies of `for`, `foreach` and friends are lambdas, and they may assign the enclosing function's `var`s; that
is how loops accumulate results. Each assignment is visible immediately to the code that follows.

## Values stay values

Assigning a variable replaces the value it holds; it never changes the value itself. After

```koka
var xs := [1, 2]
val before = xs
xs := Cons(0, xs)
```

`before` is still `[1, 2]`. When a `var` holds the only reference to a value (a vector, for instance), Koka's
reference counting lets updates through it happen in place, which a later lesson on vectors uses.

## Style

Functional code with `map`, `filter`, `foldl` and recursion is the usual Koka style. `var` earns its place when
several running values change together, or when a step-by-step description is simply clearer.
