# Hints

## General

- The [Option][option] documentation describes every method, with examples.

## 1. Check a ticket number

- Return `Option.Some(number)` or `Option.None` from the two branches of an `if`.

## 2. Read a handwritten ticket

- `Int.parse(text, 10)` returns an `Option[Int]`. Pass its value on to `ticket` with `then`.

## 3. Find an item

- Loop over the items and `return` an `Option.Some` as soon as one matches; return `Option.None` after the loop.

## 4. Find the shelf

- `map` changes the value inside a `Some` and leaves a `None` alone.

## 5. Print the ticket label

- `map` the ticket to the label text, then provide the text for a missing ticket with `or`.

[option]: https://docs.inko-lang.org/std/latest/module/std/option/Option/
