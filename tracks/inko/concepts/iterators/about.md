# About

`std.iter.Iter[T]` is a trait with one required method, `fn mut next -> Option[T]`, and many default methods
built on it. A `for` loop calls `into_iter` on its input and then `next` until it returns `None`.

## Sources

| Expression | Yields |
| --- | --- |
| `array.iter` | `ref T` |
| `array.iter_mut` | `mut T` |
| `array.into_iter` | `T`, consuming the array |
| `array.reverse_iter` | `ref T`, last to first |
| `map.iter` | `(ref K, ref V)` |
| `map.keys`, `map.values` | `ref K`, `ref V` |
| `string.chars` | `String`, one per character |
| `string.bytes` | `Int`, one per byte |
| `string.split(sep)` | `Slice[String]`, one per part |
| `1.to(5).iter` | `Int` |

## Lazy adapters

`map`, `select`, `select_map` (map to `Option` and keep the `Some` values), `flat_map`, `with_index`, `zip`,
`chain`, `skip`, `take`, `skip_while`, `take_while`, `chunks(n)` and `peekable` return iterators. They take
ownership of the iterator they're called on (`fn move`), so the original can't be used afterwards.

## Consumers

`to_array`, `count`, `last`, `reduce(initial, fn)`, `try_reduce`, `partition(fn)` (into two arrays), `find(fn)`,
`find_map(fn)`, `any?(fn)` and `all?(fn)`. `any?`, `all?` and `find` stop at the first value that decides the
answer. Type-specific helpers live on other types: `Int.sum(iter)`, `String.join(iter, separator)`,
and `Result.collect(iter)` (turn an iterator of results into a result of an array).

## Writing an iterator

Any type can be an iterator by implementing `Iter`:

```inko
import std.iter (Iter)

type Countdown {
  let mut @from: Int
}

impl Iter[Int] for Countdown {
  fn pub mut next -> Option[Int] {
    if @from == 0 { return Option.None }

    @from -= 1
    Option.Some(@from + 1)
  }
}

Countdown(from: 3).to_array # => [3, 2, 1]
```

The standard library has no constructor that turns a closure into an iterator, so a custom sequence is a small
type like this one.

## Pitfalls

- An iterator borrowing a temporary (`[1, 2].iter`) panics when the temporary is dropped while still borrowed:
  bind the collection to a variable first.
- Closures given to adapters can't assign captured variables; use `reduce` to accumulate.
- Iterators are single-use.
