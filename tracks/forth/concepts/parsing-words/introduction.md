# Introduction

A parsing word reads text that follows it in the source, as `char`, `'`, `create` and `s"` do.
The text interpreter keeps its input in a buffer, `source ( -- c-addr u )`, and the offset of the next character to read in the variable `>in`.

- `parse-name ( "name" -- c-addr u )` skips spaces and returns the next word (length 0 at the end of the input).
- `parse ( char "text<char>" -- c-addr u )` returns the text up to `char`, without skipping spaces first.

```forth
: greet ( "name" -- ) ." Hello, " parse-name type ;
greet Ada   \ prints Hello, Ada
```

The strings point into the input buffer, so copy them to keep them.
Saving and restoring `>in` lets a word look ahead without consuming; a parsing word inside a definition reads when the definition runs.
