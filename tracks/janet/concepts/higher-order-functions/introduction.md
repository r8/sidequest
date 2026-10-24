# Introduction

Functions are values: they can be passed to and returned from other functions.
A function that does either is a _higher-order function_.

Small functions are written in place with `fn`, or with the short form `|( … )`, whose argument is `$` (or `$0`, `$1`, … for several):

```janet
(map |(* $ $) [1 2 3])                 # => @[1 4 9]
(filter even? [1 2 3 4])               # => @[2 4]
(count |(> $ 2) [1 2 3 4])             # => 2
(find |(> $ 2) [1 2 3 4])              # => 3
(all odd? [1 3 5])                     # => true
(reduce + 0 [1 2 3 4])                 # => 10
```

`reduce` takes a function of the result so far and the next element, a starting value and the collection.
`map` and `filter` return new arrays and never change their input.

`partial`, `comp` and `apply` build or call functions from other functions: `((partial + 5) 10)` is `15`, `((comp f g) x)` is `(f (g x))`, and `(apply + [1 2 3])` is `6`.
A keyword is not a lookup function in Janet: write `|($ :name)`, not `:name`.
