# Hints

## General

- The [fibers](https://janet-lang.org/docs/fibers/index.html) page of the Janet documentation explains `fiber/new`, `resume` and `yield`.
- The [fiber module reference](https://janet-lang.org/api/fiber.html) lists `fiber/status` and the other fiber functions.

## 1. Load the belt

- Create the fiber with `fiber/new` or `coro`; inside it, `yield` each box with `each`.

## 2. Take the next box

- Resuming a `:dead` fiber is an error; look at `fiber/status` first.
- The resume after the last box lets the fiber's function finish, and returns what the function returns.

## 3. Unload the rest

- A fiber can be iterated with `each`, which only sees the yielded values.
- Collect them with `array/push`, or use `map` with a function that returns its argument.

## 4. Print the labels

- An endless `while` loop is fine inside a fiber: it pauses at every `yield`.
- Keep the count in a `var`.

## 5. Weigh the shipment

- The first `resume`'s value is the argument of the fiber's function; every later one is the value of `yield`.
- Yield the running total, and add what `yield` returns to it.
