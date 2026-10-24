# Introduction

In Janet, a function is a value like any other.
You can bind it to a name, put it in a tuple, pass it to another function and return it from one.
A function that takes or returns functions is a _higher-order function_, and the core library is full of them: they replace most of the loops you would otherwise write.

## Functions as arguments

```janet
(defn twice
  "(twice f x) -> f applied to x two times"
  [f x]
  (f (f x)))

(defn add-ten [n] (+ n 10))

(twice add-ten 1) # => 21
(twice string/ascii-upper "hi") # => "HI"
```

`add-ten` without parentheses is the function itself, not a call.

## Anonymous functions

Most functions passed to another function are small and used once, so they are written in place with `fn`:

```janet
(twice (fn [n] (* n 3)) 2) # => 18
```

For the shortest ones there is a shorthand: `|` in front of an expression makes it a function, and `$` is its argument.
With more than one argument, they are `$0`, `$1` and so on.

```janet
|(* $ 3)          # the same as (fn [x] (* x 3))
|(+ $0 $1)        # the same as (fn [a b] (+ a b))
```

## `map`, `filter` and `count`

`map` calls a function on every element and returns an array of the results:

```janet
(map |(* $ $) [1 2 3])          # => @[1 4 9]
(map (fn [s] (s :size)) [{:size 2} {:size 5}]) # => @[2 5]
```

`filter` returns an array of the elements for which a function — a _predicate_ — returns a truthy value, and `count` returns how many there are:

```janet
(filter even? [1 2 3 4])        # => @[2 4]
(count |(> $ 2) [1 2 3 4])      # => 2
```

`find` returns the first matching element, or `nil` when none matches.
`all` returns `true` when the predicate holds for every element (and for an empty collection), and `some` returns the first truthy result, or `nil`:

```janet
(find |(> $ 2) [1 2 3 4])       # => 3
(all odd? [1 3 5])              # => true
(some |(> $ 9) [1 2 3])         # => nil
```

They all work on tuples and arrays alike, and the results of `map` and `filter` are always new arrays: the original is never changed.

## `reduce`

`reduce` combines all the elements into one value.
It takes a function of two arguments, a starting value and the collection.
The function receives the result so far and the next element, and returns the new result so far:

```janet
(reduce + 0 [1 2 3 4])          # => 10
(reduce (fn [longest word]
          (if (> (length word) (length longest)) word longest))
        ""
        ["fig" "quince" "pear"]) # => "quince"
```

The starting value is also the result for an empty collection, so choose it with that in mind.
Simple cases have ready-made helpers: `(sum xs)`, `(max-of xs)` and `(min-of xs)`.

## Building functions from functions

A few functions take functions and return new ones:

```janet
(def add-five (partial + 5))    # + with its first argument fixed
(add-five 10)                   # => 15

(def shout (comp string/ascii-upper string/trim))
(shout "  quiet ")              # => "QUIET", trim first, then upper

(apply + [1 2 3])               # => 6, calls + with the elements as arguments
```

## Pitfalls

- A keyword is not a lookup function in Janet. `(map :size seeds)` does not read `:size`; write `|($ :size)` or `(fn [s] (s :size))`.
- `$` only means something inside `|( … )`, and inside a short function nested in another it means the inner one's argument: the outer one's is out of reach. Write one of them with `fn` and a named parameter.
- `map` and `filter` return arrays even when given tuples, so `(= [2 4] (filter even? [1 2 3 4]))` is `false`: an array is never `=` a tuple. Compare contents with `deep=` after converting, or simply keep working with the array.
