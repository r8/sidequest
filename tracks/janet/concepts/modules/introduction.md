# Introduction

Every Janet source file is a module.
`(import ./shapes)` loads `shapes.janet` from the directory of the importing file and binds each of its public definitions with the prefix `shapes/`:

```janet
(import ./shapes)
(shapes/circle-area 2)

(import ./shapes :as s)       # prefix s/
(import ./shapes :prefix "")  # no prefix; (use ./shapes) does the same
```

A path without `./` or `../` is searched for on the module path, where installed libraries live.

Top-level `def`, `var` and `defn` are exported; `def-`, `var-` and `defn-` define private bindings that importers cannot see.
A module runs once, on its first import; later imports reuse the result.
