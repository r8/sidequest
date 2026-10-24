# Introduction

An Inko program is made of _modules_: every `.inko` file is one. A module holds methods, types and constants. In
this lesson everything lives in one module, `src/kiln_schedule.inko`, and the tests import from it.

## Methods

A method is defined with `fn`, a name, its arguments in parentheses, and the type it returns after `->`:

```inko
fn pub add_tax(price: Int, tax: Int) -> Int {
  price + tax
}
```

- `pub` makes the method public, so other modules (such as the tests) can import and call it. Without `pub` it is
  private to its own module.
- Every argument has a name and a type: `price: Int`. Inko is statically typed and does not infer argument or
  return types.
- The last expression in the body is the value the method returns. There is no need to write `return`.
- A method without `-> Type` returns `Nil`: nothing useful.

`return` exists for leaving a method early:

```inko
fn pub discount(price: Int) -> Int {
  if price < 10 { return price }

  price - 5
}
```

Method names are written in `snake_case`, and may end in `?` (for questions such as `empty?`).

## Calling methods

Arguments go in parentheses, either by position or by name:

```inko
add_tax(100, 20)
add_tax(100, tax: 20)
add_tax(price: 100, tax: 20)
```

Positional arguments come before named ones. A method that takes no arguments is called without parentheses:

```inko
fn pub base_price -> Int {
  100
}

fn pub price_with_tax -> Int {
  add_tax(base_price, 20)
}
```

Methods defined at the top level of a module, like these, are _module methods_. A method can call any other method
of its own module, wherever in the file it is defined.

## Variables

`let` binds a value to a name. The type is inferred from the value, or written out after a colon:

```inko
let pieces = 12
let price: Int = 450
```

A variable defined with plain `let` can't be assigned a new value. Use `let mut` for one that changes:

```inko
let mut total = 0

total = total + 10
total += 5 # the same as total = total + 5
```

The compiler warns about variables that are never used. A name starting with `_` silences the warning.

## Constants

A name starting with a capital letter defines a constant. Constants live at the top level of a module, outside any
method, and can never be reassigned:

```inko
let SHELVES = 4

fn pub shelves_needed -> Int {
  SHELVES
}
```

## Integers and arithmetic

Whole numbers are of type `Int`: `0`, `42`, `-7`, `1_000_000` (underscores are ignored). `+`, `-` and `*` work as
you'd expect, and `==`, `!=`, `<`, `>`, `<=` and `>=` compare.

One thing to watch for: **Inko's binary operators have no precedence.** They are evaluated from left to right, so

```inko
2 + 3 * 4   # => 20, because it means (2 + 3) * 4
2 + (3 * 4) # => 14
```

Whenever you mix operators, add parentheses to say what you mean.

## Comments

A comment starts with `#` and runs to the end of the line. A comment directly above a method documents it:

```inko
# Returns the price including the tax.
fn pub add_tax(price: Int, tax: Int) -> Int {
  price + tax
}
```
