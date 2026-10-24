# Hints

## General

- [The Koka book on data types](https://koka-lang.github.io/koka/doc/book.html#sec-data-types) shows how types
  are declared from constructors.
- [Inductive and recursive types](https://koka-lang.github.io/koka/doc/book.html#sec-inductive-co-inductive-and-recursive-types)
  in the language specification describes types that refer to themselves.

## 1. Work out the answer

- One branch per constructor; the two sides of a sum are expressions too, so evaluate them first.

## 2. Count the keys

- Only one constructor is a number; the others count what is inside them.

## 3. Show the tape

- Build the string for each part with a recursive call and join them with `++`.

## 4. Measure the nesting

- `max(a, b)` gives the larger of two numbers.

## 5. Drop the zeros

- Drop the zeros from both sides of an addition first, then look at what came back: matching on a tuple of the two
  results lets you check both at once.
- Remember to keep looking inside products and negations.
