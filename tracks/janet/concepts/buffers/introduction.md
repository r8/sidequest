# Introduction

A buffer is a mutable string, written with an `@` in front of a string literal: `@"text"`.
It is the tool for building text piece by piece.

```janet
(def line @"")
(buffer/push line "ARRIVE" " " "NOON")  # appends, returns the buffer
line                                    # => @"ARRIVE NOON"

(buffer "Room " 12)                     # => @"Room 12", a new buffer
(buffer/popn line 5)                    # => @"ARRIVE", removes bytes from the end
(buffer/clear line)                     # => @""
```

Like strings, buffers are bytes: `(get buf i)` is a number, `chr` gives the byte of a one-character string, and `(put buf i byte)` replaces one in place.
A number passed to `buffer/push` is appended as a byte, not as digits.

`(string buf)` makes an immutable copy.
Buffers compare by identity, so `(= @"a" @"a")` is `false`; use `deep=` or convert to strings first.
