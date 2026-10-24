# About

## API

| Method | Behaviour |
| --- | --- |
| `Channel.new` | a new, empty channel |
| `send(value: uni T)` | adds a value; never blocks |
| `receive -> uni T` | removes the oldest value, waiting while the channel is empty |
| `receive_until(deadline) -> Option[uni T]` | the same, giving up at the deadline |
| `clone` | another handle to the same channel |

There is no way to check for a value without waiting (a `try_receive` would race with the sender), nor to close a
channel.

## How it works

A channel is implemented with a process holding the queue, plus futures and promises: `receive` sends that process
a promise and waits for its future. That's why receiving costs a message round trip, and why `receive_until` can
give up cleanly.

## Patterns

- **Work queue**: N workers `receive` from one jobs channel and `send` to one results channel. The busiest worker
  automatically takes fewer jobs.
- **Fan-in**: many producers send into one channel that a single consumer drains.
- **Sentinels**: after the real jobs, send one "stop" value per worker. Use an enum (`case Job(Int)`,
  `case Stop`) instead of a magic value when every value could be a real job.
- **Correlation**: results arrive in completion order; send `(id, result)` pairs and reassemble with a `Map` or by
  sorting when the order matters.

## Sendability

Values travel as `uni T`. Value types need nothing special; anything else must be recovered before sending
(`recover (name, count)`), and recovered again after receiving to use it as an ordinary value.

## Channels versus messages

Sending a message to a specific process is the right tool when that process owns the state involved. A channel
fits when it doesn't matter who handles a value, only that someone does.
