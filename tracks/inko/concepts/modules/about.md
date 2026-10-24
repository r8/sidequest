# About

## Module names

A module's name is its path relative to a source directory, with `/` replaced by `.` and the `.inko` extension
dropped. A file and a directory may share a name (`std/int.inko` and `std/int/`), so a component can have a main
module and sub-modules.

## Import forms

```inko
import std.stdio (Stdout, Stderr)   # specific symbols
import std.stdio                    # the module, used as stdio.Stdout
import std.stdio (Stdout as Out)    # a renamed symbol
```

Any symbol can be imported: types, traits, module methods and constants. Importing a type does not import the
traits it implements; to call a trait's methods on a value you don't need the trait in scope, but to _implement_
the trait or name it in a type you do.

## The prelude

A few symbols are available everywhere without an import, the _prelude_: `Int`, `Float`, `String`, `Bool`, `Nil`,
`Array`, `ByteArray`, `Map`, `Option`, `Result`, and the `panic` method. Everything else comes from an import.

## Cycles

Modules can import each other in cycles; the compiler handles the order. Keeping dependencies one-directional still
makes a project easier to follow.

## Source directories

`inko build` and `inko test` use `src/` (and `test/` for tests), the `src/` directories of dependencies listed in
`inko.pkg`, the standard library, and any directory given with `-i`/`--include`.
