# Hints

## General

- [The Koka book on structs](https://koka-lang.github.io/koka/doc/book.html#sec-structs) covers declaring and
  constructing them.
- [Copying a struct](https://koka-lang.github.io/koka/doc/book.html#sec-copying) explains the `value(field = …)`
  syntax.

## 1. Add a bike to the fleet

- The `rider` and `km` fields have default values, so the constructor only needs the other two.

## 2. See whether a bike is free

- Read the `rider` field and check whether the string is empty.

## 3. Rent a bike out

- Copy the bike with one field changed; the original bike stays as it was.

## 4. Take a bike back

- A copy can change two fields at once, and the new value may use the old one.

## 5. Print a tag

- Build the common part first, then add the rider's part only when there is one.
