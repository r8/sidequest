# Introduction

`for`, `each` and `while` cover single loops well, but code that walks a grid, skips some elements and collects the rest gets deeply nested.
Janet's `loop` macro and its relatives `seq`, `tabseq` and `catseq` express all of that in one compact header.

## The loop header

`loop` takes a _head_ in square brackets and a body.
The head is a sequence of _bindings_, each written as `binding :verb object`:

```janet
(loop [i :range [0 3]]
  (print i))
# prints 0, 1 and 2
```

`loop` itself returns `nil`; it is for side effects such as printing, pushing to an array or updating a table.

## Verbs: what to iterate over

| verb | iterates over | example |
| --- | --- | --- |
| `:range` | numbers from start up to, not including, end, with an optional step | `[i :range [0 10 2]]` → 0 2 4 6 8 |
| `:range-to` | the same, including the end | `[i :range-to [1 3]]` → 1 2 3 |
| `:down` | numbers from start down to, not including, end | `[i :down [3 0]]` → 3 2 1 |
| `:down-to` | the same, including the end | `[i :down-to [3 0]]` → 3 2 1 0 |
| `:in` | the values of an array, tuple, string, table or struct | `[x :in [:a :b]]` → :a :b |
| `:keys` | the keys (or indices) of a collection | `[k :keys {:a 1}]` → :a |
| `:pairs` | `[key value]` tuples of a collection | `[[k v] :pairs {:a 1}]` → k = :a, v = 1 |

`:range [n]` with a single number counts from 0: `[i :range [3]]` is 0 1 2.
For an array or tuple, the keys are the indices, so `:pairs` gives `[index value]`:

```janet
(loop [[i animal] :pairs [:cat :dog]]
  (print i " " animal))
# prints "0 cat" and "1 dog"
```

## Several bindings nest

Writing more than one binding in the head nests the loops: the last binding is the innermost and changes fastest.

```janet
(loop [x :range [0 2]
       y :range [0 2]]
  (print x y))
# prints 00, 01, 10, 11
```

## Modifiers

Between bindings you can add _modifiers_, which also apply to everything to their right:

- `:when condition` runs the rest only when the condition is truthy; `:unless condition` only when it is not.
- `:while condition` stops the loop at that level as soon as the condition is false; `:until condition` stops it as soon as the condition is true.
- `:let [name value …]` binds names for the rest of the iteration.
- `:before form` and `:after form` run a form before or after each iteration of the rest; `:repeat n` runs the rest `n` times.

```janet
(loop [n :range [1 20]
       :when (= 0 (% n 3))
       :let [square (* n n)]
       :while (< square 100)]
  (print square))
# prints 9, 36 and 81
```

## Collecting results: `seq`, `tabseq`, `catseq`

The same head works with three macros that, instead of returning `nil`, collect what the body produces.

`seq` returns an array of the body's value for each iteration:

```janet
(seq [i :range [1 5]] (* i 10))                 # => @[10 20 30 40]
(seq [w :in ["fig" "kiwi" "plum"] :when (= 4 (length w))] w)  # => @["kiwi" "plum"]
(seq [a :in [:x :y] b :in [1 2]] [a b])         # => @[(:x 1) (:x 2) (:y 1) (:y 2)]
```

A `seq` inside a `seq` builds nested arrays, one inner array per outer iteration — exactly the shape of a table of rows.

`tabseq` takes a key expression and a value expression after the head, and returns a table:

```janet
(tabseq [w :in ["fig" "kiwi"]] w (length w))    # => @{"fig" 3 "kiwi" 4}
```

When two iterations produce the same key, the later value wins.

`catseq` expects the body to produce an indexed collection on each iteration and concatenates them all into one array:

```janet
(catseq [x :in [1 2 3]] [x (- x)])              # => @[1 -1 2 -2 3 -3]
```

## Pitfalls

- The ranges exclude their end: `[i :range [0 n]]` stops at `n - 1`. Use `:range-to` or `:down-to` when you want the end too.
- `:in` over a string yields bytes (numbers), not one-character strings.
- `:in` over a table or struct visits values in no particular order.
- `loop` returns `nil` even if the body produces a value on every iteration; reach for `seq` when you want the results.
