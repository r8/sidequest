# Introduction

A `Map` stores values under keys, so you can look a value up by its key instead of by position. Like `Array`,
`Map` is available everywhere without an import (it's defined in `std.map`, and you'll often see
`import std.map (Map)` at the top of a file, which does no harm).

There is no literal syntax for maps; create an empty one with `Map.new` and fill it with `set`:

```inko
let ages = Map.new

ages.set('Ada', 36)
ages.set('Alan', 41)
```

All keys of a map have one type, and all values another: `ages` is a `Map[String, Int]`. Keys can be any type that
can be compared and hashed, such as `String`, `Int` or `Bool`. When the compiler can't tell the types from how the
map is used, write them out: `let ages: Map[String, Int] = Map.new`.

As with arrays, a method that reads a map takes `ref Map[K, V]`, and one that changes it takes `mut Map[K, V]`.

## Looking up values

`get` returns the value for a key, or an error when the key is missing; as with arrays, `or` supplies a default:

```inko
ages.get('Ada').or(0)   # => 36
ages.get('Grace').or(0) # => 0
```

`contains?` checks for a key, and `size` counts the entries:

```inko
ages.contains?('Alan') # => true
ages.size              # => 2
```

## Changing values

`set` adds a key, or replaces the value of a key that is already there. To change a value based on the old one,
read it, then set it again:

```inko
ages.set('Ada', ages.get('Ada').or(0) + 1) # Ada is now 37
```

This "get with a default, then set" combination is also how you count things:

```inko
let words = ['to', 'be', 'or', 'not', 'to', 'be']
let counts = Map.new

for word in words.iter {
  counts.set(word, counts.get(word).or(0) + 1)
}

counts.get('to').or(0) # => 2
```

`remove` deletes a key and returns its value, or an error when it was missing:

```inko
ages.remove('Alan').or(0) # => 41
ages.remove('Alan').or(0) # => 0, it's gone
```

## Iterating

Maps remember the order in which keys were first added, and iterate in that order. `iter` yields each entry as a
`(key, value)` tuple, which a `for` loop can take apart:

```inko
for (name, age) in ages.iter {
  …
}
```

`keys` and `values` iterate over just the keys or just the values:

```inko
ages.keys.to_array  # => ['Ada', 'Alan']
Int.sum(ages.values) # => 77
```

## Comparing

Two maps are equal when they contain the same keys with equal values; the order of the entries doesn't matter.
