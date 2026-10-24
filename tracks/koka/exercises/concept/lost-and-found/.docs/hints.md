# Hints

## General

- [The std/core/maybe module](https://koka-lang.github.io/koka/doc/std_core_maybe.html) lists the functions on `maybe`.
- [The Koka book on matching](https://koka-lang.github.io/koka/doc/book.html#sec-matching) shows matching on constructors such as `Just` and `Nothing`.

## 1. Read a ticket

- `parse-int` turns a string into a `maybe<int>`.
- A guard on the `Just` branch can reject the negative numbers.

## 2. Show the first item

- `head` returns a maybe; `default` says what to use when there is nothing.

## 3. Label the owner

- `match` on the maybe, with one branch for `Just(name)` and one for `Nothing`.

## 4. Hand an item back

- Use your `ticket-number` from task 1, then index the shelf with `shelf[n]`, which is itself a maybe.
