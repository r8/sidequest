# Hints

## General

- The manual's [hello, concurrency][hello] tutorial covers futures, promises, `async` and `await`; the
  [std.sync][sync] documentation describes every method of `Future` and `Promise`.

## 1. Report the peak

- Find the highest reading (`reduce`, or `std.cmp.max` in a loop), then `set` the promise.

## 2. Send a request

- An `async` expression sends the message and returns its future.

## 3. Ask every balloon

- First create all the futures and collect them into an array; then take them out with `into_iter` and `get` each
  one.

## 4. Find the record

- Reuse `peaks`.

## 5. Stop waiting

- `Future` has a method that waits until a deadline, and a `Duration` can be used as one.

[hello]: https://docs.inko-lang.org/manual/latest/getting-started/hello-concurrency/
[sync]: https://docs.inko-lang.org/std/latest/module/std/sync/
