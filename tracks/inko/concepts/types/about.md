# About

## Defining types

```inko
type pub Person {
  let pub @name: String     # public, read-only field
  let mut @age: Int         # private field that can be assigned
  let @friends: Array[ref Person]
}
```

Regular types are allocated on the heap and accessed through a pointer, so they can be borrowed and mutated in
place. Other kinds of types change that: `type enum` (a value that is one of several cases), `type inline`,
`type copy` and `type ref` (value semantics), and `type async` (processes). Later lessons cover each of them.

## Creating instances

`Person(name: 'Ada', age: 36, friends: [])` gives every field a value, by name or by position. Instances can't be
created with some fields missing, and enums can't be created this way at all.

## Methods

| Kind | Syntax | Receiver |
| --- | --- | --- |
| static | `fn static new` | none; called as `Person.new` |
| immutable | `fn name` | `ref Self`: fields are read-only |
| mutable | `fn mut rename` | `mut Self`: fields can change |
| moving | `fn move into_name` | `Self`, owned: can move fields out (see the ownership lesson) |

`self` is the receiver; calls on it can leave it out (`count` means `self.count`). Fields are exposed as `ref T` in
`fn` methods and as `mut T` in `fn mut` methods; value types (`Int`, `String`, …) are exposed as copies. A field
must be declared `let mut` to be assigned, and is then assigned with `@field = value`, or swapped with
`@field := value`, which returns the old value.

## Reopening

`impl Person { … }` adds methods to an existing type, even in another module of the same project. Fields can't be
added that way.

## Visibility

`type pub`, `let pub @field` and `fn pub` make a type, field or method public; without `pub`, they are private to
the root namespace they're defined in (the top-level directory or module). Public fields can be read with
`person.name` and assigned with `person.name = …` (for `let pub mut` fields).

## Drop order

When an instance is dropped, its fields are dropped in reverse order of definition, after the type's destructor (if
it has one) runs.
