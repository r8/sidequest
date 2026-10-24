# Introduction

Borrows make ownership flexible, but they're a problem the moment two pieces of code run at the same time: if one
process changes an array while another reads it through a borrow, the result is a data race. The next lessons are
about Inko's processes, and the type that makes moving data between them safe is the _unique value_.

## What makes a value unique

A unique value, of type `uni T`, is a value with no borrows pointing into it from outside, and which holds no
borrows of anything outside itself. Picture a sealed box: the items inside may refer to each other, but nothing
inside refers to anything outside, and nothing outside refers to anything inside. A box like that can be handed to
someone else without anyone being able to interfere with its contents.

## recover

`recover` creates unique values. The expression after it (or the block of expressions) is evaluated, and its
result, a `T`, comes out as a `uni T`:

```inko
let numbers = recover [10, 20, 30] # a uni Array[Int]
```

The compiler checks that the result can't be referred to from outside, which it can guarantee because of how
`recover` treats variables captured from outside the expression: inside it, they can only be used in ways that
can't leave a borrow behind. In practice, build the unique value _inside_ the `recover` from fresh values, value
types (numbers, strings) and other unique values:

```inko
fn pub greeting(name: String) -> uni Array[String] {
  recover {
    let words = ['hello']

    words.push(name)
    words
  }
}
```

An owned variable from outside can't be turned into a unique value by recovering it (`recover list` fails with
"values of type 'uni mut Array[String]' can't be recovered"): other code might still borrow it. Copy what you need
instead, for example with `clone`, which is allowed because the copy it returns has no borrows:

```inko
fn pub copy_of(list: ref Array[String]) -> uni Array[String] {
  recover list.clone
}
```

When a method's return type is `uni T`, an expression returned at the end is recovered automatically, so
`fn pub empty -> uni Array[Int] { [] }` needs no `recover`. A multi-line result still needs an explicit `recover
{ … }` around all of it.

## Getting the value back

`recover` also works the other way around: applied to a `uni T` value, it gives back an ordinary owned `T`, with all
restrictions lifted:

```inko
let unique = recover [10, 20]
let owned = recover unique # an Array[Int] again

owned.push(30)
```

`recover` on a unique variable moves it, so the unique variable can't be used afterwards.

## Using unique values

A `uni T` can be moved around (assigned, passed to `uni T` arguments, returned) like any owned value. Calling its
methods is allowed as long as the call can't break uniqueness, which the compiler checks:

- methods whose arguments and return value are _sendable_ (value types such as `Int` and `String`, or other `uni`
  values) are fine, including `fn mut` methods: `numbers.push(40)` works on a `uni Array[Int]`;
- immutable methods returning a fresh owned value without borrows are fine too, such as `numbers.size` or
  `numbers.clone`;
- methods returning a borrow are not: `numbers.iter` would let a borrow escape ("the receiver of this call requires
  a sendable return type"), and so would `get` on an array of heap values such as `Array[Array[Int]]`.

Borrowing a unique value (`ref numbers`) produces a `uni ref`, which can only be used as the receiver of a call: it
can't be stored in a variable or passed to a `ref` argument.

When the restrictions get in the way, unwrap the value, work on it normally, and wrap it again, all inside one
`recover` block, so that nothing from the work can leak out:

```inko
fn pub with_total(numbers: uni Array[Int]) -> uni Array[Int] {
  recover {
    let list = recover numbers
    let total = Int.sum(list.iter)

    list.push(total)
    list
  }
}
```

## Why bother?

Unique values are the price of safe concurrency without locks: only sendable values (value types and `uni` values)
may be passed to another process, and a `uni` value moved to another process can't be touched by the sender any
more. The next lesson puts that to use.
