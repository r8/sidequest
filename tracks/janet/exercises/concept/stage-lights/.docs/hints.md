# Hints

## General

- The [dynamic bindings](https://janet-lang.org/docs/fibers/dynamic_bindings.html) page of the Janet documentation covers `dyn`, `setdyn` and `with-dyns`.
- [`dyn`](https://janet-lang.org/api/index.html#dyn) and [`with-dyns`](https://janet-lang.org/api/index.html#with-dyns) in the core API reference.

## 1. Read the brightness

- `dyn` takes an optional default.

## 2. Describe a spotlight

- `string` turns a keyword into its name, without the colon.
- Reuse `brightness`.

## 3. Light a scene

- `with-dyns` binds a value for the duration of its body, and returns the body's value.

## 4. Dim the lights

- `setdyn` changes a binding for the rest of the current fiber.
- `max` keeps the result from going below 0.

## 5. Rehearse a cue

- `print` writes to `(dyn :out)` when it is set.
- Collect the output in a buffer and turn it into a string with `string`.
