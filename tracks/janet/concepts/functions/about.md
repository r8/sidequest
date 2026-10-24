# About

## `fn` and `defn`

`(fn [params] body…)` creates a function; the body's last expression is its result.
`(defn name "doc" [params] body…)` is `(def name (fn name [params] body…))` with the docstring stored in the binding's metadata, where `doc` finds it.
An anonymous function can carry a name of its own, `(fn countdown [n] … (countdown (- n 1)))`, which lets it call itself.

Functions are first-class values of type `:function` (`function?` tests for one); core functions written in C, such as `string`, have the type `:cfunction` instead (`cfunction?` tests for those).

## The short form

`|(* $ 2)` is shorthand for `(fn [$] (* $ 2))`.
Inside, `$` (or `$0`) is the first argument, `$1` the second, and so on, and `$&` the tuple of remaining arguments.
It suits small functions passed to `map` or `filter`; a later lesson uses it a lot.

## Parameter markers

| Marker | Meaning |
| --- | --- |
| `&opt` | the parameters after it are optional and `nil` when left out |
| `&` | the next parameter collects the remaining arguments into a tuple |
| `&named` | the parameters after it are passed as `:name value` pairs |
| `&keys` | the next parameter receives all the `:key value` pairs as a struct |

They combine in this order: `[a &opt b & rest]` takes one required, one optional and any number of further arguments.
`&keys` takes a parameter that can be destructured: `[&keys {:size size}]`.
`&named` and `&keys` ignore keys they do not know.

`default` assigns a fallback when a binding is `nil`, and is the usual companion of `&opt` and `&named`.
It does not replace `false`.

## Arity

Every function knows how many arguments it accepts, and calling it with too few or too many raises an error.
When the compiler can see the function being called — a top-level `defn` in the same file — it checks the call at compile time, so a mismatch stops the file from loading at all.

## `apply`

`(apply f a b [c d])` calls `f` with `a`, `b`, `c` and `d`: the last argument is a list whose elements become separate arguments.
It is how a tuple collected by `&` is passed on to another variadic function: `(apply + numbers)`.

## Returning several values

A function returns one value.
To return several, return a tuple — `[quotient remainder]` — and let the caller take it apart with destructuring, which a later lesson covers.

## Recursion and tail calls

A function may call itself.
Janet performs tail-call elimination, so a function whose recursive call is the last thing it does runs in constant stack space; the recursion lesson goes into this.
