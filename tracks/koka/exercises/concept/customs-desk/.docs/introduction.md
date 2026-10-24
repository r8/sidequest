# Introduction

## Either this or that

A `maybe<a>` says whether there is a value, but a `Nothing` cannot say _why_ there is none. When a check can fail
for a reason worth reporting, Koka code returns an `either<a,b>` instead: a value that is one of two things.

```koka
type either<a,b>
  Left(left : a)
  Right(right : b)
```

That, in essence, is how the standard library defines it. An `either<string,int>` is either a `Left` holding a `string` or a
`Right` holding an `int`. Nothing in the type says which side means what, but the convention is firm: `Right` is
the right answer, and `Left` carries what went wrong — usually a message.

```koka
fun check-age(age : int) : either<string,int>
  if age < 0 then Left("age cannot be negative")
  elif age > 150 then Left("age is not believable")
  else Right(age)
```

Both sides need a type, even when one of them is not used in a particular value, which is why a function that
returns an either is usually annotated.

## Looking inside

An either is taken apart with `match`, one branch per constructor, exactly like a maybe:

```koka
fun describe(result : either<string,int>) : string
  match result
    Left(problem) -> "rejected: " ++ problem
    Right(age) -> "accepted, aged " ++ age.show
```

The standard library also gives each either `is-left` and `is-right` tests, and `.maybe`, which keeps a `Right`'s
value as a `Just` and turns a `Left` into `Nothing`, dropping the message:

```koka
check-age(30).is-right     // True
check-age(-4).maybe        // Nothing
check-age(30).maybe        // Just(30)
```

Eithers can be compared with `==` and printed with `show` when both of their sides can, so `check-age(30) ==
Right(30)` is `True` and `check-age(-4).show` is `Left("age cannot be negative")`.

## Turning one result into another

Often a function wraps another function's result, for example to read a number from a string:

```koka
fun parse-age(text : string) : either<string,int>
  match text.parse-int
    Just(n) -> check-age(n)
    Nothing -> Left("not a number: " ++ text)
```

## One check after another

When several checks must all pass, match on the first one. A `Left` is handed straight back — the later checks
never run — and a `Right` lets the next check go ahead, inside the branch:

```koka
fun check-couple(a : int, b : int) : either<string,(int,int)>
  match check-age(a)
    Left(problem) -> Left(problem)
    Right(x) ->
      match check-age(b)
        Left(problem) -> Left(problem)
        Right(y) -> Right((x, y))
```

Notice `Left(problem) -> Left(problem)`: it looks like it returns its input unchanged, but the result has a
different type from the input (`either<string,(int,int)>` instead of `either<string,int>`), so a new `Left` is
built. The first failure decides the answer, and its message is the one that comes back.

## Pitfalls

- Forgetting a branch. A `match` that covers only `Right` still compiles, but Koka then adds the `exn` effect to
  the function, because a `Left` would fail at run time; a function declared without it is rejected. Cover both
  constructors.
- Swapping the sides. `Right` is success; mixing them up type-checks when both sides have the same type, such as
  `either<string,string>`, so read your branches twice.
- An either is not an exception: nothing is thrown or stops early by itself. Every caller decides what to do with
  a `Left`, which is exactly what makes the failure visible in the type.
