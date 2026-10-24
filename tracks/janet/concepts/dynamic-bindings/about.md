# About

## Lexical and dynamic scope

Janet's ordinary names are lexically scoped: a function sees what is around it where it is written.
Dynamic bindings are the exception: they are looked up when `dyn` runs, in the environment of the fiber that is running, so a value set by a caller reaches every function it calls without being passed as an argument.
That makes them right for ambient context — where output goes, the current file being compiled, a debug flag — and wrong for ordinary data, which is clearer as an argument.

## The functions

- `(dyn key &opt default)` returns the binding's value, or `default` when it is `nil` or unset.
- `(setdyn key value)` sets it in the current fiber's environment and returns `value`.
- `(with-dyns [k1 v1 k2 v2 …] & body)` runs `body` in a new fiber whose environment has the current one as its prototype, with the given bindings set; it returns the body's value. Reads fall through to the outer bindings, writes stay inside, and errors and yields propagate out.
- `(defdyn *name* "docs")` defines `*name*` as a keyword (here `:name`) and documents it, so a library's bindings have a name the compiler checks for typos: `(dyn *name*)`.

Keys are usually keywords; any value works.

## Fibers

Bindings belong to the fiber environment.
`with-dyns`, `coro`, `generate`, `ev/go` and the fibers behind `try` and `protect` all see the creating fiber's bindings.
A fiber made with plain `(fiber/new f)` starts with an empty environment; `(fiber/new f :i)` shares the creator's and `(fiber/new f :p)` inherits it through a prototype.

## Bindings the core uses

| Key | Used by |
| --- | --- |
| `:out` | `print`, `prin`, `printf`, `pp` — a buffer collects the output, a file writes to it, a function is called with it |
| `:err` | `eprint`, `eprintf`, error reports |
| `:args` | the command-line arguments of a script |
| `:current-file` | the file being compiled or run |
| `:pretty-format` | the format `pp` uses |
| `:syspath` | where `import` looks for installed modules |

Capturing output is the everyday use:

```janet
(defn capture [f]
  (def out @"")
  (with-dyns [:out out] (f))
  (string out))
```

## Pitfalls

- `nil` and "not set" are the same to `dyn`.
- A closure reads bindings when it is called, not when it was created: a function made inside `with-dyns` and called after it sees the bindings of its caller.
- `setdyn` in a script's main fiber lasts until the script ends; in a library function it changes its caller's world. Prefer `with-dyns`.
