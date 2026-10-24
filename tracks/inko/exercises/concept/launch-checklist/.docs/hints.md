# Hints

## General

- The manual's [control flow][control-flow] page describes `throw` and `try`; its [error handling][errors]
  tutorial shows them in a program.

## 1. Check the fuel

- `throw LaunchError.LowFuel(percent)` returns the error; otherwise finish with `Result.Ok(percent)`.

## 2. Check the wind

- The same shape as the fuel check.

## 3. Read a sensor

- `Int.parse` returns an `Option`. Match on it, throwing in the `None` case, or use `let Some(…) = … else throw …`.

## 4. Run the checklist

- `try` each step in order. A `try` can wrap another: `try check_fuel(try read_sensor(fuel))`.
- Throw `NotArmed` when the igniter isn't armed, and end with `Result.Ok(nil)`.

## 5. Explain the problem

- Match on `self`, one case per error.

[control-flow]: https://docs.inko-lang.org/manual/latest/getting-started/control-flow/
[errors]: https://docs.inko-lang.org/manual/latest/getting-started/hello-error-handling/
