# Introduction

## A value that may be missing

Some questions have no answer every time. What is the first element of an empty list? What number is written
in the string `"umbrella"`? Many languages answer with a special `null` value that crashes the program when it
is used by mistake. Koka has no `null`. Instead, a value that may be missing has the type `maybe<a>`, where `a`
is the type of the value when it is there:

```koka
val found : maybe<string> = Just("umbrella")
val lost : maybe<string> = Nothing
```

A `maybe<a>` is one of two things:

- `Just(x)`, holding a value `x` of type `a`, or
- `Nothing`, holding nothing.

Because `maybe<string>` and `string` are different types, Koka will not let you use a possibly-missing value as
if it were there. You first have to say what happens when it is not.

## Where maybes come from

Several functions you already know return one:

```koka
[3, 1, 2].head             // Just(3)
[].head                    // Nothing
["a", "b"][1]              // Just("b"): indexing a list
["a", "b"][5]              // Nothing
"42".parse-int             // Just(42)
"forty-two".parse-int      // Nothing
"hello".starts-with("he")  // a Just when the prefix is there
```

## Looking inside

The general way to use a `maybe` is to `match` on it, with one branch for each case:

```koka
fun describe(m : maybe<int>) : string
  match m
    Just(n) -> "found " ++ n.show
    Nothing -> "nothing there"
```

Since `Just` and `Nothing` are the only two possibilities, these two branches cover everything: no `_` is
needed. The patterns combine with what you know: guards (`Just(n) | n > 0 -> …`), literals (`Just(0) -> …`)
and tuples of maybes (`match (a, b)` with `(Just(x), Just(y)) -> …`).

For the common cases there are shortcuts:

```koka
"7".parse-int.default(0)       // 7
"seven".parse-int.default(0)   // 0
Just(3).is-just                // True
Nothing.is-nothing             // True
```

`.default(x)` takes the value out of a `Just`, or gives `x` for a `Nothing`. `.is-just` and `.is-nothing` only
tell which case it is, without the value.

## Returning a maybe

Your own functions return a `maybe` when they may have no answer. Wrap the answer in `Just`, and return
`Nothing` otherwise:

```koka
fun half(n : int) : maybe<int>
  if n % 2 == 0 then Just(n / 2) else Nothing
```

## Pitfalls

- `Just(3)` is not `3`: `Just(3) + 1` does not compile. Take the value out with `match` or `.default` first.
- Reaching for `.default` too early can hide a real absence. If "no value" should change what happens next,
  `match` on it instead, so that each case gets its own code.
- Maybes compare with `==` (`Just(3) == Just(3)`, `Nothing == Nothing` for a known type) and show as `Just(3)`
  or `Nothing`.
