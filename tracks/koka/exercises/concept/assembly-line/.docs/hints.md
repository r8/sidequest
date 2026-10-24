# Hints

## General

- The Koka book on [effect types](https://koka-lang.github.io/koka/doc/book.html#sec-effect-types) and on
  [polymorphic effects](https://koka-lang.github.io/koka/doc/book.html#sec-polymorphic-effects).

## 1. Run a station over a batch

- The library's higher-order functions are already polymorphic in their effects.
- Once your function no longer throws `implement me`, the stub's `<exn|e>` can become just `e`.

## 2. Send an item down the line

- `foldl` carries a value from one element of a list to the next.

## 3. Count what passes inspection

- `filter` and `length`, or a `foldl`, both work with an effectful check.

## 4. Inspect a wheel

- `throw` takes the message; the function's type keeps the `exn` effect.

## 5. Stop at the first defect

- Recursion on the list lets you stop as soon as you find the defect.
- `find` stops early too: what are you looking for?
