# About

## `if`, `else if`, `else`

```inko
if a {
  …
} else if b {
  …
} else {
  …
}
```

The conditions are tried in order and the first true one wins. Braces around each body are required and
parentheses around a condition are not.

## As an expression

`if` produces the value of the branch that ran, so it can be used anywhere a value is expected:

```inko
fn pub sign(number: Int) -> String {
  if number < 0 { 'negative' } else if number == 0 { 'zero' } else { 'positive' }
}
```

The type of the whole expression is the type of the first branch; the others must be compatible. Without an `else`
the expression is `Nil`.

## Early returns

A chain of conditions often reads better as a series of early returns:

```inko
fn pub ticket_price(age: Int) -> Int {
  if age < 4 { return 0 }
  if age < 16 { return 5 }

  10
}
```

## Other control flow

`match` (pattern matching) is the tool for choosing on the shape or value of something, covered in its own
lesson. `while` and `loop` repeat while a condition holds.

## Conditional moves

Inko tracks ownership through branches: a value moved in one branch of an `if` can't be used after the `if`,
because it might be gone. The ownership lessons explain this in detail.
