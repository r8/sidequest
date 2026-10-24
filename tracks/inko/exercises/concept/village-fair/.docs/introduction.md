# Introduction

Every `.inko` file is a _module_, and a module's name comes from its path under `src/`. Directories become parts
of the name, separated by dots:

| File | Module |
| --- | --- |
| `src/garden.inko` | `garden` |
| `src/garden/plants.inko` | `garden.plants` |
| `src/garden/tools/spade.inko` | `garden.tools.spade` |

A module and a directory may share a name: `src/garden.inko` and `src/garden/plants.inko` live side by side. The
standard library is organised the same way: `std.string`, `std.map`, `std.cmp`.

## Importing symbols

`import` makes another module's types, traits, methods and constants available. Name the module, then the symbols
you want in parentheses:

```inko
import garden.plants (Plant, Seed)
import std.string (StringBuffer)
```

After that, `Plant`, `Seed` and `StringBuffer` can be used as if they were defined in the importing module. Imports go at
the top of the file, and each symbol name may only be imported once.

## Importing a module

Without parentheses, `import` brings in the module itself, under the last part of its name. Its symbols are then
reached through that name:

```inko
import garden.plants

plants.Plant.new('basil')
```

This is handy when a module's symbol names are short or generic, so that the module name makes clear where they
come from.

## Aliases

`as` renames an imported symbol, avoiding clashes when two modules use the same name, or giving a clearer name in
context:

```inko
import garden.plants (Plant as GardenPlant)
import std.cmp (max as larger)

larger(3, 7) # => 7
```

## Public and private

Everything a module defines is _private_ unless it's marked `pub`:

```inko
let pub SEASON_START = 3    # public constant
let PLOT_WIDTH = 2          # private constant

type pub Plant {            # public type
  let @name: String         # private field

  fn pub name -> String {   # public method
    @name
  }

  fn rename(name: String) { # private method
    …
  }
}

fn pub plant_count -> Int { … } # public module method
fn spacing -> Int { … }         # private module method
```

Private doesn't mean private to the file. A private symbol is available to every module in the same _root
namespace_: the first part of the module name. So `garden.plants` and `garden.tools` can use each other's private
symbols, and so can `garden` itself, but a module called `kitchen` can't. Importing a private symbol from another
root namespace is a compile-time error ("the symbol … is private and can't be imported"), and the same goes for
private fields and methods.

That gives a simple rule for structuring a project: put the parts of one component under one name (`garden`,
`garden.plants`, `garden.tools`), let them share private helpers freely, and mark with `pub` what other components
may use.

## Constants across modules

Constants are imported like any other symbol. A constant is useful in another module only when it is `let pub`:

```inko
import garden.plants (SEASON_START)
```

A handful of very common types (`Int`, `String`, `Array`, `Map`, `Option`, `Result` and a few more) and the
`panic` method form the _prelude_: they are available in every module without an import.

## Where modules are found

The compiler looks for imported modules in your project's `src/` directory, in the source directories of the
project's dependencies, and in the standard library. (Exercises are built with `src/` and `test/` as source
directories, which is how the tests find your modules.)
