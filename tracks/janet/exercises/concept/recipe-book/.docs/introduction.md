# Introduction

As a program grows, one file stops being enough.
In Janet every source file is a _module_: the top-level definitions of one file can be imported into another, while helpers that are nobody else's business stay private.

## A module is a file

There is nothing to declare.
A file `shapes.janet` with ordinary top-level definitions is already a module:

```janet
# shapes.janet
(def pi 3.14159)

(defn circle-area
  "(circle-area r) -> number"
  [r]
  (* pi r r))
```

## Importing with `import`

Another file uses it with `import`, giving the path to the file without its `.janet` extension.
A path starting with `./` or `../` is relative to the directory of the file that contains the `import`, wherever the program was started from:

```janet
# main.janet, in the same directory as shapes.janet
(import ./shapes)

(shapes/circle-area 2) # => 12.56636
shapes/pi              # => 3.14159
```

Every public binding of the module arrives with the module's name and a slash as a _prefix_, so `circle-area` becomes `shapes/circle-area`.
The prefix keeps names from different modules apart: two modules may both define `area` without a clash.

The `:as` option chooses a shorter prefix, and `:prefix` sets the exact string to prepend (an empty string means no prefix at all):

```janet
(import ./shapes :as s)
(s/circle-area 1)       # => 3.14159

(import ./shapes :prefix "")
(circle-area 1)         # => 3.14159
```

`(use ./shapes)` is shorthand for importing without a prefix, and `:only [circle-area]` limits an `import` to the bindings you name.
Prefer a prefix in all but the smallest programs: when you read `s/circle-area`, you know where it comes from.

A path without `./` or `../`, such as `(import spork/json)`, is looked up in Janet's module search path instead of next to the current file — that is how installed libraries are found.
The test files of this track import their harness that way: `(import test :as t)`.

## Private definitions

By default every top-level `def`, `var` and `defn` of a module is exported.
The variants `def-`, `var-` and `defn-` define _private_ bindings, which work exactly the same inside the module but are not visible to anyone who imports it:

```janet
# shapes.janet
(def- sides {:triangle 3 :square 4})

(defn sides-of
  "(sides-of shape) -> integer"
  [shape]
  (sides shape))
```

```janet
# main.janet
(import ./shapes)
(shapes/sides-of :square) # => 4
shapes/sides              # compile error: unknown symbol shapes/sides
```

Making helpers and lookup tables private keeps a module's surface small: other files can only depend on what you chose to export, so you can change the rest freely.

Bindings a module imports are not exported again, so a module that imports `./shapes` does not hand `shapes/circle-area` on to its own importers (unless it asks for that with `:export true`).

## Loaded once

The first `import` of a module runs the whole file and remembers the result.
Every later import of the same module, from any file, gets the same bindings without running it again.
So top-level code in a module — a `print`, building a big table — happens once per program, however many files import it.

## `require`

Under the hood, `import` calls `require`, which loads the module (or takes it from the cache) and returns its _environment_: a table from each symbol to a table describing the binding.

```janet
(def env (require "./shapes"))
(get-in env ['pi :value]) # => 3.14159
```

You rarely need `require` directly, but it explains what a module is: a table of named bindings.

## Pitfalls

- Leave off the `.janet` extension: `(import ./shapes)`, not `(import ./shapes.janet)`.
- Without `./`, `(import shapes)` searches the module path, not the current directory, and fails with `could not find module shapes`.
- Two modules cannot import each other: Janet stops with `circular dependency … detected`. Move what they share into a third module.
