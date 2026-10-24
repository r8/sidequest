# Introduction

Types and methods can take type parameters in square brackets, standing for any type the caller picks:

```inko
type pub Box[T] {
  let @value: T
}

fn pub all_same?[T: Equal](values: ref Array[T]) -> Bool {
  let Some(first) = values.first else return true

  values.iter.all?(fn (value) { value == first })
}
```

`T: Equal` is a requirement: only types implementing `Equal` are accepted, and in return `==` can be used on them.
Combine requirements with `+`. `impl Box if T: ToString { … }` adds methods only for boxes whose contents meet the
requirement. Type arguments are usually inferred; otherwise annotate (`let box: Box[Int] = …`) or pass them
explicitly (`size_of[Int]`).
