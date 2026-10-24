# Introduction

`fn` makes an anonymous function; `defn` binds one to a name and attaches a docstring.
Functions are values: they can be bound, passed to other functions and called there.

A parameter list can say more than "these arguments, in this order":

```janet
(defn f [a &opt b]   …)   # b may be left out; it is then nil
(defn g [a & more]   …)   # more is a tuple of the remaining arguments
(defn h [a &named x y] …) # called as (h 1 :y 2 :x 3)
```

`(default b 10)` replaces a missing (`nil`) optional or named argument with a fallback.

Calling a function with the wrong number of arguments is an error, often caught at compile time.
