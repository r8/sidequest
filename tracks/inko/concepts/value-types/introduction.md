# Introduction

Value types are copied instead of moved: `Int`, `Float`, `Bool`, `Nil` and `String`, and your own `type copy`
types, which are stack allocated, immutable and may only hold other `copy` values:

```inko
type pub copy Point {
  let pub mut @x: Int
  let pub mut @y: Int

  fn pub move shifted(by: Int) -> Point {
    @x += by
    @y += by
    self
  }
}
```

Their fields can only be assigned through an owned value (an `fn move` method), which works on a copy. `type inline`
is stack allocated but moved, and may hold anything; `type ref` is reference counted, immutable and shared.
