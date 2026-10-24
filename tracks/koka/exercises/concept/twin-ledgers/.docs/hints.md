# Hints

## General

- [Named and scoped handlers](https://koka-lang.github.io/koka/doc/book.html#sec-namedh) in the Koka book
  points to the samples in `samples/handlers/named`, which come with Koka.
- The stub's `exn` on the handler functions is only there for `implement me`; once a function is written, take
  it out of its type. The `exn` of the functions that call operations on a ledger stays.

## 1. Open a ledger

- Keep the balance in a `var` of the function, and let the operations read and change it.
- `with l <- named handler` binds the new handler to `l` for the rest of the block.

## 2. Transfer money

- Call `record` on each ledger; `~amount` is the negation of `amount`.

## 3. Bank the takings

- Work out the takings from the till's balance first; `max` keeps them from going negative.
- Task 2 already knows how to move money.

## 4. Audit the ledgers

- Ledgers are values like any other: fold over the list.

## 5. Close the books

- A `return` clause sees the action's result, and the `var` is still in scope there.
