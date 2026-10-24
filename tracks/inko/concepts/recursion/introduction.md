# Introduction

A recursive method calls itself on a smaller input. It needs a base case, answered directly, and a recursive case
that moves towards it:

```inko
fn pub factorial(number: Int) -> Int {
  if number <= 1 { return 1 }

  number * factorial(number - 1)
}
```

Recursion fits recursive data best. An enum case can contain the enum itself, and a method on it has one case per
enum case:

```inko
type pub enum Chain {
  case End
  case Link(Int, Chain)

  fn pub length -> Int {
    match self {
      case End -> 0
      case Link(_, rest) -> 1 + rest.length
    }
  }
}
```
