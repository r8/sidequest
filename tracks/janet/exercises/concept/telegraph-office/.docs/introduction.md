# Introduction

Strings in Janet are immutable: functions such as `string/ascii-upper` or `string` return a new string and leave their arguments alone.
When text is built up piece by piece — in a loop, or across several function calls — creating a new string at every step is wasteful.
For that, Janet has the _buffer_: a mutable string.

## Creating buffers

A buffer literal is a string literal with `@` in front, the same `@` that marks arrays and tables as the mutable versions of tuples and structs:

```janet
(def note @"Dear Sir")
(def empty @"")
```

The `buffer` function makes a new buffer from any values, converting them the way `string` does:

```janet
(buffer "Room " 12)  # => @"Room 12"
```

## Adding to a buffer

`buffer/push` appends strings, buffers, keywords and symbols to the end of a buffer, changing it, and returns the same buffer:

```janet
(def line @"")
(buffer/push line "ARRIVE")
(buffer/push line " " "NOON")
line # => @"ARRIVE NOON"
```

A number given to `buffer/push` is a byte, not digits: `(buffer/push line 33)` appends `!`, the character with code 33.
To append a number's digits, convert it first with `(string n)`.
`buffer/push-byte` appends bytes only, and `buffer/push-string` strings only, which makes the intent explicit.

Because `buffer/push` returns its buffer, a function that adds to a buffer can simply end with the push.

## Bytes

Janet strings and buffers are sequences of bytes.
Indexing one returns a number, the byte's code, and `chr` gives the code of a one-character string:

```janet
(get "HELLO" 0)   # => 72
(chr "H")         # => 72
(= (get "HELLO" 0) (chr "H")) # => true
```

Unlike a string, a buffer can be changed in place with `put`:

```janet
(def word @"cat")
(put word 0 (chr "b"))
word # => @"bat"
```

Looping over a buffer or a string with `each` gives one byte at a time, and `for` over the indices from `0` below `(length buf)` lets you read and replace bytes by position.

## Removing from a buffer

`buffer/popn` removes a number of bytes from the end, and `buffer/clear` empties a buffer completely.
Both change the buffer and return it:

```janet
(def tape @"STOP STOP")
(buffer/popn tape 5)  # => @"STOP"
(buffer/clear tape)   # => @""
```

## Buffers and strings together

Most functions that read strings also accept buffers: `length`, `string/has-prefix?`, `string/find`, `string/ascii-upper` and the rest.
The `string/` functions that build text return new immutable strings, even when given a buffer.

`(string buf)` makes an immutable string with the buffer's current contents.
It is a copy: changing the buffer afterwards does not change the string.

```janet
(def draft @"Draft")
(def copy (string draft))
(buffer/push draft "!")
copy  # => "Draft"
draft # => @"Draft!"
```

## Pitfalls

- A buffer is never `=` to a string, and two buffers are `=` only if they are the same buffer: `(= @"a" @"a")` is `false`. Compare contents with `deep=`, or convert with `string` first.
- `buffer/push` with a number appends one byte, not the number's digits.
- `put` past the end of a buffer pads it with zero bytes up to that index.
- A buffer shared between two parts of the program is changed for both. Hand out a `string` copy when the receiver should not see later changes.
