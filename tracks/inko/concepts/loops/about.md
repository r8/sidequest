# About

## while and loop

```inko
while queue.size > 0 {
  …
}

loop {
  let line = read_line

  if line == 'quit' { break }
}
```

`loop` is the right choice when the exit condition is only known in the middle of the body. All loops produce
`Nil`; to get a result out of a loop, assign it to a variable declared before the loop, or `return` it from the
surrounding method.

## for

`for x in expr { … }` calls `into_iter` on `expr` and then `next` until it returns `None`:

```inko
for x in values.iter { … }       # borrows each value
for x in values.iter_mut { … }   # mutably borrows each value
for x in values.reverse_iter { … }
for x in values { … }            # moves the values out, consuming `values`
for (index, x) in values.iter.with_index { … }
for (key, value) in map.iter { … }
```

The loop variable is a pattern. If a refutable pattern doesn't match a value, the loop stops there.

## break and next

`break` and `next` apply to the innermost loop. There are no labelled loops; to leave nested loops at once, move
them into a method and `return`.

## Moves in loops

A value defined before a loop and moved inside it must be given a new value before the end of the round,
otherwise the next round would use a moved value:

```inko
let mut batch = []

for item in items {
  batch.push(item)

  if batch.size == 10 {
    send(batch)
    batch = []
  }
}
```

## Borrowing temporaries

The iterator returned by `iter` borrows the collection. If the collection is a temporary, such as an array literal
or the result of a method call, it is dropped at the end of the expression while the loop still borrows it, which
panics at runtime. Bind it to a variable first, or iterate the owned value directly.

## Closures instead of loops

Many loops are clearer as iterator methods (`map`, `select`, `reduce`, `count`, …) or `Int.times`, covered in the
closures and iterators lessons. A closure can't assign captured variables, so accumulate numbers in a loop, or
with `reduce`.
