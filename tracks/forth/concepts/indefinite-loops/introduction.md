# Introduction

Indefinite loops run until a flag says stop:

- `begin … flag until` — runs the body, then leaves when the flag is true; always at least one pass.
- `begin … flag while … repeat` — tests first; leaves after `repeat` as soon as the flag is false, so it can run zero times.
- `begin … again` — loops forever; leave it with `exit`.

```forth
: digits ( n -- count )
  0 swap begin  swap 1+ swap  10 /  dup 0= until  drop ;
```

There is no index: the loop's state lives on the data stack, and each pass must leave the stack in the shape the next one expects.
`until` and `while` consume their flag.
