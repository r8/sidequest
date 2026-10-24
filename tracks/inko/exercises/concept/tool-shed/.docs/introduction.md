# Introduction

Moving values around is only half the story: most code just needs to _use_ a value for a while, without taking it
over. That's what _borrows_ are for. A borrow is a reference to a value that someone else owns. There are two
kinds:

- `ref T`, an _immutable borrow_: you can read the value and call its `fn` methods, but not change it;
- `mut T`, a _mutable borrow_: you can also change it, calling its `fn mut` methods and assigning its fields.

Borrows are created with the `ref` and `mut` keywords:

```inko
let tools = ['saw', 'spade']
let reader = ref tools
let writer = mut tools

reader.size        # fine
writer.push('axe') # fine
reader.push('axe') # error: the method 'push' requires a mutable receiver
```

Unlike in some languages, you can have any number of borrows at the same time, mutable or not.

## Automatic borrowing

You rarely write `ref` and `mut` yourself, because Inko borrows automatically when a value is passed where a borrow
is expected. You've been relying on this since the arrays lesson:

```inko
fn pub count(names: ref Array[String]) -> Int {
  names.size
}

let names = ['Ada', 'Grace']

count(names) # passes `ref names`; names is still yours
```

An owned value or a `mut` borrow can be passed where a `ref` is expected, and an owned value where a `mut` is
expected. A `ref` can never be turned into a `mut`.

## Borrows from methods

Many methods hand out borrows rather than values, because the value stays where it is:

```inko
let tools = [Tool.new('saw'), Tool.new('spade')]

tools.get(0)      # Result[ref Tool, …]: look at the first tool
tools.get_mut(0)  # Result[mut Tool, …]: change the first tool
tools.first       # Option[ref Tool]
tools.iter        # yields ref Tool
tools.iter_mut    # yields mut Tool
tools.into_iter   # yields Tool, moving every tool out and consuming the array
tools.pop         # Option[Tool]: removes the last tool and gives it to you
tools.remove_at(0) # Result[Tool, …]: removes a tool and gives it to you
```

The rule of thumb: methods that leave the value in the collection return a borrow; methods that take it out return
the value itself. A method of your own can return a borrow too, such as `Option[ref Tool]` for "here's the tool,
but it stays mine".

## Fields and self

Inside a type's methods, fields are borrowed according to the kind of method: an `fn` method sees a field of type
`Array[Tool]` as `ref Array[Tool]`, and an `fn mut` method sees it as `mut Array[Tool]`. So changing a tool inside a
field requires an `fn mut` method _and_ a mutable borrow of that tool, from `iter_mut` or `get_mut`:

```inko
fn pub mut oil_all {
  for tool in @tools.iter_mut {
    tool.oil # an fn mut method of Tool
  }
}
```

With `iter` instead of `iter_mut`, the loop would get `ref Tool` values and the call to `oil` wouldn't compile.

## How borrowing is kept safe

Inko doesn't stop you from moving a value while borrows of it exist. Instead, every value counts how many borrows
point to it, and when an owned value is _dropped_, that count must be zero. If it isn't, the program panics:

```inko
let tools = [Tool.new('saw')]
let saw = tools.get_mut(0).or_panic

saw.oil
tools.clear # panics: can't drop a value of type 'Tool' as it still has 1 reference(s)
```

`clear` drops the tools while `saw` still borrows one. The check is deterministic, so the same program with the
same input always fails in the same place, and the stack trace points at the drop. In practice it's rare: it
happens when a borrow outlives the value it borrows. Keep borrows short-lived (use them, then let them go), and
don't store borrows in places that live longer than the owner. The same counting is behind the "iterating a
temporary array" panic from the loops lesson.

Value types (`Int`, `Float`, `String`, …) are never borrowed: a `ref Int` is just an `Int`.

## Moving out of a collection

To take a value out of a collection, use a method that removes it: `pop`, `remove_at`, `Map.remove`. They return
the owned value (in an `Option` or `Result`), which you can then move wherever you like. To find _which_ index to
remove, search with a borrow first and remember the index, then remove by index.
