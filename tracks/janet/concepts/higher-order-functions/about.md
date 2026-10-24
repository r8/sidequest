# About

## Writing function values

- `(fn [args] body)` creates an anonymous function; `(fn name [args] body)` gives it a name for stack traces and for calling itself.
- `|(…)` is short for `(fn [$] (…))`; it takes `$0`, `$1`, … for more arguments and `$&` for the rest. It is read before the code is compiled, so a nested short function's `$` is its own argument.
- An existing function is passed by name: `(map string/ascii-lower words)`.

## The sequence functions

All of these accept tuples, arrays, and other indexed collections, and most also accept tables, structs and strings (iterating over their values or bytes).

| Function | Returns |
| --- | --- |
| `(map f xs)` | a new array of `(f x)`; with several collections, `f` takes one element of each and the shortest decides the length |
| `(filter pred xs)` | a new array of the elements where `pred` is truthy |
| `(keep f xs)` | a new array of the truthy results of `(f x)` — `map` and `filter` in one |
| `(count pred xs)` | how many elements satisfy `pred` |
| `(find pred xs)` / `(find-index pred xs)` | the first matching element / its index, or `nil` |
| `(some f xs)` | the first truthy `(f x)`, or `nil` |
| `(all pred xs)` | `true` when `pred` holds for every element, `false` otherwise |
| `(reduce f init xs)` | `init` combined with every element in turn by `(f acc x)` |
| `(reduce2 f xs)` | like `reduce`, starting from the first element; `nil` for an empty collection |
| `(mapcat f xs)` | the results of `f`, which are collections, concatenated into one array |
| `(take-while pred xs)` / `(drop-while pred xs)` | the leading elements that satisfy `pred` / everything after them |

Helpers for common reductions: `sum`, `product`, `max-of`, `min-of`, `mean`, `frequencies`, and `extreme`, which picks the "best" element by a comparison function.

## Making functions from functions

- `(partial f a b)` fixes the first arguments: `(partial string "Dear ")`.
- `(comp f g h)` composes right to left: `((comp f g) x)` is `(f (g x))`.
- `(complement pred)` negates a predicate.
- `(juxt f g)` returns a function giving the tuple `[(f x) (g x)]`.
- `(apply f a b xs)` calls `f` with `a`, `b` and then the elements of `xs` as separate arguments.
- `identity` returns its argument, handy as a default function.

## Lazy alternatives

`map` and `filter` are eager: they build the whole array at once.
For long or infinite sequences, `seq` and the `loop` macro build results with conditions, and fibers (`generate`) produce values one at a time; later lessons cover both.

## Pitfalls

- Keywords are not accessor functions. Calling a keyword calls a _method_: `(:speak dog)` looks up `:speak` in `dog` and calls it with `dog`. `(map :name seeds)` therefore fails; write `|($ :name)`.
- The results of `map`, `filter` and friends are arrays. An array never equals a tuple with `=`, so compare with `deep=` on like types or convert with `tuple`.
- `reduce` with the wrong starting value gives the wrong answer for an empty collection; ask what "nothing" should mean.
