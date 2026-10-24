# About

## Tasks

A task is a fiber the event loop resumes.
`ev/go` schedules a function or fiber (optionally with a value to resume it with, and a _supervisor_ channel that receives its signals); `(ev/spawn body…)` is shorthand for `(ev/go (fn [] body…))`.
Scheduling is cooperative: a task runs until it waits — on `ev/sleep`, a channel, a stream read or write, `os/proc-wait` — and only then can another task run.
A loop that never waits starves every other task.

The main program is itself running inside the event loop, so the top level of a script can give and take and sleep.
The script ends only when no tasks are pending: a task blocked forever on a channel keeps the process alive.
`os/exit` ends it regardless.

## Channels

| Function | Does |
| --- | --- |
| `(ev/chan &opt capacity)` | a channel with a buffer of `capacity` values (default 0) |
| `(ev/give ch v)` | put `v` in, waiting while the buffer is full; returns the channel |
| `(ev/take ch)` | take the oldest value, waiting while it is empty |
| `(ev/count ch)`, `(ev/capacity ch)`, `(ev/full ch)` | the buffer's state |
| `(ev/chan-close ch)` | close: waiting takers wake with `nil`, the buffer is discarded, later gives raise an error |
| `(ev/select clause…)` | wait on several channels at once — a channel to take from, or `[ch v]` to give to; returns `[:take ch v]`, `[:give ch]` or `[:close ch]` for the first ready |
| `(ev/rselect ch…)` | the same, choosing randomly among ready ones |

Channel values are any Janet values, passed by reference: tasks on one thread share memory safely, so there is nothing to copy.
`ev/thread-chan` makes a channel that can cross OS threads (`ev/thread`, `ev/do-thread`), where values are marshalled.

## Waiting for many

- `(ev/gather expr…)` runs each expression in its own task and returns an array of their results in argument order; if one raises an error the others are cancelled and the error propagates.
- `(ev/with-deadline seconds body…)` cancels the body if it takes too long; `(ev/deadline seconds)` does the same for the current task.
- `(ev/cancel fiber err)` makes a waiting task resume with an error.

## Deadlock and back-pressure

A capacity-0 channel is a rendezvous: `ev/give` waits until a taker arrives.
That is back-pressure — a fast producer cannot run far ahead of a slow consumer — but it also means a task that gives on one channel before taking from another can wait on a peer that is waiting on it.
Janet does not detect deadlocks; the stuck tasks simply never resume.
Size buffers so each give has a taker, or let separate tasks do the giving and the taking.

## Shutting a pipeline down

The usual way to stop a worker is to close its input channel: its `ev/take` returns `nil`, and a worker written as "loop until the take is `nil`" returns, which lets the program exit.
Close only after everything buffered has been taken — closing discards the buffer.

## Beyond channels

The same loop drives non-blocking I/O: `net/server`, `net/connect`, `os/spawn` with `:pipe`, `file` streams opened with `os/open`.
Each read or write waits like `ev/take` does, so a server is a task per connection, written as straight-line code.
