# Introduction

`std.sync.Future.new` returns a pair `(uni Future[T], uni Promise[T])`: whoever holds the promise provides the value
with `set`, and whoever holds the future waits for it with `get`. Both consume their receiver.

`async process.message(args)` creates the pair, sends the message with the promise as its first argument, and
returns the future without waiting; `await` does the same and then calls `get`. To ask several processes at once,
create all the futures first, then `get` them:

```inko
let futures = stations.iter.map(fn (s) { async s.temperature }).to_array

futures.into_iter.map(fn (f) { f.get }).to_array
```

`get_until(deadline)` waits at most until a deadline, returning an `Option`; `try_get` doesn't wait at all.
