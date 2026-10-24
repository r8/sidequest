# Hints

## General

- [Buffers](https://janet-lang.org/docs/data_structures/buffers.html) in the Janet documentation shows how to create and change them.
- The [buffer module](https://janet-lang.org/api/buffer.html) in the core API lists `buffer/push`, `buffer/clear` and the rest.

## 1. Start a telegram

- The `buffer` function, or `buffer/push` on `@""`, makes a new buffer from several pieces.
- `string/ascii-upper` turns text into capitals.

## 2. Add a sentence

- `buffer/push` takes several values at once and returns the buffer.

## 3. Hide the digits

- Indexing a buffer gives a byte; `chr` gives the byte of a one-character string, so `(chr "0")` and `(chr "9")` bound the digits.
- `put` replaces a byte at an index; `for` goes through the indices.

## 4. Send the telegram

- `string` makes an immutable copy of the buffer's contents.
- Take the copy before you empty the buffer.
