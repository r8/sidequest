# Hints

## General

- The [event loop](https://janet-lang.org/docs/event_loop.html) page of the Janet documentation introduces tasks and channels.
- The [ev module reference](https://janet-lang.org/api/ev.html) lists `ev/go`, `ev/chan`, `ev/give`, `ev/take`, `ev/chan-close` and `ev/gather`.

## 1. Post the letters

- `ev/give` puts one value into a channel.

## 2. Collect the letters

- `ev/take` takes one value out; do it `count` times.

## 3. Start the stamping machine

- `ev/go` starts a function as a task and returns its fiber.
- After the input channel is closed, `ev/take` returns `nil`: loop while the letter you took is not `nil`.

## 4. Run the office

- Combine the first three tasks.
- Think about who takes each letter you give, and when. If both you and the machine are waiting to give, nobody is left to take: give the output channel enough room for every letter.
- Close the input channel once every stamped letter is collected, then give the machine a turn to finish with `(ev/sleep 0)`.

## 5. Deliver by two routes

- `ev/gather` runs several expressions as tasks and returns all their results.
