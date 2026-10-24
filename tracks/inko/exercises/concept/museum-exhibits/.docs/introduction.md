# Introduction

Inko types can't inherit from each other. Instead, behaviour is shared through _traits_: a trait names a set of
methods, and any type can _implement_ it by providing them.

## Defining a trait

A trait lists method signatures. A signature without a body is a _required_ method, which every implementing type
must define:

```inko
trait pub Animal {
  fn pub name -> String
  fn pub legs -> Int
}
```

## Implementing a trait

`impl Trait for Type` provides the required methods for one type:

```inko
type pub Dog {
  let @name: String
}

impl Animal for Dog {
  fn pub name -> String {
    @name
  }

  fn pub legs -> Int {
    4
  }
}

type pub Bird {}

impl Animal for Bird {
  fn pub name -> String {
    'a bird'
  }

  fn pub legs -> Int {
    2
  }
}
```

After that, `Dog(name: 'Rex').legs` works like any other method. The methods in an `impl` have access to the
type's fields, just like methods defined in the type itself. Leaving out a required method is a compile-time
error.

## Default methods

A trait method _with_ a body is a _default_ method. Every implementing type gets it for free, and the default can
call the trait's other methods, whatever the implementing type does for them:

```inko
trait pub Animal {
  fn pub name -> String
  fn pub legs -> Int

  fn pub describe -> String {
    '${name} walks on ${legs} legs'
  }
}

Dog(name: 'Rex').describe # => 'Rex walks on 4 legs'
Bird().describe            # => 'a bird walks on 2 legs'
```

A type can _override_ a default method by defining it in its `impl`; its own version is used instead:

```inko
impl Animal for Bird {
  fn pub name -> String { 'a bird' }
  fn pub legs -> Int { 2 }

  fn pub describe -> String {
    '${name} flies'
  }
}
```

## Traits as types

A trait can be used as a type, standing for "any value whose type implements this trait". This lets one array hold
values of different types, as long as they share a trait. A value becomes a trait value with an explicit `as`:

```inko
let animals = [Dog(name: 'Rex') as Animal, Bird() as Animal]

for animal in animals.iter {
  animal.describe # each value uses its own type's methods
}
```

`animals` is an `Array[Animal]`. Inside the loop, Inko doesn't know (or care) which type each animal has: calling
`describe` runs the right method for the actual type. A method can take such an array as `ref Array[Animal]`.

The conversion is never implicit: `[Dog(name: 'Rex'), Bird()]` doesn't compile, because the values have different
types. Write `as Animal` for each one, or annotate an empty array: `let animals: Array[Animal] = []`.

## Standard traits

The standard library defines traits that the language itself relies on. Implementing them lets your types work
with built-in features:

- `std.string.ToString` (`fn pub to_string -> String`) lets values be interpolated into strings: `'${dog}'` calls
  `dog.to_string`.
- `std.cmp.Equal` provides `==` and `!=`; `std.cmp.Compare` provides `<`, `>`, and sorting.
- `std.fmt.Format` lets values be printed for debugging, as the tests do when a comparison fails.

Traits from other modules must be imported before you can implement them:

```inko
import std.string (ToString)

impl ToString for Dog {
  fn pub to_string -> String {
    @name
  }
}

'Good boy, ${Dog(name: 'Rex')}!' # => 'Good boy, Rex!'
```

## Required traits

A trait can require another trait: `trait pub Pet: Animal { … }` can only be implemented by types that also
implement `Animal`, and its default methods can use `Animal`'s methods.
