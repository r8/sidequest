# Hints

## General

- [Combining effects](https://koka-lang.github.io/koka/doc/book.html#sec-combining-effects) and
  [overriding handlers](https://koka-lang.github.io/koka/doc/book.html#sec-overriding-handlers) in the Koka book.
- The Koka sample `samples/handlers/scoped.kk` runs the same search with local and with global state.
- The stub's `exn` is only there for `implement me`; once a function is written, take it out of its type.

## 1. Explore every world

- This is the handler that resumes twice, with a `return` clause that makes a list.

## 2. Keep track of luck

- Keep the luck in a `var` and pair it with the ending in a `return` clause.

## 3. Give every world its own luck

- Tasks 1 and 2 are handlers you can stack with `with`.
- Which of the two must be captured by the resumptions so that every world gets its own copy of the luck?

## 4. Share the luck between worlds

- The same two handlers as task 3, the other way round.
- Look at the result type to see which handler is outermost.

## 5. Follow your luck

- A `fun` clause for `branch` answers once, so the story never splits.
- The clause can ask for `luck()`: a handler further out answers it.
