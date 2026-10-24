# Introduction

Janet's _event loop_ runs many fibers, called _tasks_, on one thread, switching whenever the running one waits for a timer, I/O or a channel.

- `(ev/go f)` starts function `f` as a task and returns its fiber; it runs once the current task waits.
- `(ev/sleep s)` waits `s` seconds; `(ev/sleep 0)` lets other tasks run.
- `(ev/chan capacity)` makes a channel; `ev/give` puts a value in (waiting while it is full), `ev/take` takes the oldest out (waiting while it is empty).
- `(ev/chan-close ch)` closes it: takers get `nil`, givers get an error.
- `(ev/gather expr…)` runs each expression as a task and returns all their results, in order.

```janet
(def jobs (ev/chan))
(def results (ev/chan 10))
(ev/go (fn [] (forever (ev/give results (* 2 (ev/take jobs))))))
(ev/give jobs 21)
(ev/take results) # => 42
```

Two tasks each waiting for the other is a deadlock: nothing raises, nothing moves.
