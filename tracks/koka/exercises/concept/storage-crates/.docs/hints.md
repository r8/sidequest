# Hints

## General

- The Koka book's section on [types](https://koka-lang.github.io/koka/doc/book.html#sec-types) and on
  [data types](https://koka-lang.github.io/koka/doc/book.html#sec-data-types) covers type parameters.

## 1. Swap two loads

- A tuple can be taken apart with `val (x, y) = …` or in the parameter list.

## 2. Fill crates

- A constructor is a function too: it can be passed to `map` as it is.

## 3. Unpack a crate

- Match on the two constructors.

## 4. Repack a crate

- The result has a different type parameter than the argument: build a new crate.

## 5. Look for an item

- `any` tells whether some element passes a test.
- You cannot use `==` on items of an unknown type: use the function you are given.
