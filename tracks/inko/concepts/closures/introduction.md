# Introduction

A closure is an anonymous method, written `fn (x: Int) -> Int { x * 2 }` and run with `call`:

```inko
let double = fn (x: Int) { x * 2 }

double.call(21) # => 42
```

Closure types are written `fn (Int) -> Int`, `fn (String) -> Bool` or `fn -> String`. When a closure is passed
directly to an argument with such a type, its argument types are inferred: `apply(fn (x) { x + 1 })`.

Closures capture surrounding variables: numbers, booleans and strings as copies, other values as borrows. They
can't assign captured variables. A closure returned from a method that captures anything else must be a moving
closure, `fn move (…) { … }`, which takes ownership of what it captures.
