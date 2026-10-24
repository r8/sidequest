# About

## The pair

```inko
let (future, promise) = Future.new # uni Future[T], uni Promise[T]
```

| Method | Behaviour |
| --- | --- |
| `Promise.set(value)` | stores the value and wakes the waiting process; never blocks; returns `Some(value)` if the future is gone |
| `Future.get` | waits for the value; panics if the promise was dropped without a value |
| `Future.get_until(deadline)` | waits until the deadline; `Some(value)` or `None`; never panics |
| `Future.try_get` | doesn't wait; `Ok(value)`, or `Error(future)` to try again later |

All four consume their receiver, so each future resolves once and each promise is set at most once. Values pass
through as `uni T`; `recover` them to get an ordinary `T` when they aren't value types.

## async and await

```inko
async counter.count  # => uni Future[Int], the message is on its way
await counter.count  # => the Int, after waiting
```

Both only apply to method calls whose first argument is a `uni Promise[…]`, and they insert that argument for you.
Such methods may be messages of a process or ordinary methods.

## Deadlines

`get_until` takes anything implementing `std.time.ToInstant`: a `Duration` (relative to now) or an `Instant`
(absolute). An `Instant` computed once lets several waits share one overall deadline:

```inko
import std.time (Duration, Instant)

let deadline = Instant.new + Duration.from_secs(2)

futures.into_iter.map(fn (f) { f.get_until(deadline) }).to_array
```

## Futures or channels?

A future carries exactly one value from one producer to one consumer, which suits request/reply. When many values
flow, or many workers share a queue of jobs, a `Channel` (the next lesson) fits better.

## Futures from libraries

Because the promise can be passed to any process, a library function can start work in processes it creates and
return futures to a caller it knows nothing about: the caller decides when (and how long) to wait.
