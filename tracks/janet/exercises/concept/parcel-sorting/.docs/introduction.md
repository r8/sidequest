# Introduction

Destructuring takes a value apart when you already know its shape.
Often you don't: a message may be one of several kinds, each with its own fields, and the code has to find out which kind it got before it can take it apart.
Janet's `match` macro does both at once — it compares a value against a list of _patterns_, and the first one that fits binds its names and picks the result.

## The shape of `match`

```janet
(match value
  pattern-1 result-1
  pattern-2 result-2
  …)
```

`match` tries the patterns from top to bottom.
For the first pattern that matches, it evaluates the corresponding result, with the pattern's names bound, and returns it.
If nothing matches, `match` returns `nil`.
An optional last, unpaired expression serves as a default — but the clearer way to write a default is the wildcard pattern `_`, described below.

## Literal patterns

A number, string, keyword, `true`, `false` or `nil` in a pattern matches a value that is equal to it:

```janet
(defn greet [lang]
  (match lang
    :nl "Hallo"
    :fr "Bonjour"
    _ "Hello"))

(greet :fr)  # => "Bonjour"
(greet :de)  # => "Hello"
```

## Symbols and the wildcard

A symbol matches anything and binds the value to that name.
`_` also matches anything but binds nothing; as the last pattern it catches whatever the others did not.

```janet
(match 42
  0 "zero"
  n (string "the number " n))  # => "the number 42"
```

## Tuple and array patterns

A pattern in square brackets matches an array or a tuple element by element, and each element of the pattern is itself a pattern.
This makes tagged tuples — a keyword first, then data — easy to tell apart:

```janet
(defn area [shape]
  (match shape
    [:square side] (* side side)
    [:rect w h] (* w h)
    [:circle r] (* 3.14159 r r)))

(area [:rect 2 5])   # => 10
(area [:circle 1])   # => 3.14159
(area [:triangle 3]) # => nil, no pattern matched
```

`& name` at the end of a bracket pattern binds the remaining elements, possibly none, to a tuple:

```janet
(match [:tags "red" "blue"]
  [:tags & names] names)   # => ("red" "blue")
```

Watch out: a bracket pattern only needs the value to have _at least_ as many elements as the pattern names.
`[:rect w h]` also matches `[:rect 2 5 9]`, ignoring the `9`.
Put the longer patterns first when you need to tell `[:a x]` from `[:a x y]`.

## Struct and table patterns

A pattern in curly braces matches a struct or table that has every key of the pattern, with values that match the pattern's values.
Other keys in the value are ignored, and a key whose value is `nil` counts as missing.

```janet
(defn ship [order]
  (match order
    {:express true :to to} (string "courier to " to)
    {:to to} (string "post to " to)
    _ "no address"))

(ship {:to "Lyon" :express true})  # => "courier to Lyon"
(ship {:to "Lyon"})                # => "post to Lyon"
(ship {:express true})             # => "no address"
```

Patterns nest freely: `{:to {:city city}}` reaches into a struct inside a struct, and `[:move {:x x :y y}]` into a struct inside a tuple.

## Guards: patterns with conditions

A pattern in **parentheses** is a guarded pattern: its first element is a pattern, and the rest are conditions that must all be truthy, evaluated with the pattern's names bound.

```janet
(defn size [n]
  (match n
    (x (< x 10)) :small
    (x (< x 100)) :medium
    _ :large))

(size 7)   # => :small
(size 250) # => :large
```

A guard can wrap any pattern, including a bracket one — `([:rect w h] (= w h))` matches only squares — and it can sit inside another pattern, as in `[:letter (g (> g 100))]`.

## Matching against an existing value

A plain symbol in a pattern always binds a new name, so you cannot write a variable's name to mean "equal to this variable's value".
For that, write `(@ name)`:

```janet
(def winner :blue)

(match [:team :blue]
  [:team (@ winner)] "the winners"
  [:team _] "another team")
# => "the winners"
```

## Pitfalls

- The order of the cases matters: the first match wins, so put specific patterns before general ones and `_` last.
- Without a matching pattern the result is `nil`, which can silently travel on; a final `_` case makes the fallback explicit.
- Bracket patterns ignore extra elements, struct patterns ignore extra keys.
- Parentheses in a pattern mean a guard, not a list to match; use square brackets to match a tuple.
