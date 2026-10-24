# Introduction

A method is _recursive_ when it calls itself. Recursion solves a problem by reducing it to a smaller version of the
same problem, until the problem is small enough to answer directly.

```inko
fn pub factorial(number: Int) -> Int {
  if number <= 1 { return 1 }

  number * factorial(number - 1)
}

factorial(5) # => 120
```

Every recursive method has two parts:

- a **base case**, which is answered without recursion (`number <= 1` gives `1`);
- a **recursive case**, which calls the method with a smaller input (`number - 1`) and builds its answer from the
  result.

Each call must get closer to a base case. A method that never reaches one keeps calling itself until the process
runs out of stack space and the program crashes, so check the base case first.

## Recursion over numbers and arrays

Counting digits, summing a range, or walking an array by index all have a natural recursive shape:

```inko
fn pub digits(number: Int) -> Int {
  if number < 10 { 1 } else { 1 + digits(number / 10) }
}

fn pub sum_from(values: ref Array[Int], index: Int) -> Int {
  if index >= values.size { return 0 }

  values.get(index).or(0) + sum_from(values, index + 1)
}
```

`sum_from` carries an extra argument, the position to start from. A public method often hides such an argument
behind a simpler signature, by calling a private helper: `fn pub sum(values) { sum_from(values, 0) }`.

For plain loops over numbers and arrays, a `for` loop or an iterator is usually clearer. Recursion shines when the
data itself is recursive.

## Recursive types

An enum case may contain a value of the enum itself. That makes the type _recursive_, able to describe structures
of any depth, such as a list of tasks where each task may have a list of sub-tasks, or a chain of links:

```inko
type pub enum Chain {
  case End
  case Link(Int, Chain)
}

let chain = Chain.Link(1, Chain.Link(2, Chain.Link(3, Chain.End)))
```

Recursive types and recursive methods go together: the method has one case for each case of the type. The case
without a nested value is the base case, and the case with one recurses into it:

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

  fn pub total -> Int {
    match self {
      case End -> 0
      case Link(value, rest) -> value + rest.total
    }
  }
}

chain.length # => 3
chain.total  # => 6
```

Because `self` is borrowed in these methods, `rest` is a borrow of the nested chain, and `rest.length` is an
ordinary method call on it.

Building a recursive value is recursive too: to build a chain from an array, the chain for the first value links
to the chain built from the rest.

```inko
fn pub static from(values: ref Array[Int], index: Int) -> Chain {
  match values.get(index) {
    case Ok(value) -> Chain.Link(value, Chain.from(values, index + 1))
    case Error(_) -> Chain.End
  }
}
```

## Combining results

A recursive call returns a value like any other method, and the caller can combine it however it likes: add to it
(`1 + rest.length`), test it (`found or rest.contains?(x)`), or collect it. To collect into an array, create the
array for the current level and `append` the array returned by the recursive call:

```inko
let values = [first]

values.append(rest.to_array)
values
```

`append` moves every value of the other array onto the end of this one.

Recursive types can only be regular (heap-allocated) enums and types, since an `inline` or `copy` type must have a
fixed size, which a type containing itself can't have.
