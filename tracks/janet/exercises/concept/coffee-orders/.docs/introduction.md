# Introduction

You have been writing functions with `defn` since the first lesson.
This lesson looks at what else a function's parameter list can say, and at functions as values.

## Functions are values

`defn` gives a function a name, but a function does not need one.
`fn` makes an anonymous function, with the same parameter list and body:

```janet
(fn [x] (* x 2))            # a function that doubles its argument
((fn [x] (* x 2)) 21)       # => 42, called right away
```

A function is a value like any other: it can be bound with `def`, passed to another function and called there.

```janet
(def double (fn [x] (* x 2)))

(defn twice
  "Calls f on x, then again on the result."
  [f x]
  (f (f x)))

(twice double 5)            # => 20
(twice (fn [s] (string s "!")) "hey")   # => "hey!!"
```

`(defn double [x] (* x 2))` and `(def double (fn [x] (* x 2)))` define the same function; `defn` also attaches the docstring.

## Optional parameters

Parameters after `&opt` are optional.
A caller may leave them out, and a parameter that was left out is `nil`.
The `default` macro replaces `nil` with a fallback value:

```janet
(defn greet
  "(greet &opt name) -> string"
  [&opt name]
  (default name "stranger")
  (string "Hello, " name "!"))

(greet)          # => "Hello, stranger!"
(greet "Ada")    # => "Hello, Ada!"
```

Required parameters come first and optional ones after `&opt`: `[a b &opt c d]`.
Passing `nil` explicitly is the same as leaving the argument out.

## Variadic parameters

A parameter after `&` collects all the remaining arguments into a tuple, which may be empty.
`length` tells how many there were.

```janet
(defn shout
  "(shout word & marks) -> string"
  [word & marks]
  (string (string/ascii-upper word) " with " (length marks) " marks"))

(shout "hi")           # => "HI with 0 marks"
(shout "hi" "!" "?")   # => "HI with 2 marks"
```

Later lessons show how to work with the elements of a tuple; for now, `length` is all you need.

## Named parameters

Parameters after `&named` are passed by name, as keyword–value pairs after the positional arguments, in any order.
Like optional parameters, any that are left out are `nil`.

```janet
(defn ticket
  "(ticket film &named seat time) -> string"
  [film &named seat time]
  (default time "20:00")
  (string film " at " time (if seat (string ", seat " seat) "")))

(ticket "Metropolis")                         # => "Metropolis at 20:00"
(ticket "Metropolis" :seat "F7")              # => "Metropolis at 20:00, seat F7"
(ticket "Metropolis" :time "18:30" :seat "A1")# => "Metropolis at 18:30, seat A1"
```

Named parameters read well at the call site when a function has several options that are usually left at their defaults.

## Arity

Janet checks the number of arguments.
A call with too few or too many is an error, and when the function is known at compile time — as a function defined with `defn` in the same file is — the compiler reports it before the program even runs:

```janet
(greet "Ada" "Grace")   # compile error: expects at most 1 argument, got 2
```

## Pitfalls

- `default` only replaces `nil`. A caller who passes `false` gets `false`.
- `&opt` parameters are positional: to give the second optional argument you must give the first, which is when `&named` is the better choice.
- The rest parameter is a tuple even when it holds one argument: in `(shout "hi" "!")`, `marks` is `["!"]`, not `"!"`.
