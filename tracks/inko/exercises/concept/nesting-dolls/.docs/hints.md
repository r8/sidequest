# Hints

## General

- Every method has one `case` per kind of doll: `Solid` is the base case, and `Hollow` recurses into the doll
  inside.
- The manual's [pattern matching][patterns] page covers matching enum cases.

## 1. Count the dolls

- A solid doll is one doll; a hollow doll is one more than the dolls inside it.

## 2. Find the innermost doll

- Keep going inside until you reach the solid doll.

## 3. List the names

- Start an array with this doll's name and `append` the names of the doll inside.

## 4. Look for a doll

- Either this doll has the name, or the doll inside contains it: `or` stops early when the first is true.

## 5. Nest a new set

- Write a private static helper that also takes an index, and builds the doll at that index with the dolls after
  it inside. The last index is the base case.

[patterns]: https://docs.inko-lang.org/manual/latest/getting-started/pattern-matching/
