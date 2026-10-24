# About

## Modules and methods

An Inko program is a set of modules, one per `.inko` file; `src/shop/prices.inko` is the module `shop.prices`.
A module contains methods, types, traits and constants. Methods defined at the top level are _module methods_;
methods defined inside a type are covered by later lessons.

```inko
# Returns the price including the tax.
fn pub add_tax(price: Int, tax: Int) -> Int {
  price + tax
}
```

- Argument and return types are required. A method without `->` returns `Nil`, and its last value is discarded.
- The value of the last expression is returned. `return value` returns early; a bare `return` returns `nil`.
- `pub` makes the method public. Private methods are visible to every module in the same root namespace (so all of
  `shop.*`), not just to their own file.
- Names are `snake_case`, and may end in `?` (`empty?`) for methods answering a question.
- The `# comment` lines directly above a method are its documentation; `inko doc` turns them into HTML.

## Calling

Arguments are positional, named, or positional followed by named: `add_tax(100, tax: 20)`. Named arguments make
calls with several numbers easier to read. A call without arguments needs no parentheses, which means that a
method and a variable look the same at the call site: `firing_minutes` could be either.

Inside a type, the receiver is implicit as well: `size` inside an array method means `self.size`.

## Variables and constants

```inko
let a = 10          # immutable, type inferred
let b: Int = 20     # with an explicit type
let mut c = 30      # can be reassigned
c = 40
c += 1
let old = c := 50   # swap assignment: assigns 50 and returns the previous value
let _ = something   # drops the value immediately
```

The compiler warns about unused variables and unused results; names starting with `_` silence the variable
warning, `let _ = expr` the result warning.

Constants (`let LIMIT = 10`) are defined at the top level only, are never reassigned or dropped, and are evaluated
at compile time, so their values are built from literals (arrays of literals included), other constants and
operators on them.
`let pub LIMIT = 10` makes one public.

## Operators

Inko's binary operators have no precedence and are evaluated from left to right: `1 + 2 * 3` is 9. Parenthesise
any expression that mixes operators. Operators are ordinary methods (`a + b` calls `+` on `a`), which is why they
can be defined for your own types later.

## Programs

A runnable program defines a `Main` process with a `main` method; that is where execution starts:

```inko
import std.stdio (Stdout)

type async Main {
  fn async main {
    Stdout.new.print('Hello, world!')
  }
}
```

Exercises have no `Main`: the tests import your methods and call them.
