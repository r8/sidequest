# About

## Paths

| form | finds |
| --- | --- |
| `(import ./name)` | `name.janet` next to the importing file |
| `(import ../lib/name)` | relative to the importing file's directory |
| `(import name)`, `(import spork/json)` | on the module path: `(dyn :syspath)`, set from `JANET_PATH` or the installation |

Relative paths are resolved against the file that contains the `import`, not against the current working directory, so a program can be started from anywhere.
The extension is left off; Janet tries `.janet` source, `.jimage` images and native modules in turn.

## Options of `import`

- `:as name` — the prefix becomes `name/`.
- `:prefix "str"` — the prefix becomes exactly `str` (`""` for none).
- `:only [a b]` — import only those bindings (still prefixed).
- `:export true` — re-export the imported bindings from the importing module.
- `:fresh true` — bypass the module cache and load the file again.

`(use ./a ./b)` imports one or more modules without a prefix.

## What a module exports

A module's environment is a table from symbols to binding descriptions such as `@{:value 3.14159 :doc "…"}`; `(require "./shapes")` returns it.
`import` copies every binding that is not marked `:private` into the importing environment under the prefix.
`def-`, `var-` and `defn-` (and `defmacro-`) set `:private`; so does `(def name :private value)`.
Imported bindings are private in the importer, so they are not passed on unless `:export true` asks for it.

An exported `var` stays one variable: `(set shapes/counter 5)` in the importer changes the module's own `counter`.

## Loading once

`require` caches modules by their resolved path in `module/cache`.
A module's top-level code therefore runs once per program, and every importer shares the same values — including mutable tables and arrays, which are then effectively global.

## Organising code

- Keep a module's public surface small: export the functions other files need, and make tables of constants and helpers private.
- Prefer prefixed imports so the reader can see where a name comes from; reserve `use` for small scripts or a module that is effectively part of the language for your program.
- Circular imports fail with `circular dependency … detected`, since a module is not in the cache until it has finished loading; move shared code into a third module.

## Scripts and `main`

When a file is run with `janet file.janet`, its top level runs; if it defines a function called `main`, that is called afterwards with the command-line arguments.
A module meant to be both imported and run can therefore keep its script behaviour in `main`.
