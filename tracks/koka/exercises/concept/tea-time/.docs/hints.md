# Hints

## General

- [The Koka book's tour](https://koka-lang.github.io/koka/doc/book.html#tour) shows functions and values.
- [The basics section](https://koka-lang.github.io/koka/doc/book.html#sec-basics) covers the syntax used here.

## 1. Know how long tea steeps

- A function with no parameters still has parentheses: `fun name() : int`.
- The last expression of the body is the result.

## 2. Work out the minutes left

- Call the function from task 1 instead of writing the number again.
- Put spaces around `-`: without them it becomes part of a name.

## 3. Time the kettle

- Multiply the cups by the minutes per cup; a top-level `val` can give that number a name.

## 4. Work out the time spent so far

- A function can call the other functions you have written.
