# Introduction

A _closure_ is a method without a name that you can store in a variable, pass to another method, or return. It is
written with `fn`, its arguments in parentheses and a body in braces:

```inko
let double = fn (number: Int) -> Int { number * 2 }

double.call(21) # => 42
```

A closure runs when you `call` it, with its arguments in parentheses. A closure without arguments leaves out the
parentheses in both places:

```inko
let greet = fn { 'hello' }

greet.call # => 'hello'
```

You've already met one: `3.times(fn (i) { … })` passes a closure to `times`, which calls it three times.

## Closure types

A closure's type is written like its signature without names: `fn (Int) -> Int` takes an `Int` and returns an
`Int`, `fn (String) -> Bool` takes a `String` and returns a `Bool`, and `fn (Int)` returns nothing. Methods use
these types for arguments that are closures:

```inko
fn pub apply_twice(value: Int, change: fn (Int) -> Int) -> Int {
  change.call(change.call(value))
}

apply_twice(3, fn (n) { n + 10 }) # => 23
```

When a closure is passed straight to an argument whose type is known, as here, Inko infers the types of its
arguments and its return value, so `fn (n) { n + 10 }` is enough. Everywhere else, such as a closure stored in a
variable or returned from a method, write the argument types yourself; the compiler reports "can't be fully
inferred" when you forget.

## Capturing variables

A closure can use the variables around it. It _captures_ them:

```inko
let bonus = 5
let add_bonus = fn (score: Int) { score + bonus }

add_bonus.call(10) # => 15
```

Numbers, booleans and strings are captured as copies. Other values, such as arrays, are captured as borrows, so the
closure can use (and change) the original:

```inko
let seen = []
let remember = fn (word: String) { seen.push(word) }

remember.call('apple')
seen # => ['apple']
```

A closure can't assign a captured variable a new value: `fn { total += 1 }` doesn't compile, with "variables
captured by non-moving closures can't be assigned new values". Keep running totals in a loop instead.

## Returning closures

A method can build a closure and return it. The closure keeps what it captured, so each one returned can behave
differently:

```inko
fn pub multiplier(factor: Int) -> fn (Int) -> Int {
  fn (number: Int) { number * factor }
}

let triple = multiplier(3)

triple.call(5) # => 15
```

There is one catch. A closure that captures an argument or variable that is not a number, boolean or string only
_borrows_ it, and that value is dropped when the method returns, while the closure still borrows it: the program
panics with "can't drop a value … as it still has 1 reference(s)". The fix is
`fn move`: a moving closure takes ownership of what it captures, so the values live as long as the closure does:

```inko
fn pub one_of(words: Array[String]) -> fn (String) -> Bool {
  fn move (word: String) { words.contains?(word) }
}
```

Use `fn move` whenever a returned closure captures a value that isn't a number, boolean or string, such as an
array or another closure.

## Closures are values

Passing a closure to a method gives that method the closure, so you can't use the variable afterwards. Create the
closure where it's needed, or pass a fresh one each time:

```inko
let rule = fn (n: Int) { n + 1 }

apply_twice(1, rule)
apply_twice(1, rule) # error: 'rule' can't be used as it has been moved
```
