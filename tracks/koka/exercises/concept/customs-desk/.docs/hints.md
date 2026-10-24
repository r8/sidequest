# Hints

## General

- [The Koka book on data types](https://koka-lang.github.io/koka/doc/book.html#sec-data-types) shows how types
  such as `either` are built from constructors.
- [The `std/core/either` documentation](https://koka-lang.github.io/koka/doc/std_core_either.html) lists the
  functions on eithers.

## 1. Check the bottles

- An `if … elif … else` can return `Left(…)` in some branches and `Right(…)` in another.

## 2. Check the cash

- Only one limit to check this time; 10000 itself is allowed.

## 3. Read the form

- `parse-int` returns a `maybe<int>`; match on it and build an either from each case.

## 4. Check a whole declaration

- Match on the bottles check first, and only check the cash in its `Right` branch.
- A `Left` from a check has a different type from the result you return, so build a new `Left` with its message.

## 5. Tell the traveller

- Match on the either; you do not need the pair's contents.
