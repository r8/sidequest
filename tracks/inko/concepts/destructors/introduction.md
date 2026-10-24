# Introduction

A destructor runs when a value is dropped. It is the `drop` method of `std.drop.Drop`, always a private `fn mut`:

```inko
import std.drop (Drop)

impl Drop for Connection {
  fn mut drop {
    @socket.close
  }
}
```

Values are dropped when their owner goes away: locals in reverse order of definition, then fields in reverse order
after the destructor of their owner has run, array values first to last. `std.drop.drop(value)` drops a value
early. Types with a destructor can't be destructured by `match` or `fn move`, and `copy` types can't have one.
