# Introduction

Types, traits, constants, fields and methods are private unless marked `pub`:

```inko
let pub LIMIT = 10
type pub Plant {
  let pub @name: String
  fn pub water { … }
  fn grow { … }       # private
}
```

Private symbols are available to every module in the same root namespace, the first part of the module name: code
in `garden.plants` and `garden.tools` shares private symbols, but `kitchen` can't import them.
