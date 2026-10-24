# Introduction

Koka's loops are standard-library functions that take the body as a lambda:

- `for(lo, hi) fn(i) …` — each integer from `lo` to `hi`, both included;
- `xs.foreach fn(x) …` and `xs.foreach-indexed fn(i, x) …` — each element of a list, with its position from 0;
- `repeat(n) { … }` — `n` times;
- `while { condition } { body }` — as long as the condition holds.

They return nothing, so the body works through mutable variables. `while` may never stop, so a function that uses
it has the `div` effect in its type; the others always terminate.
