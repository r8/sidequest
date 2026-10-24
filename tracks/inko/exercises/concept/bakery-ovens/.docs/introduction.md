# Introduction

Inko programs do several things at once with _processes_: lightweight, isolated units of work, each running its
own code concurrently with the others. Inko processes are not operating system processes. They are cheap to create
(a program can run thousands of them), they're scheduled over a few OS threads by Inko's runtime, and they share
no memory: they communicate only by sending each other messages.

## Defining a process

A process type is defined with `type async`. Its fields are its private state:

```inko
type pub async Counter {
  let mut @count: Int
}
```

Creating an instance spawns a new process, which waits for messages:

```inko
let counter = Counter(count: 0)
```

The value you get back is a handle to the process, not the process itself. Handles are value types, so they can be
copied, stored and passed around (to other processes too); the process stays alive while any handle exists and it
has work to do. Static methods work as usual, so a `new` method keeps callers from needing the fields.

## Messages

The messages a process understands are its `fn async` methods. Sending one is written like a method call, but it
doesn't wait: the message is put in the process' mailbox, and the sender carries on immediately. The process
handles its messages one at a time, in the order they arrive:

```inko
type pub async Counter {
  let mut @count: Int

  fn pub async mut increment(amount: Int) {
    @count += amount
  }
}

counter.increment(5) # returns at once; the counter adds 5 soon
```

An `fn async mut` message may change the process' fields. Because a process only ever runs one message at a time,
and nobody else can touch its fields, there's never a data race and never a need for locks.

Outside the process, its fields and its ordinary (non-`async`) methods are off limits: `counter.count` doesn't
compile. Messages are the only way in.

## Sendable arguments

Since processes share no memory, every argument of a message must be _sendable_: a value type (`Int`, `Float`,
`Bool`, `String`, …), another process handle, or a unique value (`uni T`) from the previous lesson. A unique value is
moved into the process; the sender loses it, so the two can never both use it:

```inko
fn pub async mut add_names(names: uni Array[String]) {
  @names.append(recover names)
}

directory.add_names(recover ['Ada', 'Grace'])
```

The same goes for the values a process is spawned with: a field holding an array is given `recover []`, not `[]`.

## Replies with promises

Messages can't return values: the sender has moved on by the time the message runs. To get an answer back, the
sender passes a `Promise` from `std.sync`, and the process _sets_ it. The convention is to make the promise the
first argument:

```inko
import std.sync (Promise)

type pub async Counter {
  let mut @count: Int

  fn pub async count(reply: uni Promise[Int]) {
    reply.set(@count)
  }
}
```

The value set must be sendable too. For a value that isn't a value type, such as a `Result` or an `Array`, recover
it: `reply.set(recover Result.Ok(@count))`.

## await

On the sending side, `await` sends a message whose first argument is a promise, creating the promise for you, and
then waits until the process sets it:

```inko
let counter = Counter(count: 0)

counter.increment(5)
counter.increment(2)

await counter.count # => 7
```

`await` leaves out the promise argument: `counter.count` is called as if `count` had no arguments. Waiting blocks
only the waiting process, not the whole program. Since messages from one process to another are handled in the
order they were sent, `await counter.count` sees both increments.

The awaited value comes back as a unique value (`uni T`). For value types that makes no difference; for anything
else, `recover` turns it into an ordinary value: `let result = recover await oven.bake(12)`.

## Every program is a process

A runnable Inko program starts in the `Main` process, `type async Main` with an `fn async main` message, which is
why the hello-world program looks the way it does. The tests run in processes of their own.
