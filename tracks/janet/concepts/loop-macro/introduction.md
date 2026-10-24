# Introduction

`loop` takes a head of bindings, each `binding :verb object`, and a body:

```janet
(loop [i :range [0 3]] (print i))   # prints 0 1 2
```

The verbs are `:range [start end step]` (end excluded), `:range-to` (end included), `:down` and `:down-to` (counting down), `:in` (values), `:keys` and `:pairs` (`[key value]` tuples).
Several bindings nest, the last one innermost.
Modifiers between them filter or stop the iteration: `:when`, `:unless`, `:while`, `:until`, `:let [name value]`, `:before`, `:after`, `:repeat n`.

`loop` returns `nil`.
Three macros with the same head collect results instead:

```janet
(seq [x :in [1 2 3 4] :when (even? x)] (* x 10))  # => @[20 40]
(tabseq [w :in ["fig" "kiwi"]] w (length w))       # => @{"fig" 3 "kiwi" 4}
(catseq [x :in [1 2]] [x x])                       # => @[1 1 2 2]
```
