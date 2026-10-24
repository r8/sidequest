# Introduction

Most names in Janet are _lexically_ scoped: what a name means is decided by where the code is written.
A function sees its parameters, its local `def`s and `var`s, and the top-level definitions above it — nothing from the code that happens to call it.

Sometimes that is inconvenient.
Where should `print` write: the terminal, a file, a string a test wants to inspect?
Passing an "output" argument through every function between the caller and `print` would be tedious.
Janet answers with _dynamic bindings_: named settings that belong to the running fiber and are seen by every function called while they are in effect, however deep the call.

## Reading a binding: `dyn`

A dynamic binding is named by a keyword.
`(dyn key)` returns its current value, or `nil` when it is not set; `(dyn key default)` returns `default` instead of `nil`.

```janet
(dyn :volume)       # => nil
(dyn :volume 11)    # => 11
```

## Setting a binding: `setdyn`

`(setdyn key value)` sets the binding for the current fiber and returns the value.
Every function the fiber calls afterwards sees it.

```janet
(defn loudness [] (dyn :volume 5))

(loudness)          # => 5
(setdyn :volume 9)
(loudness)          # => 9
```

`loudness` takes no argument and its body never mentions the caller, yet its result depends on what the caller set.
That is the point of dynamic bindings, and also their danger: a value that changes behaviour from a distance is easy to forget about.

## Setting a binding for a while: `with-dyns`

`setdyn` changes a binding until somebody changes it again.
Usually you want a setting only for a stretch of code, and `with-dyns` does that: it takes a bracketed list of keys and values, runs its body with those bindings in effect, and returns the body's value.
Afterwards, the old values are back.

```janet
(setdyn :volume 9)

(with-dyns [:volume 2]
  (loudness))       # => 2

(loudness)          # => 9
```

`with-dyns` works by running its body in a new fiber whose bindings are layered over the current ones.
Inside, the body reads every binding of the code around it, unless it is overridden; any `setdyn` inside stays inside.
Errors raised in the body pass through `with-dyns` as usual.

```janet
(with-dyns [:volume 2]
  (setdyn :volume 3)
  (loudness))       # => 3

(loudness)          # => 9, unchanged
```

Because a binding is a value like any other, you can bind several at once and nest `with-dyns` forms; the innermost value of each key wins.

## Bindings Janet itself uses

Several core functions read dynamic bindings.
The most useful is `:out`: `print`, `prin`, `printf` and `pp` write to `(dyn :out)` when it is set, and to standard output otherwise.
Bind it to a buffer and the output is collected there:

```janet
(def captured @"")
(with-dyns [:out captured]
  (print "testing")
  (prin "one two"))
captured # => @"testing\none two"
```

`:err` does the same for `eprint` and error output.
The test harness of this track uses exactly this to record what each test printed.

## Fibers and bindings

Dynamic bindings live in the fiber's environment.
A fiber made with `coro` sees the bindings of the code that created it.
A fiber made with plain `fiber/new` starts with none of them, so code that relies on a binding should not be run in one unless you mean that.

## Pitfalls

- `(dyn key default)` returns `default` whenever the value is `nil`, so `nil` cannot be told apart from "not set".
- `setdyn` outside `with-dyns` changes the binding for the rest of the fiber — in a script, for everything that runs afterwards. Prefer `with-dyns`.
- A binding is read when `dyn` runs, not when the function was defined. A closure created under one `with-dyns` and called later sees the bindings in effect at the call.
