# Hints

## General

- [Functions](https://janet-lang.org/docs/functions.html) in the Janet documentation covers `fn` and closures.
- [Bindings](https://janet-lang.org/docs/bindings.html) explains `var` and `set`, which a closure needs to keep state.

## 1. Hand out numbered tickets

- Keep the next number in a `var` inside `make-dispenser`, and return an `fn` that uses it.
- The function must return the current number and only then move on to the next one.

## 2. Stamp a discount

- The returned function only needs the percentage it captured; it does not change anything.

## 3. Stop when the show is sold out

- Keep track of how many tickets are left, as well as the next number.
- `if` returns `nil` when there is no else branch and the condition is false.

## 4. Keep the night's tally

- Define one `var` in `make-tally` and two `fn`s that both use it.
- A struct literal can hold functions as values: `{:sell (fn …) :sold (fn …)}`.
