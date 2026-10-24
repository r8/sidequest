# Hints

## General

- [`defer`](https://janet-lang.org/api/index.html#defer), [`edefer`](https://janet-lang.org/api/index.html#edefer) and [`with`](https://janet-lang.org/api/index.html#with) in the core API reference.
- The [error handling](https://janet-lang.org/docs/fibers/error_handling.html) page explains how errors travel between fibers.

## 1. Read in the library

- `defer` takes the cleanup first and the body after it.

## 2. Lend a book

- The book should go back only on failure: that is what `edefer` is for.

## 3. Open the reading room

- A method is a function stored in the table that takes the table itself as its first argument.

## 4. Study in the reading room

- `with` calls the `:close` method of the value it binds when its body is done.
- Reuse `reading-room`.

## 5. Borrow the archive key

- `array/pop` takes the last element off an array and returns it.
- `with`'s binding takes an optional third element: a function that is called with the value instead of its `:close` method.
