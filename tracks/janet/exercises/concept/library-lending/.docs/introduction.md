# Introduction

Some work comes in pairs: open a file and close it, take a lock and release it, switch a setting on and back off.
The second half must happen whatever the first half's code does in between — including when it raises an error.
With only `try`, that means catching the error, cleaning up, and raising it again, every time.
Janet has three macros that do this for you: `defer`, `edefer` and `with`.

## `defer`: always clean up

`(defer cleanup body…)` runs the body, then runs `cleanup`, and returns the body's value.
If the body raises an error, `cleanup` still runs, and then the error carries on to whoever called you, unchanged.

```janet
(def log @[])

(defn careful [f]
  (array/push log "start")
  (defer (array/push log "finish")
    (f)))

(careful (fn [] :ok))           # => :ok
log                             # => @["start" "finish"]

(protect (careful (fn [] (error "oops"))))
# => (false "oops")
log                             # => @["start" "finish" "start" "finish"]
```

Note the order of the arguments: the cleanup comes first, right next to the code that made it necessary, and the body follows.
That keeps "take" and "give back" side by side in the source, so a reader can see at once that they match.

`defer` never swallows an error.
If you want to handle the error, use `try` around it.

## `edefer`: clean up only on failure

`(edefer cleanup body…)` is the same, except that `cleanup` runs only when the body raises an error.
When the body succeeds, its value is returned and `cleanup` is skipped.

```janet
(defn reserve [seats seat f]
  (put seats seat :reserved)
  (edefer (put seats seat :free)
    (f seat)))
```

If `f` succeeds, the seat stays reserved; if it fails, the reservation is undone and the error goes on.
This "undo on failure" pattern is how you keep data consistent when a step halfway through can fail.

## `with`: a value that must be closed

The most common pair is "create a resource, use it, close it".
`with` binds a name to a resource for the length of its body and closes it afterwards, error or not:

```janet
(with [f (file/open "notes.txt")]
  (file/read f :all))
```

`with` takes a bracketed binding — a name, the expression that creates the resource, and optionally a function to close it — and then the body.
It returns the body's value.

Without the third element, `with` closes the resource by calling its `:close` method: `(:close f)`.
Files have one, and so does any table you give a `:close` function:

```janet
(def door
  @{:name "front door"
    :close (fn [self] (print "closing the " (self :name)))})

(with [d door]
  (print "walking through the " (d :name)))
# prints "walking through the front door", then "closing the front door"
```

With a third element, `with` calls that function with the resource instead:

```janet
(def keyring @["brass key" "iron key"])

(with [key (array/pop keyring) (fn [k] (array/push keyring k))]
  (string "opened with the " key))
# => "opened with the iron key", and the key is back on the ring
```

## Which to use

- The cleanup is about one value that has a `:close` method, or an obvious "release" function: `with`.
- The cleanup is any other code that must always run: `defer`.
- The cleanup should undo a change only if what follows fails: `edefer`.

## Pitfalls

- The cleanup runs after the body, so it cannot change the value that is returned — but it can mutate a table or array the value refers to.
- An error raised by the cleanup itself replaces the body's error. Keep cleanups simple.
- `with` closes the value it bound, not whatever the body might have replaced it with. Do not reassign it.
