# Hints

## General

- The manual's [hello, concurrency][hello] tutorial has a section on channels; the [Channel][channel] documentation
  lists its methods.

## 1. Put up the jobs

- Create a channel with `Channel.new` and `send` every ground into it.

## 2. Send a boat out

- `loop`, `receive` a job, and `break` on `'home'`.
- A tuple isn't a value type, so recover it before sending it: `catches.send(recover (ground, kilograms))`.

## 3. Collect the catches

- `receive` exactly `count` times; each catch can be taken apart with `let (ground, kilograms) = …`.
- Add up the kilograms per ground as in the seed catalogue lesson.

## 4. Run the fleet

- Give every boat its own `recover` clone of both channels.
- Sending one `'home'` job per boat after the real jobs makes every boat stop once the work runs out.
- Every ground produces one catch, so you know how many catches to collect.

[hello]: https://docs.inko-lang.org/manual/latest/getting-started/hello-concurrency/
[channel]: https://docs.inko-lang.org/std/latest/module/std/sync/Channel/
