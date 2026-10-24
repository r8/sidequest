# Introduction

A future carries one value from one process to another. Many problems look different: a pile of jobs to share out
among a few workers, or a stream of results flowing back from all of them. For those, Inko has _channels_.

## Channels

A `Channel[T]`, from `std.sync`, is a queue that any number of processes can send values into and receive values
from. Values come out in the order they went in (first in, first out):

```inko
import std.sync (Channel)

let channel = Channel.new

channel.send('first')
channel.send('second')

channel.receive # => 'first'
channel.receive # => 'second'
```

- `send(value)` adds a value and never blocks; a channel has no size limit.
- `receive` takes the oldest value, and if the channel is empty, waits until one is sent.
- `receive_until(deadline)` waits at most until a deadline, returning `Some(value)` or `None`.

Like everything that crosses between processes, the values must be sendable: value types such as `String` and `Int`
go in as they are, other values as unique values (`channel.send(recover [1, 2])`). `receive` hands them back as
`uni T`, so `recover` a received value that isn't a value type before using it like any other value.

## Sharing a channel

Every copy of a channel made with `clone` refers to the _same_ queue. To give a channel to a process, send it a
unique clone:

```inko
type pub async Worker {
  fn pub async work(jobs: uni Channel[Int], results: uni Channel[Int]) {
    loop {
      let job = jobs.receive

      if job < 0 { break }

      results.send(job * job)
    }
  }
}

let jobs = Channel.new
let results = Channel.new

Worker().work(recover jobs.clone, recover results.clone)
Worker().work(recover jobs.clone, recover results.clone)
```

`recover jobs.clone` is allowed because the clone holds no borrows: it's just another handle to the shared queue.

## Workers sharing a queue

The workers above take jobs from one channel and send results into another. Whichever worker is free takes the next
job, so the work spreads out by itself: a fast worker simply takes more jobs. This is the main reason to reach for a
channel instead of sending each job to a particular process.

```inko
for number in [1, 2, 3, 4] { jobs.send(number) }

let squares = []

4.times(fn (_) { squares.push(results.receive) })
```

Results arrive in the order the workers finish, which may differ from the order of the jobs. When the order
matters, send each result along with something that identifies its job, such as a tuple `(job, result)`, and put
them back together on the receiving end; a `Map` keyed by the job is often the easiest way.

## Stopping workers

A worker waiting on `receive` waits for as long as it takes, and a channel can't be closed. A simple way to stop the
workers is a _sentinel_: a special value meaning "no more work", sent once per worker after the real jobs. Each
worker stops at the first sentinel it receives, and since every worker takes exactly one, all of them stop. The
worker above uses negative numbers as its sentinel.

Alternatively, `receive_until` with a deadline lets a worker give up once no job has arrived for a while.

## Futures or channels?

Use a future for one answer to one request, and `await` or `async` with it. Use a channel when values keep
flowing, when several producers or consumers share the same stream, or when work should be balanced among workers
automatically.
