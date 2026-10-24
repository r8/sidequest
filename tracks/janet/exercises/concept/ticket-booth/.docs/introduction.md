# Introduction

A function written inside another function can use the names around it: the outer function's parameters, and anything it defined with `def` or `var`.
It keeps them even after the outer function has returned.
A function together with the bindings it captured is a _closure_.

## Capturing values

```janet
(defn make-greeter
  "(make-greeter greeting) -> a function that greets a name"
  [greeting]
  (fn [name] (string greeting ", " name "!")))

(def hello (make-greeter "Hello"))
(def ahoy (make-greeter "Ahoy"))

(hello "Ada")  # => "Hello, Ada!"
(ahoy "Ada")   # => "Ahoy, Ada!"
```

`make-greeter` is a _function factory_: every call returns a new function.
Each one remembers the `greeting` it was made with, so `hello` and `ahoy` behave differently although they were written once.
This is the same idea as `partial` — `(partial + 5)` returns a closure over `5` — written by hand, with full control over what the new function does.

## Capturing a `var`

A closure captures the binding itself, not a copy of its value.
When the binding is a `var`, the closure can change it with `set`, and the change is still there the next time the closure runs:

```janet
(defn make-counter
  "(make-counter) -> a function returning 1, 2, 3, … on successive calls"
  []
  (var count 0)
  (fn []
    (set count (+ count 1))
    count))

(def clicks (make-counter))
(clicks) # => 1
(clicks) # => 2
(clicks) # => 3
```

Nothing outside `make-counter` can see or change `count`: the only way to touch it is to call the closure.
That makes a closure a simple way to keep _private state_.

Each call of the factory creates a fresh `var`, so two counters are independent:

```janet
(def a (make-counter))
(def b (make-counter))
(a) (a)
(b) # => 1, b has its own count
```

`++`, `--` and `+=` are shorthand for the common updates: `(++ count)` adds one, `(-- count)` subtracts one and `(+= count 5)` adds five, and each returns the new value.

## Several closures, one state

Closures made in the same call share whatever they captured.
Returning several of them, for example in a struct, gives a small object whose operations all work on the same hidden data:

```janet
(defn make-jar
  "(make-jar) -> a struct of functions over one shared coin count"
  []
  (var coins 0)
  {:drop (fn [n] (+= coins n))
   :count (fn [] coins)})

(def jar (make-jar))
((jar :drop) 5)
((jar :drop) 2)
((jar :count)) # => 7
```

Note the double parentheses: `(jar :count)` looks the function up, and the outer pair calls it.

## Closures in loops

Every iteration of `for` and `each` has its own binding of the loop variable, so a closure made in a loop remembers the value of that iteration:

```janet
(def shouts @[])
(each word ["hi" "ho"]
  (array/push shouts (fn [] (string/ascii-upper word))))

((shouts 0)) # => "HI"
```

## Pitfalls

- A closure over a `var` sees later changes to it, wherever they come from. If two closures should not share state, create the `var` in separate factory calls.
- `def` bindings cannot be changed even inside a closure; state that changes needs `var` and `set`.
- A factory returns a function, not a result. `(make-counter)` gives you a counter; you still have to call it to get a number.
