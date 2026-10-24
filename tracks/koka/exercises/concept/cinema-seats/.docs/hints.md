# Hints

## General

- [The Koka book](https://koka-lang.github.io/koka/doc/book.html) introduces the language; the
  [vector module](https://koka-lang.github.io/koka/doc/std_core_vector.html) lists the functions on vectors.

## 1. Set out an empty row

- One function makes a vector that repeats a single value.

## 2. Price the seats

- `vector-init` calls a function with every index.

## 3. Check a seat

- `at` returns a `maybe`: match on it.
- Rule out negative seat numbers before reading the vector.

## 4. Book a seat

- Copy the row into a `var`, then assign to the seat's index.
- The assignment already throws the right exception past the end of the row.

## 5. Count the free seats

- `foreach` and a `var` counter, as in the previous lesson.
