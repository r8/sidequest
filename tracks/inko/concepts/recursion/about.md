# About

## Shape

A recursive method has at least one base case that doesn't recurse, and every recursive call must make progress
towards one. Check the base cases first.

## Helpers with extra arguments

Recursion over an array or a string needs to know where it is: pass an index (or a `Slice`) along. Keep the public
signature simple and let a private method carry the extra state:

```inko
fn pub sum(values: ref Array[Int]) -> Int {
  sum_from(values, 0)
}

fn sum_from(values: ref Array[Int], index: Int) -> Int {
  match values.get(index) {
    case Ok(value) -> value + sum_from(values, index + 1)
    case Error(_) -> 0
  }
}
```

An _accumulator_ argument carries a partial result down the calls, so the last call can return the answer
directly: `fn count_from(values, index, so_far)`.

## Recursive types

Regular types and enums (heap allocated) may contain themselves: `case Node(Tree[T], T, Tree[T])`, or a type with a
field of type `Option[Node]`. `inline` and `copy` types can't, because their size must be known at compile time.
Methods on recursive types are naturally recursive, with one `match` case per variant.

## Stack depth

Each call uses some stack space. Inko processes have a fixed-size stack (configurable, see the manual's tuning
reference), and recursing too deeply crashes the program. Inko doesn't guarantee tail-call elimination, so very deep
recursion over long inputs (hundreds of thousands of levels) is better written as a loop. For trees and nested
structures, whose depth is small, recursion is the clearest tool.

## Mutual recursion

Methods can call each other recursively (`even?` calls `odd?`, which calls `even?`). Module methods can be defined
in any order, so no forward declarations are needed.
