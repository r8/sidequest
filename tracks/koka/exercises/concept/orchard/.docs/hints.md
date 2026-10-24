# Hints

## General

- [The Koka book on anonymous functions and trailing lambdas](https://koka-lang.github.io/koka/doc/book.html#sec-anon) covers `fn` and the trailing syntax.
- [The std/core/list module](https://koka-lang.github.io/koka/doc/std_core_list.html) lists `map`, `filter`, `foldl` and the rest.

## 1. Count the baskets that match

- Call the test like any function: `keep(basket)`.
- `filter` keeps the matching baskets; then count them.

## 2. Allow for bruising

- `map` with an anonymous function that uses the number lost.
- `max(…, 0)` keeps a basket from going below zero.

## 3. Pick the baskets to sell

- `filter` keeps the order of the elements.

## 4. Check that the baskets are full

- `all` checks a condition for every element.

## 5. Count the crates

- `foldl` can add up the crates basket by basket, starting from `0`.
- A basket of `a` apples needs `(a + size - 1) / size` crates of `size`.
