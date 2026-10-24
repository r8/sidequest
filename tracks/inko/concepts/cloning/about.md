# About

```inko
trait pub Clone {
  fn pub clone -> Self
}
```

## Implementations in the standard library

- Value types: `Int`, `Float`, `Bool`, `String` (`clone` returns the same value).
- `Array[T]`, `Option[T]`, `Result[T, E]`, `Map[K, V]` and tuples, when their contents implement `Clone`. Cloning
  a collection clones each value (a deep copy, as far as the contents' own `clone` goes).
- `Channel`: a clone shares the same channel, which is how a channel is given to several processes.

## Implementing Clone

```inko
impl Clone for Playlist {
  fn pub clone -> Playlist {
    Playlist(title: @title, songs: @songs.clone)
  }
}
```

Clone every field that isn't a value type. A type implementing `Clone` can't be used as a trait value of `Clone`,
because `clone` returns `Self`.

## Cloning borrows

`clone` is an `fn` method, so it can be called on a borrow: `items.get(0).or_panic.clone` gives an owned copy of a
value inside a collection, which is the usual way to get a value out without removing it. Generic code expresses
this with `T: Clone`, and the return type `move T` (the owned version of a possibly borrowed `T`), as
`Slice.to_array` does.

## When not to clone

A clone allocates and copies. Prefer borrowing (`ref`/`mut`) when you only need to look at or change a value, and
moving when the original is no longer needed. Clone when two independent values must exist at the same time.
