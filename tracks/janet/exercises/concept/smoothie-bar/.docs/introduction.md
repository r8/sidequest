# Introduction

Code that transforms a value in several steps quickly turns into nested calls that have to be read from the inside out:

```janet
(string/join (map string/ascii-upper (string/split " " (string/trim "  red green  "))) "-")
# => "RED-GREEN"
```

The first thing that happens, `string/trim`, is buried deepest; the last, `string/join`, comes first.
Janet's _threading macros_ let you write the same pipeline in the order it runs.

## Thread-first: `->`

`(-> x f g h)` takes `x`, passes it to `f`, passes the result to `g`, and so on.
Each step is either a bare function, called with the value alone, or a call with the value inserted as its **first** argument:

```janet
(-> "  Hello  " string/trim string/ascii-lower)
# => "hello", the same as (string/ascii-lower (string/trim "  Hello  "))

(-> 10 (/ 2) (- 1))
# => 4, that is (- (/ 10 2) 1)
```

Thread-first suits functions that take "the thing being worked on" first, such as `string/slice`, `get`, `put` and most `string/` functions:

```janet
(-> {:pet {:name "Rex"}} (get :pet) (get :name))  # => "Rex"
```

## Thread-last: `->>`

`->>` does the same, but inserts the value as the **last** argument of each step.
That suits the sequence functions — `map`, `filter`, `reduce`, and also `string/split` — which take the collection last:

```janet
(->> [1 2 3 4 5]
     (filter odd?)
     (map |(* $ $))
     sum)
# => 35, that is (sum (map |(* $ $) (filter odd? [1 2 3 4 5])))
```

Choosing the wrong arrow is the most common mistake, and it does not always raise an error: with numbers it just computes something else.

```janet
(-> 10 (/ 2) (- 1))   # => 4,   (- (/ 10 2) 1)
(->> 10 (/ 2) (- 1))  # => 0.8, (- 1 (/ 2 10))
```

## Short-circuiting: `-?>` and `-?>>`

Looking up nested data often produces `nil` part of the way through, and the next step then fails or gives a wrong answer.
`-?>` and `-?>>` are versions of `->` and `->>` that stop as soon as a step produces `nil`, and return `nil`:

```janet
(def stock {:apples {:count 12}})

(-?> stock (get :apples) (get :count) (* 2))  # => 24
(-?> stock (get :pears) (get :count) (* 2))   # => nil; (* nil 2) never runs
```

Only `nil` stops the chain; `false` is passed on like any other value.

## Naming the value: `as->`

Sometimes the value has to go in the first position in one step and the last in another, or somewhere in the middle.
`as->` gives it a name instead, and each step uses that name wherever it needs the value:

```janet
(as-> [1 2 3] xs
  (map inc xs)
  (map string xs)
  (string/join xs "-"))
# => "2-3-4"
```

The name is rebound to the result of each step in turn.
`as?->` is the same with the `nil` short-circuit of `-?>`.

## They are macros

The arrows are macros: they rewrite your code before it runs, so `(-> x (f a) g)` _is_ `(g (f x a))`, with no extra function calls and no cost at run time.
You can check what a pipeline turns into at the REPL with `macex1`:

```janet
(macex1 '(->> xs (map f) (filter g)))
# => (filter g (map f xs))
```

This also means a step must be written so that the value can be inserted into it: a function name, or a call in parentheses.
A short function such as `|(* $ 2)` cannot be a step on its own: it is shorthand for the form `(short-fn (* $ 2))`, so `(-> 3 |(* $ 2))` becomes `(short-fn 3 (* $ 2))` and fails.
Write the call instead — `(-> 3 (* 2))` — or pass the short function to a sequence function, as in `(map |(* $ 2))`.

## When to use them

Threading is for a straight line of transformations of one value.
Two or three steps are often clearer as plain nested calls; a long pipeline over collections is where `->>` shines.
