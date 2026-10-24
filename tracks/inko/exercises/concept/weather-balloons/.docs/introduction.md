# Introduction

`await` sends a message and waits for the reply in one go. That is simple, but it does one thing at a time: three
`await`s in a row ask three processes one after the other, each waiting for the last. To ask them all at once and
_then_ collect the answers, you need the pieces `await` is built from: _futures_ and _promises_.

## Future and Promise

A `Future[T]` is a value that will be available later; its `Promise[T]` is the means to provide that value. They
come in pairs, created by `Future.new` from `std.sync`:

```inko
import std.sync (Future)

let (future, promise) = Future.new

promise.set(42)
future.get # => 42
```

Usually the promise is handed to a process, which sets it when the work is done, while the future stays with the
code that wants the result. Both are unique values (`uni Future[T]` and `uni Promise[T]`), so either can be sent to
another process.

- `promise.set(value)` provides the value. It consumes the promise, so a value can only be set once, and it never
  blocks.
- `future.get` waits until the value is set, then returns it. It consumes the future.

## async

An `async` expression sends a message that takes a promise as its first argument, and returns the future instead of
waiting for it:

```inko
let future = async oven.temperature # the message is sent; nothing waits yet

…                                   # do other work in the meantime

future.get                          # now wait for the answer
```

`async process.message(args)` is exactly `Future.new`, sending `message(promise, args)`, and returning the future.
`await process.message(args)` is the same followed by `get`.

## Fanning out

With `async`, asking many processes at once and collecting their answers takes two steps: first send every message,
keeping the futures, then wait for each future:

```inko
let futures = stations.iter.map(fn (station) { async station.temperature }).to_array

futures.into_iter.map(fn (future) { future.get }).to_array
```

All the stations work at the same time, and the total time is that of the slowest one rather than the sum of all.
The answers come back in the order of the futures, whatever order the processes finished in. `to_array` matters
here: iterators are lazy, so without it every message would only be sent when `get` asks for its result, one at a
time again. And `get` consumes its future, which is why the futures are taken out of the array with `into_iter`.

## Waiting with a deadline

`get` waits for as long as it takes. When an answer might never come, `get_until` waits up to a deadline and
returns an `Option`: `Some(value)` if the value arrived in time, `None` otherwise:

```inko
import std.time (Duration)

match future.get_until(Duration.from_millis(500)) {
  case Some(value) -> 'got ${value}'
  case None -> 'no answer'
}
```

`Duration.from_millis`, `from_secs` and friends create durations. Like `get`, `get_until` consumes the future,
even when it times out; to try again, create a new future and send the message again. `try_get` checks without
waiting at all, returning `Ok(value)` or `Error(future)`, giving the future back.

## Dropped promises

If a promise is dropped without being set, for example because a message forgot to reply on some code path, then
`get` on its future panics instead of waiting forever. `get_until` returns `None` instead. Setting a promise whose
future has been dropped does nothing harmful: `set` returns the value back in a `Some`.
