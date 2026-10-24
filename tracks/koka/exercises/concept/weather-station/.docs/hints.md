# Hints

## General

- [The Koka book on effect handlers](https://koka-lang.github.io/koka/doc/book.html#sec-handlers) introduces
  effects, operations and handlers.
- [Tail-resumptive operations](https://koka-lang.github.io/koka/doc/book.html#sec-opfun) explains `fun` and `val`
  operations, and [overriding handlers](https://koka-lang.github.io/koka/doc/book.html#sec-overriding-handlers)
  the `override` keyword.

## 1. Compare two stations

- Operations are called like functions: `reading` takes a station name.

## 2. Average the readings

- An operation can be passed to `map` like any function.
- Koka's integer division rounds down, and dividing by 0 gives 0.

## 3. Report a station

- A `val` operation is used like a value, without parentheses.

## 4. Read from a table

- `with fun reading(station) …` handles the rest of the block.
- `lookup` finds the value paired with a key in a list of pairs, as a maybe.

## 5. Calibrate the sensors

- The clause has to ask the outer handler for the reading; `override` lets it call `reading` itself.
