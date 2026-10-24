# Introduction

A Janet program is made of expressions.
Numbers, strings and names stand for themselves; everything else is a parenthesised list with the function first and its arguments after it, separated by whitespace (never commas):

```janet
(+ 1 2)          # => 3
(* 2 (+ 3 4))    # => 14
```

A comment starts with `#` and runs to the end of the line.

`def` binds a name to a value, permanently:

```janet
(def tray-capacity 6)
```

`defn` defines a function: a name, an optional docstring, the parameters in square brackets, and the body.
The function returns the value of its last expression; there is no `return`.

```janet
(defn loaves
  "(loaves trays) -> integer"
  [trays]
  (* trays tray-capacity))

(loaves 3) # => 18
```

Calling a function with the wrong number of arguments is an error.
