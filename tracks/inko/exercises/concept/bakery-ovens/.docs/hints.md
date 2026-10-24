# Hints

## General

- The manual's [hello, concurrency][hello] tutorial introduces processes, promises and `await`; its
  [concurrency][concurrency] page goes deeper.

## 1. Fire up an oven

- Three fields will do: the temperature, the loaves baked, and the trays (an `Array[Array[String]]`).
- Fields of a process must be given sendable values: `recover []` for the trays.
- Reply by calling `set` on the promise.

## 2. Heat an oven

- An `fn async mut` message can assign the process' fields.

## 3. Bake bread

- A `Result` isn't a value type, so recover it before setting the promise: `reply.set(recover Result.Ok(…))`.
- Return early after replying with the error.

## 4. Load a tray

- `recover tray` turns the unique array into an ordinary one the oven can keep.

## 5. Preheat the ovens

- Sending a message doesn't wait for it, so a plain loop over the ovens heats them all at once.

[hello]: https://docs.inko-lang.org/manual/latest/getting-started/hello-concurrency/
[concurrency]: https://docs.inko-lang.org/manual/latest/getting-started/concurrency/
