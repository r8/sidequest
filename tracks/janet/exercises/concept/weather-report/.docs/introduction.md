# Introduction

A _keyword_ is a name that stands for itself.
It is written with a leading colon — `:sunny`, `:high-tide`, `:ok` — and, like a number or a string, it evaluates to itself.

```janet
:sunny            # => :sunny
(type :sunny)     # => :keyword
(keyword? :sunny) # => true
```

Keywords are how Janet code names things from a fixed set: the possible states of a traffic light, the sizes on a menu, the result of a check.
Where another language would reach for an enum or a string constant, Janet uses a keyword.

## Why not strings?

A keyword looks a lot like a string, and it is in fact an immutable sequence of bytes too.
The difference is intent: a string is text that might be shown to someone, while a keyword is an identifier inside the program.
Keywords are _interned_ — every `:sunny` in a program is the same object — so comparing two keywords is as cheap as comparing two numbers.

A keyword is never equal to a string with the same letters:

```janet
(= :sunny :sunny)    # => true
(= :sunny "sunny")   # => false
```

## Keywords in conditionals

Because keywords compare with `=`, they work well with `case`:

```janet
(defn light-action [light]
  (case light
    :green "go"
    :amber "slow down"
    :red "stop"
    "flashing: take care"))

(light-action :amber)   # => "slow down"
```

And a function can return a keyword to say which of several situations it found:

```janet
(defn tide [height]
  (cond
    (< height 1) :low
    (< height 3) :mid
    :high))

(tide 2)   # => :mid
```

## Converting

`keyword` turns a string (or several pieces) into a keyword, and `string` turns a keyword into a string without its colon:

```janet
(keyword "rainy")         # => :rainy
(keyword "high" "-tide")  # => :high-tide
(string :rainy)           # => "rainy"
(string "it is " :rainy)  # => "it is rainy"
```

Conversion matters at the edges of a program: text that comes in from outside — typed by a user, read from a file — arrives as a string, and becomes a keyword once the program has checked it.

Since a keyword is a byte sequence, many `string/` functions accept one, but they return strings: `(string/ascii-upper :rainy)` is `"RAINY"`, not `:RAINY`.

## Comparing

Besides `=`, keywords can be compared with `<` and `>`, alphabetically, just like strings.

## Pitfalls

- `:sunny` and `"sunny"` are different values; convert explicitly when one kind meets the other.
- A keyword is not a function. Putting one first in a list, as in `(:sunny x)`, does not look anything up: it is a _method call_, which a later lesson explains, and on most values it is an error.
- `keyword` does not change case: `(keyword "Rainy")` is `:Rainy`, which is not `:rainy`.
