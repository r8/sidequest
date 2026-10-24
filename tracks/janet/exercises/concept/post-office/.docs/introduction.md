# Introduction

Janet runs one fiber at a time, but it can juggle many.
Its _event loop_ keeps a set of fibers called _tasks_ and switches between them whenever the running one has to wait — for a timer, for a file or network socket, or for a message from another task.
Tasks talk to each other through _channels_.
Together they give Janet concurrency without threads or locks: everything still runs on one thread, and a task is only ever paused at a point where it waits.

The functions for all of this live in the `ev/` module, which is part of the core.

## Starting a task: `ev/go`

`ev/go` takes a function (or a fiber) and schedules it as a new task.
It returns the task's fiber at once; the task itself starts only when the current one waits.

```janet
(def log @[])

(ev/go (fn [] (array/push log :task)))
(array/push log :main)
(ev/sleep 0)
log # => @[:main :task]
```

`(ev/sleep seconds)` pauses the current task for that long and lets the others run; `(ev/sleep 0)` just gives them a turn.
When a task's function returns, its fiber is `:dead`, as with any fiber.

## Channels

A channel is a queue that tasks share.
`(ev/chan capacity)` makes one that can hold up to `capacity` values; `(ev/chan)` makes one with capacity 0.

- `(ev/give channel value)` puts a value in. If the channel is full, the giving task waits until another task takes something out.
- `(ev/take channel)` takes the oldest value out. If the channel is empty, the taking task waits until another task gives something.

```janet
(def box (ev/chan 2))
(ev/give box "postcard")
(ev/give box "parcel")
(ev/count box) # => 2
(ev/take box)  # => "postcard", first in, first out
```

Waiting is what makes channels useful: a task that takes from an empty channel simply sleeps until there is work, and a task that gives to a full one is held back until the other side catches up.

```janet
(def requests (ev/chan))
(def replies (ev/chan 10))

(ev/go
  (fn []
    (forever
      (ev/give replies (* 2 (ev/take requests))))))

(ev/give requests 21)
(ev/take replies) # => 42
```

The doubling task spends almost all its life asleep inside `ev/take`, costing nothing.

## Closing a channel

`(ev/chan-close channel)` closes a channel for good.
Every task waiting to take from it wakes up with `nil`, and every later `ev/take` returns `nil` at once, so a worker can loop "until the take returns `nil`" and finish cleanly.
Giving to a closed channel is an error, and anything still in a closed channel's buffer is discarded — close a channel only when everything in it has been taken.

## Waiting for several things: `ev/gather`

`ev/gather` takes any number of expressions, runs each one as its own task, waits until all of them are finished, and returns their results as an array, in the order the expressions were written:

```janet
(ev/gather
  (do (ev/sleep 0.2) :slow)
  (do (ev/sleep 0.1) :fast))
# => @[:slow :fast], after about 0.2 seconds, not 0.3
```

If any of them raises an error, `ev/gather` cancels the others and raises it.

## Deadlock

A task that waits for something no other task will ever do waits forever.
The classic case is two parties both waiting to give: A gives to a channel that is full until B takes, while B is itself waiting to give to a channel that is full until A takes.
Neither can move.
Unlike most errors, a deadlock does not raise anything; the program just stops making progress.
When you design a pipeline, ask for each `ev/give` who is going to take, and make sure channels are large enough that nobody has to wait on someone who is waiting on them.

## Pitfalls

- A script does not end while a task is still waiting on a channel or a timer: the event loop keeps running. Let your tasks finish, for example by closing the channel they read from.
- `ev/go` returns before the task has done anything. Do not expect its effects until the current task has waited.
- Tasks share mutable data freely — they all run on one thread, so there are no data races, but a task only sees another's change after that one has run.
