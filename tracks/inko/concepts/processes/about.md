# About

## Processes

- `type async Name { … }` defines a process type; `Name(field: value)` spawns a process. The values given to its
  fields must be sendable.
- The handle you get back is a value type (atomically reference counted). A process is dropped once no handles
  remain and it has finished the messages in its mailbox.
- A process' fields and non-async methods are private to the process itself; other processes can only send it
  messages.
- Processes can't implement traits and can't be matched against.

## Messages

- `fn async name(…)` defines a message; `fn async mut` may change the process' fields.
- Message arguments must be sendable, and messages can't have a return type.
- Sending never blocks. Messages from one sender to one process are handled in the order they were sent; a process
  runs one message at a time.

## Replies

`std.sync.Future` and `Promise` carry a value back. `Future.new` returns a pair `(uni Future[T], uni Promise[T])`;
the process calls `promise.set(value)` and the waiting side calls `future.get`. Two expressions do this for you, for
a message whose first argument is a promise:

| Expression | Means |
| --- | --- |
| `async process.message(args)` | create a future and promise, send the message with the promise, return the future |
| `await process.message(args)` | the same, then wait for the value with `get` |

`get` returns a `uni T`; `recover` turns it into a `T` when it isn't a value type. A promise that is dropped without
being set makes `Future.get` panic, so every code path of a message must set its promise.

## Scheduling

Processes are scheduled cooperatively on a pool of OS threads, and the runtime preempts a process that runs for too
long, so one busy process can't starve the others. Blocking operations such as `Future.get`, `sleep` or network IO
suspend only the calling process.

## Main

Every program starts in `type async Main` with `fn async main`. When `main` returns, the program exits, even if
other processes are still running, so `main` must wait (for instance with `await` or `Future.get`) for work it
cares about.
