# Introduction

## Booleans

`Bool` has two values, `true` and `false`. Comparisons produce them:

```inko
3 < 5   # => true
3 == 5  # => false
3 != 5  # => true
4 >= 4  # => true
```

Booleans are combined with the keywords `and` and `or`, and negated with `!`:

```inko
true and false # => false
true or false  # => true
!true          # => false
```

`and` and `or` are _short-circuiting_: the right-hand side is only evaluated when it can still change the answer.
In `ready? and launch`, `launch` is never called when `ready?` is false.

Because operators have no precedence in Inko, combine comparisons with parentheses when the expression would
otherwise be ambiguous, and especially when you negate one:

```inko
(hour >= 9) and (hour < 17)
!(hour < 9)
```

The comparison operators bind to their operands before `and` and `or`, so `hour >= 9 and hour < 17` works too,
but parentheses never hurt.

A method that answers a yes-or-no question usually returns a `Bool` and has a name ending in `?`:

```inko
fn pub adult?(age: Int) -> Bool {
  age >= 18
}
```

## Conditionals

`if` runs a block when its condition is `true`. The braces are required, the parentheses around the condition are
not:

```inko
if temperature < 0 {
  heater_on
}
```

`else` runs when the condition is false, and `else if` chains further conditions, tried from top to bottom:

```inko
if temperature < 0 {
  heater_on
} else if temperature > 25 {
  fan_on
} else {
  do_nothing
}
```

The condition must be a `Bool`: Inko has no "truthy" numbers or strings, so `if count { … }` is a compile-time
error. Write `if count > 0 { … }` instead.

## `if` is an expression

An `if` with an `else` produces a value: the value of whichever branch ran. That lets you use it as the result of a
method, or assign it to a variable:

```inko
fn pub greeting(hour: Int) -> String {
  if hour < 12 { 'Good morning' } else { 'Good afternoon' }
}

let label = if score >= 50 { 'pass' } else { 'fail' }
```

All branches must produce values of the same type. An `if` without an `else` produces `Nil`, because there is
nothing to produce when the condition is false, so you can't use its value.

When a method has to decide between several answers, an early `return` keeps the code flat:

```inko
fn pub ticket_price(age: Int) -> Int {
  if age < 4 { return 0 }
  if age < 16 { return 5 }

  10
}
```

## Strings, briefly

This lesson's answers include short words such as `'gale'`. Text between single (or double) quotes is a `String`
literal; the next lesson covers strings properly.
