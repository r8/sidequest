# Introduction

An `Array` is an ordered list of values that can grow and shrink. Array literals are written between square
brackets:

```inko
let numbers = [10, 20, 30]
let names = ['Ada', 'Grace']
```

Every value in an array has the same type. The type of an array names it between square brackets: `numbers` is an
`Array[Int]` and `names` an `Array[String]`. An empty array needs its type spelled out when the compiler can't
work it out from how the array is used:

```inko
let empty: Array[String] = []
```

## Size

```inko
[10, 20, 30].size   # => 3
[10, 20, 30].empty? # => false
```

## Reading values

Positions (_indexes_) start at zero. There is no `array[index]` syntax; instead, `get` returns the value at an
index, wrapped so that a missing index is not a crash:

```inko
let names = ['Ada', 'Grace']

names.get(0).or('nobody') # => 'Ada'
names.get(5).or('nobody') # => 'nobody'
```

`get(index)` gives back either the value or an error saying the index is out of bounds; `or(default)` unwraps it,
using the default for the error. If a missing value would be a bug in your program, `or_panic` unwraps it and
stops the program with an error instead.

`first` and `last` work the same way, with `or` for the empty case:

```inko
names.first.or('nobody') # => 'Ada'
names.last.or('nobody')  # => 'Grace'
```

(These wrapped values are `Result` and `Option` values; later lessons explain them fully. For now, `or` is all you
need.)

## Searching

```inko
names.contains?('Grace')       # => true
names.index_of('Grace').or(-1) # => 1
```

## Changing an array

Arrays are changed in place. The variable doesn't need to be `let mut`: `let mut` is about assigning a different
array to the variable, not about changing the array it holds.

```inko
let names = ['Ada']

names.push('Grace')       # names is now ['Ada', 'Grace']
names.insert(0, 'Alan')   # ['Alan', 'Ada', 'Grace']
names.set(1, 'Barbara')   # ['Alan', 'Barbara', 'Grace']
names.pop.or('nobody')    # => 'Grace', and names is ['Alan', 'Barbara']
names.remove_at(0).or('nobody') # => 'Alan', and names is ['Barbara']
```

`pop` removes the last value and returns it (or nothing, for an empty array). `set` and `insert` panic when the
index is out of bounds.

`sort` puts the values in ascending order, and `reverse` reverses them; both change the array itself:

```inko
let words = ['pear', 'apple', 'fig']

words.sort    # ['apple', 'fig', 'pear']
words.reverse # ['pear', 'fig', 'apple']
```

## Arrays as arguments

A method that only reads an array takes it as `ref Array[T]`; a method that changes it takes `mut Array[T]`:

```inko
fn pub count(names: ref Array[String]) -> Int {
  names.size
}

fn pub add_guest(names: mut Array[String], name: String) {
  names.push(name)
}

let guests = ['Ada']

add_guest(guests, 'Grace')
count(guests) # => 2
```

`ref` and `mut` are _borrows_: the method gets to use the array for the duration of the call, while the caller
keeps it. Inko borrows automatically when you pass a variable to such a method. The borrowing lesson explains them
in depth; for now, use `ref` to read and `mut` to change.

Arrays compare with `==` when their values do: `[1, 2] == [1, 2]` is `true`.
