# Introduction

Inko has no `null`. A value that may be missing is an `Option`: either `Option.Some(value)`, holding a value, or
`Option.None`, holding nothing. The type says what the value would be: `Option[Int]` is "maybe an `Int`".

You've already used options without noticing: `pop`, `first`, `last`, `find`, `index_of` and `Int.parse` all
return one, and `or` was unwrapping it.

## Creating options

```inko
let some = Option.Some(42)  # an Option[Int] holding 42
let none: Option[Int] = Option.None
```

`Option.None` needs its type written out when nothing else tells the compiler what it would hold. In a method with
a declared return type, it doesn't:

```inko
fn pub half(number: Int) -> Option[Int] {
  if number % 2 == 0 { Option.Some(number / 2) } else { Option.None }
}

half(10) # => Option.Some(5)
half(7)  # => Option.None
```

## Asking

`some?` and `none?` tell you which one you have:

```inko
half(10).some? # => true
half(7).none?  # => true
```

## Unwrapping

`or(default)` gives the value inside a `Some`, or the default for a `None`. `or_else` does the same but computes the
default with a closure, which only runs when it's needed:

```inko
half(10).or(0)                  # => 5
half(7).or(0)                   # => 0
half(7).or_else(fn { 1 + 1 })   # => 2
```

`get` (and `or_panic`) unwrap a `Some`, but panic on a `None`. Use them only when a `None` would be a bug.

## Transforming without unwrapping

`map` applies a closure to the value inside a `Some` and wraps the result in a new `Some`. A `None` stays `None`,
and the closure doesn't run:

```inko
half(10).map(fn (n) { n * 3 }) # => Option.Some(15)
half(7).map(fn (n) { n * 3 })  # => Option.None
```

`then` is like `map`, for a closure that itself returns an `Option`. It chains steps that may each fail, without
ending up with an option inside an option:

```inko
Int.parse('20', 10).then(fn (n) { half(n) }) # => Option.Some(10)
Int.parse('21', 10).then(fn (n) { half(n) }) # => Option.None, 21 is odd
Int.parse('xx', 10).then(fn (n) { half(n) }) # => Option.None, not a number
```

Chaining these methods and finishing with `or` handles every case in one expression:

```inko
half(7).map(fn (n) { 'half is ${n}' }).or('odd') # => 'odd'
```

## Options are used up

`or`, `map`, `then` and `get` take ownership of the option: once you've unwrapped it, the variable can't be used
again, even for an `Option[Int]`:

```inko
let result = half(10)

result.or(0)
result.or(1) # error: 'result' can't be used as it has been moved
```

`some?` and `none?` only look, so they can be called any number of times. When you need the value twice, unwrap it
once into a variable.

## Comparing

Options compare with `==` when their values do: `Option.Some(5) == Option.Some(5)` is true, and so is comparing
two `None`s of the same type. The pattern-matching lesson shows another way to look inside an option.
