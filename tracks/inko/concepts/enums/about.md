# About

## Definition

```inko
type pub enum Shape {
  case Circle(Float)
  case Rectangle(Float, Float)
  case Point

  fn pub area -> Float {
    match self {
      case Circle(r) -> 3.14159 * (r * r)
      case Rectangle(w, h) -> w * h
      case Point -> 0.0
    }
  }
}
```

Cases are written `case Name` or `case Name(Type, …)`; their values are positional, without names. Create values
with `Shape.Circle(1.0)`; `Shape(…)` is not allowed. In patterns, cases are written without the type name.

## Generic and recursive enums

Enums can be generic, like `Option[T]` and `Result[T, E]`:

```inko
type pub enum Tree[T] {
  case Leaf
  case Node(Tree[T], T, Tree[T])
}
```

Heap-allocated enums (the default) can be recursive, as above. `inline` and `copy` enums can't, since their size
must be known.

## Modifiers

- `type enum`: allocated on the heap, can hold any values, can be recursive.
- `type inline enum`: stored on the stack (`Option` and `Result` are inline enums).
- `type copy enum`: an immutable value type that is copied on every move, like `Int`; its cases may only carry
  `copy` values (`Int`, `Float`, `Bool`, `Nil` and other `copy` types). Ideal for plain sets of names, such as
  directions or colours.

The value-types lesson explains `inline` and `copy` in detail.

## Traits

Enums get no traits for free. To compare them with `==`, print them, hash them or clone them, implement `Equal`,
`Format`, `Hash` or `Clone`, usually by matching on `(self, other)`:

```inko
impl Equal for Light {
  fn pub ==(other: ref Light) -> Bool {
    match (self, other) {
      case (Red, Red) or (Amber, Amber) or (Green, Green) -> true
      case _ -> false
    }
  }
}
```

`std.reflect.enum_tag(value)` returns the index of a value's case, which can shorten such comparisons for enums
without data.

## Limitations

A `match` on an enum with a custom destructor (`Drop`) isn't allowed, since matching may destructure it.
