# Introduction

A function runs from start to finish: once called, it does all its work before the caller gets control back.
A _fiber_ is a function that can stop halfway, hand a value to whoever is running it, and later carry on from exactly where it stopped, with all its local variables intact.
Other languages call this a coroutine.
Janet builds a lot on fibers — error handling, generators, its event loop — and they are ordinary values you can create, pass around and store.

## Creating and resuming a fiber

`fiber/new` takes a function and returns a fiber that will run it.
Creating the fiber runs nothing.
`resume` runs the fiber until it either _yields_ or finishes, and returns the value it yielded or returned.

```janet
(def countdown
  (fiber/new
    (fn []
      (yield 3)
      (yield 2)
      (yield 1)
      :liftoff)))

(resume countdown) # => 3
(resume countdown) # => 2
(resume countdown) # => 1
(resume countdown) # => :liftoff
```

`yield` pauses the fiber and makes its argument the value of the `resume` that woke it.
The next `resume` continues right after that `yield`.

## Status

`fiber/status` tells you what state a fiber is in:

| Status | Meaning |
| --- | --- |
| `:new` | created, never resumed |
| `:pending` | paused at a `yield`, waiting to be resumed |
| `:alive` | running right now (a fiber asking about itself) |
| `:dead` | its function has returned |
| `:error` | its function raised an error |

```janet
(def f (fiber/new (fn [] (yield :a))))
(fiber/status f) # => :new
(resume f)       # => :a
(fiber/status f) # => :pending
(resume f)       # => nil, the function's return value
(fiber/status f) # => :dead
```

Resuming a fiber that is `:dead` is an error, so check its status first when you do not know.

## Sending values in

`resume` can take a second argument, which travels the other way.
On the first `resume` it becomes the argument of the fiber's function; on every later one it becomes the value that the paused `yield` returns.

```janet
(def echo
  (fiber/new
    (fn [first]
      (var heard first)
      (while true
        (set heard (yield (string "you said " heard)))))))

(resume echo "hi")    # => "you said hi"
(resume echo "hello") # => "you said hello"
```

A fiber with an endless loop is fine: it only runs when someone resumes it, so it never blocks the program.
That makes fibers a natural way to produce values one at a time, on demand, even from an infinite sequence.

## Fibers as sequences

A fiber is iterable.
`each` resumes it again and again and runs its body with every _yielded_ value, stopping when the fiber finishes; the function's final return value is not included.

```janet
(def letters (fiber/new (fn [] (yield "a") (yield "b") :ignored)))

(each x letters
  (print x))
# prints a, then b
```

`each` picks up wherever the fiber currently is, so values that were already taken with `resume` are not seen again.
The same is true of `map`, `filter` and other functions that iterate their argument.

## `coro`

Writing `(fiber/new (fn [] …))` is common enough to have a shortcut: `(coro body…)` makes a fiber whose function runs `body`.

```janet
(def evens
  (coro
    (var n 0)
    (while true
      (yield n)
      (+= n 2))))

(resume evens) # => 0
(resume evens) # => 2
```

## Pitfalls

- `yield` belongs inside a fiber you created, or a function it calls. A `yield` reached from the top level of a script stops the script with a `pending` error.
- After the last `yield`, one more `resume` is needed to let the function finish; it returns the function's return value and leaves the fiber `:dead`.
- A fiber is a mutable object: passing it to a function and resuming it there advances it for everyone who holds it.
