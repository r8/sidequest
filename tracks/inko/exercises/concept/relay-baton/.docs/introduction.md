# Introduction

Inko has no garbage collector. Instead, every value has exactly one _owner_: a variable, a field, an array slot, an
argument. When the owner goes away (a variable at the end of its scope, an array when it is dropped, a field when
its object is dropped), the value is _dropped_: its memory is released right then. This is called _single
ownership_, and it is how Inko manages memory deterministically.

## Moves

Assigning an owned value to another variable, passing it as an argument, storing it in a field or an array, or
returning it _moves_ it: ownership goes to the new place, and the old one can't be used any more:

```inko
let names = ['Ada', 'Grace']
let moved = names

names.size # error: 'names' can't be used as it has been moved
```

The compiler tracks moves, so using a moved value is a compile-time error, not a crash. Moves are cheap: nothing
is copied, only who's responsible for the value changes.

A method argument whose type is a plain type, such as `items: Array[String]` or `baton: Baton`, takes ownership of
what's passed in. That's right when the method keeps the value, for example storing it in a field. Methods that only
need to look at or change a value _borrow_ it instead (`ref` and `mut`), and the next lesson is all about that.

## Value types are copied

`Int`, `Float`, `Bool`, `Nil` and `String` are _value types_: they are copied when moved, so the old variable stays
usable. That's why all the earlier lessons could pass numbers and strings around freely:

```inko
let a = 'hello'
let b = a

a.size # fine: b got a copy
```

## Moves and control flow

A value moved in only one branch of an `if` might be gone afterwards, so it can't be used after the `if`. A value
moved inside a loop would be moved again in the next round, so the compiler rejects that too, unless the loop gives
the variable a new value before the round ends:

```inko
let mut batch = []

for name in names {
  batch.push(name)

  if batch.size == 10 {
    send(batch) # moves batch...
    batch = []  # ...so give it a new value
  }
}
```

## Taking a value out of a field

A field always has a value, so you can't just move its value out and leave a hole. Instead, _swap_ it: `:=` assigns
a new value and returns the old one, which you now own:

```inko
type pub Locker {
  let mut @item: Option[String]

  fn pub mut empty -> Option[String] {
    @item := Option.None
  }
}
```

`Option` makes this natural: swap in `None`, and you get whatever was there. The same works for local variables:
`let old = name := 'new'`.

## Methods that consume their receiver

An ordinary method borrows `self`. A method defined with `fn move` takes _ownership_ of `self` instead, so it can
move fields out of it, and the value can't be used once the method has been called:

```inko
type pub Parcel {
  let @contents: Array[String]

  fn pub move unpack -> Array[String] {
    @contents
  }
}

let parcel = Parcel(contents: ['book'])
let contents = parcel.unpack

parcel.unpack # error: 'parcel' can't be used as it has been moved
```

This is how a type hands over its insides, and what `into_iter`, `Option.or` and `into_string` do: they all consume
what they're called on.

## Matching moves too

`match` on an owned value moves it into the `match`, and its parts into the bindings, so a `case Some(item)` body
owns `item`. Matching on a borrow (such as a field inside an `fn` method) binds borrows instead, and leaves the
value where it is.

## Moving closures, again

The closures lesson used `fn move` closures to keep captured values alive. Moving a variable into a closure also
lets the closure assign it, because the closure now owns it. Each call sees the value left by the previous one:

```inko
fn pub story -> fn (String) -> String {
  let mut text = 'Once upon a time'

  fn move (word: String) {
    text = '${text} ${word}'
    text
  }
}

let tell = story

tell.call('there') # => 'Once upon a time there'
tell.call('was')   # => 'Once upon a time there was'
```

## Dropping

You rarely drop values yourself; it happens when their owner goes away, in a predictable order: local variables in
reverse order of definition, and a value's fields in reverse order of definition. To drop a value early, move it
into `std.drop.drop` (`drop(value)`), or assign it to `_` (`let _ = value`).
