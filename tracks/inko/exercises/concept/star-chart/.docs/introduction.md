# Introduction

A _tuple_ groups a fixed number of values, which may have different types. Tuples are written as values between
parentheses, separated by commas:

```inko
(3, 4)
('Sirius', -1.46)
('Vega', 0.03, true)
```

The type of a tuple is written the same way, with types instead of values, so a method can take or return one:

```inko
fn pub origin -> (Int, Int) {
  (0, 0)
}

fn pub label(star: (String, Float)) -> String {
  …
}
```

`(Int, Int)` is a pair of integers; `(String, Float)` a string and a float. A tuple holds at most eight values,
but anything beyond two or three is easier to read as a type with named fields, which a later lesson introduces.

## Reading values

The values of a tuple are numbered from zero and read with `.0`, `.1`, and so on:

```inko
let star = ('Sirius', -1.46)

star.0 # => 'Sirius'
star.1 # => -1.46
```

Tuples can't be changed after they're created: `star.0 = 'Vega'` is a compile-time error. To "change" one, make a
new tuple:

```inko
let point = (3, 4)
let moved = (point.0 + 1, point.1)
```

## Returning several values

A method returns only one value, but that value can be a tuple, which is how Inko methods return two or three
results at once:

```inko
fn pub divide(number: Int, by: Int) -> (Int, Int) {
  (number / by, number % by)
}

divide(17, by: 5) # => (3, 2)
```

## Destructuring

`let` can take a tuple apart, binding each value to its own name. The pattern on the left has the same shape as
the tuple:

```inko
let (quotient, remainder) = divide(17, by: 5)

quotient  # => 3
remainder # => 2
```

Patterns nest, so a tuple inside a tuple is taken apart in one go, and `_` skips a value you don't need:

```inko
let entry = ('Vega', 0.03, (18, 36))
let (name, _, (x, y)) = entry

name # => 'Vega'
x    # => 18
```

## Comparing

Two tuples are equal when they have the same types and their values are equal, position by position:

```inko
(1, 2) == (1, 2) # => true
(1, 2) == (2, 1) # => false
```
