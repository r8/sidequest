# Hints

## General

- [Resuming more than once](https://koka-lang.github.io/koka/doc/book.html#sec-multi-resume) in the Koka book.
- [Handling](https://koka-lang.github.io/koka/doc/book.html#sec-handling) covers `ctl` clauses and `resume`.
- The stub's `exn` is only there for `implement me`; once a function is written, take it out of its type.

## 1. Try everything

- Every `resume` returns a list here, so a `return` clause has to make a list of a finished result.
- Resume once per option, then join the lists in order: `map` and `concat` do it.
- A dead end contributes no results.

## 2. Count the ways

- What does one finished program count as, and what does a dead end count as?
- Add up what each resumption returns.

## 3. Stop at the first

- Resume with one option at a time and look at the answer before trying the next.
- A small local recursive function over the options is a tidy way to do it.

## 4. Dial a combination

- Pick the first digit, then the rest of the combination with one dial fewer.
- Recursion on a number needs `div` in the type.

## 5. Find the opening

- Build a combination with task 4, then decide whether to keep it.
