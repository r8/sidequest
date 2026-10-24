# About

## What is captured

Janet is lexically scoped: a name refers to the nearest enclosing binding in the source code.
A function value carries the bindings it refers to from enclosing scopes — its _environment_ — so it can be called long after those scopes have finished.

- A `def` binding is captured as its value; it never changes.
- A `var` binding is captured as the variable itself. Every closure that captured it, and the code of the enclosing function, see the same variable, and a `set` in any of them is seen by all.

Top-level bindings are not captured this way: a function refers to them through the module, and a top-level `var` changed with `set` is seen by every function in the file.

## Function factories

A function that returns a closure is a factory; each call configures a new function.

```janet
(defn make-scaler [factor]
  (fn [x] (* x factor)))

(map (make-scaler 3) [1 2 3]) # => @[3 6 9]
```

`partial`, `comp`, `complement` and `juxt` are factories from the core library.

## Private state and objects

Several closures over the same `var`s form an object whose data is reachable only through them:

```janet
(defn make-account []
  (var balance 0)
  {:deposit (fn [amount] (+= balance amount))
   :balance (fn [] balance)})
```

Janet also has a more conventional object model — tables with prototypes and methods — which a later lesson covers.
Closures are the lighter tool when there are only a couple of operations and the state must stay hidden.

## Loops

Each iteration of `for`, `each`, `loop` and `seq` gets a fresh binding of its loop variables, so closures created in a loop remember the value of their own iteration:

```janet
(def fs @[])
(for i 0 3 (array/push fs (fn [] i)))
(map |($) fs) # => @[0 1 2]
```

A `var` declared outside the loop is a single variable, though, and every closure that captures it sees its final value.

## Generators and fibers

A closure over a `var` is the simplest generator: each call returns the next value.
For generators with more complicated control flow, fibers let a function pause in the middle and resume later; a later lesson covers them.
