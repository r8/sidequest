# Introduction

Processes are Inko's unit of concurrency: lightweight, isolated, scheduled by the runtime, sharing no memory. A
process type is `type async`; creating one spawns a process. Its `fn async` methods are messages, sent without
waiting and handled one at a time, in order:

```inko
type pub async Counter {
  let mut @count: Int

  fn pub async mut increment(amount: Int) {
    @count += amount
  }

  fn pub async count(reply: uni Promise[Int]) {
    reply.set(@count)
  }
}

let counter = Counter(count: 0)

counter.increment(5)
await counter.count # => 5
```

Message arguments must be sendable (value types, process handles, `uni` values). Replies go through a
`std.sync.Promise`; `await` creates it, sends the message and waits for the value.
