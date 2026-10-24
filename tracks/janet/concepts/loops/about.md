# About

## `var` and `set`

`(var name value)` creates a mutable binding and `(set name value)` changes it.
`set` on a `def` binding is a compile error, `cannot set constant`.
The update shorthands are macros over `set`: `(++ x)` is `(set x (+ x 1))`, `(+= x 5)` is `(set x (+ x 5))`, and likewise `--`, `-=`, `*=`, `/=` and `%=`.

A binding and the value it holds are separate things.
`(def items @[])` cannot be rebound, but the array it holds can still be pushed onto; `var` is only needed when the name must refer to a different value later.

## The loops

| Form | Runs | Binds |
| --- | --- | --- |
| `(while cond body…)` | while `cond` is truthy | nothing |
| `(for i start end body…)` | for `i` from `start` up to `end`, exclusive, step 1 | `i` |
| `(forv i start end body…)` | the same, but `i` is a `var` the body may change | `i` |
| `(each x ds body…)` | for each value of `ds` | `x` |
| `(eachk k ds body…)` | for each key (for an array, each index) | `k` |
| `(eachp [k v] ds body…)` | for each key–value pair | `k`, `v` |
| `(repeat n body…)` | `n` times | nothing |

`each`, `eachk` and `eachp` work on arrays, tuples, tables, structs, strings and buffers (whose elements are bytes), and on fibers, which the fibers lesson covers.
`while` is the primitive the others are built on.

Every loop returns `nil`.

## `break`

`(break)` exits the innermost loop.
Inside a function body outside any loop, `(break value)` returns `value` from the function early, though Janet code rarely needs it.

## Beyond these

- The `loop` macro combines iteration over ranges, collections and pairs with filters (`:when`), early stops (`:while`, `:until`) and nested loops in one form, and `seq` collects a value from every iteration into an array. The loop-macro lesson covers them.
- `map`, `filter`, `reduce`, `count`, `find` and their relatives replace most loops that build a new collection or a single value; the higher-order functions lesson covers them.
- Recursion is the other way to repeat, and has its own lesson.

Prefer those where they fit: a `var`-and-`each` loop is clear for a beginner, but the idiomatic Janet for summing a list is `(sum xs)`.
