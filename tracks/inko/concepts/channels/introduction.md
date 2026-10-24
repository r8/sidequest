# Introduction

`std.sync.Channel[T]` is an unbounded, first-in first-out queue shared by any number of processes. `send` never
blocks; `receive` waits for a value; `receive_until(deadline)` waits at most until a deadline.

```inko
let jobs = Channel.new

Worker().work(recover jobs.clone)
jobs.send(42)
```

All clones refer to the same queue, and a process gets its own with `recover channel.clone`. Values must be
sendable. Workers taking jobs from one channel balance the load by themselves; a sentinel value per worker tells them
to stop, since channels can't be closed.
