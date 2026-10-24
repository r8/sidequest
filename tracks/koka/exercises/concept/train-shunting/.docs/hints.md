# Hints

## General

- [FBIP: Functional but In-Place](https://koka-lang.github.io/koka/doc/book.html#sec-fbip) in the Koka book.
- Koka's sample `samples/learn/fip.kk`, installed with Koka, walks through `fip`, `fbip` and `fip(n)`.
- A `fip` function that breaks the rules still runs and can pass the tests. To see the compiler's warnings, compile
  your file on its own from the workspace: `mise exec -- koka --verbose=0 -l train-shunting.kk`.
- The stub's `exn` is only there for `implement me`; take it out of the types.

## 1. Turn a train around

- A helper that moves the wagons one by one onto another train, with that train as an accumulator, keeps every
  call a tail call.
- The helper must be `fip` too: a `fip` function may only call `fip` functions.

## 2. Renumber the wagons

- Match on the train and rebuild each `Cons` with the new number.
- A recursive call as the last field of a constructor still counts as a loop.

## 3. Swap neighbours

- A pattern can look two wagons deep: `Cons(a, Cons(b, rest))`.
- Give the other shapes of train their own branches instead of a wildcard, and rebuild them from their parts.

## 4. Uncouple wagons

- Leaving out a matched wagon frees its cell, which `fbip` allows and `fip` does not.

## 5. Park in the sidings

- Compare the wagon with the siding's wagon to decide whether to go left, go right, or stop.
- Rebuild every siding you pass through; only the `Buffer` branch builds something new.
