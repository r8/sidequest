# Introduction

Each `.inko` file is a module named after its path under `src/`: `src/garden/plants.inko` is `garden.plants`.
`import` brings in symbols, whole modules, or renamed symbols:

```inko
import garden.plants (Plant, Seed)   # symbols
import garden.tools                  # the module: tools.Spade
import std.cmp (max as larger)       # an alias
```

Imports go at the top of the file. The compiler finds modules in `src/`, in dependencies and in the standard
library.
