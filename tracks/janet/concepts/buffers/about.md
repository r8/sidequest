# About

A buffer is the mutable counterpart of a string, as an array is of a tuple and a table of a struct.
Both are byte sequences with no notion of characters or encoding: a UTF-8 character outside ASCII takes several bytes.

## Creating

- `@"…"` is a buffer literal; `@`` … `` ` is a long-buffer literal for text with quotes in it.
- `(buffer & xs)` creates a buffer from the values converted as by `string`.
- `(buffer/new capacity)` creates an empty buffer with room reserved for `capacity` bytes, avoiding reallocation when the final size is known.

## Changing

| Function | Effect |
| --- | --- |
| `(buffer/push buf & xs)` | appends strings, buffers, keywords, symbols, and numbers as single bytes |
| `(buffer/push-string buf & strs)` | appends strings, and raises an error for anything else |
| `(buffer/push-byte buf & bytes)` | appends bytes |
| `(buffer/format buf fmt & args)` | appends `string/format` output, without an intermediate string |
| `(put buf i byte)` | replaces the byte at `i`; past the end, pads with zero bytes |
| `(buffer/popn buf n)` | removes the last `n` bytes |
| `(buffer/clear buf)` | empties the buffer, keeping its memory for reuse |
| `(buffer/blit dest src at)` | copies `src` into `dest` at an offset |

Each returns the buffer, so pushes can be chained or end a function.

## Reading

Everything that reads strings reads buffers: `length`, `get`, `slice` (which returns a string), `string/find`, `string/split`, `string/has-prefix?`, `each` over the bytes, PEG matching.
`buffer/slice` returns a new buffer instead.
The `string/` functions that produce text return strings, even for buffer input.

## Printing into a buffer

The `:out` dynamic binding decides where `print` and `printf` write.
`(with-dyns [:out buf] …)` sends the output into a buffer — handy for capturing what a function prints; a later lesson covers dynamic bindings.

## Equality and identity

Buffers are compared by identity: two buffers are `=` only when they are the same object.
`deep=` compares contents, and `(string buf)` makes an immutable snapshot that compares by value.
Because a buffer can change, it is a poor key for a table; convert it to a string first.

## When to use a buffer

- Building output in a loop: push into one buffer, convert once at the end.
- Editing bytes in place, such as masking or translating characters.
- Reusing one allocation across many messages with `buffer/clear`.

For a single concatenation, `string` is simpler and just as fast.
