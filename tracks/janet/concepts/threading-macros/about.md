# About

## The family

| macro | inserts the value | stops on `nil` |
| --- | --- | --- |
| `->` | as the first argument | no |
| `->>` | as the last argument | no |
| `-?>` | as the first argument | yes |
| `-?>>` | as the last argument | yes |
| `as->` | wherever the name appears | no |
| `as?->` | wherever the name appears | yes |

A step that is a bare symbol, `f`, is treated as `(f)`, so the value becomes its only argument.
A step that is a tuple, `(f a b)`, gets the value inserted first (`(f x a b)`) or last (`(f a b x)`).

## Macros, not functions

The arrows rewrite code at compile time:

```janet
(macex1 '(-> x (f a) g))     # => (g (f x a))
(macex1 '(->> xs (map f)))   # => (map f xs)
```

So there is no run-time cost, and the steps must be forms the macro can insert into.
A short function `|(* $ 2)` is the form `(short-fn (* $ 2))`, and threading into it breaks it; use `(* 2)` as the step instead.
An anonymous function `(fn [x] …)` as a step is equally wrong, since the value is inserted into the `fn` form itself; `as->` is the tool when a step needs arbitrary code.

`-?>` and friends bind every intermediate value to a fresh, hidden name, so a step is evaluated once even though it is tested for `nil`.
Only `nil` short-circuits; `false` is passed on to the next step.

## Which arrow

- Functions that take "the subject" first — the `string/` functions, `get`, `put`, `in`, `array/push`, `string/slice` — read well with `->`.
- Functions that take a collection last — `map`, `filter`, `keep`, `reduce`, `take`, `drop`, `string/split`, `sum` (alone) — read well with `->>`.
- When a pipeline mixes the two, either break it into two pipelines or use `as->`.

`string/join` and `string/split` are a notorious pair: the first takes the collection first, the second takes the string last.

## Style

A pipeline is a straight line from one value to a result.
Two steps rarely need an arrow; five usually do.
When a pipeline has to branch or reuse an intermediate result twice, `let` with names is clearer than any arrow.
