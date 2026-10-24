# Introduction

`type` defines a new type with fields (`let @name: Type`) and methods:

```inko
type pub Counter {
  let mut @count: Int

  fn pub static new -> Counter {
    Counter(count: 0)
  }

  fn pub count -> Int {
    @count
  }

  fn pub mut increment {
    @count += 1
  }
}
```

Instances are created with `Counter(count: 0)`, usually inside a static `new` method (`fn static`). Instance
methods read fields with `@`; only `fn mut` methods may change them, and only `let mut` fields can be assigned.
Fields are private unless declared `let pub`.
