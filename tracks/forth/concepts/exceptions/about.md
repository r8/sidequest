# About

## The model

`catch` saves the data-stack depth, the floating-point stack depth, the return-stack pointer and the input source, then executes the xt.
`throw` with a non-zero code unwinds straight back to the most recent `catch`, restores all of those, and makes `catch` return the code.
Nothing in between runs: there are no destructors or `finally` blocks, which is why cleanup is written as catch, clean up, rethrow:

```forth
: with-base ( xt base -- )
  base @ >r  base !  catch  r> base !  throw ;
```

The items below the code after a throw have the old depth but not necessarily the old contents.
Code that needs an argument after a failure keeps a copy on the return stack (restored by `catch`) or in a variable.

## Codes

| Range | Use |
| --- | --- |
| 0 | no exception: `0 throw` does nothing |
| -1 … -255 | standard codes, such as -1 `abort`, -2 `abort"`, -3 stack overflow, -4 stack underflow, -9 invalid memory address, -10 division by zero, -11 result out of range, -13 undefined word, -14 interpreting a compile-only word, -24 invalid numeric argument |
| -256 … -4095 | reserved for the system: gforth uses some, and `exception ( c-addr u -- n )` hands out new ones with a message |
| other | free for programs; small positive numbers are common |

## `abort` and `abort"`

`abort` is `-1 throw`; `flag abort" text"` is `-2 throw` when the flag is non-zero, and the text becomes the error message.
At the top level gforth prints the message; a `catch` sees only -2.

## Result codes and `throw`

Words such as `allocate`, `resize` and the file words return an _ior_, 0 for success.
The idiom `allocate throw` turns a failure into an exception and costs nothing on success.

## Uncaught exceptions

At the outer interpreter, an uncaught code prints an error (with the input line and a backtrace in gforth), empties the stacks and returns to the prompt — or, when gforth runs a file non-interactively, stops with a non-zero exit status.

## Style

- Throw where the error is detected, catch where something can be done about it, usually far apart.
- Catch only what you can handle: test the code and rethrow everything else.
- Prefer an exception to an "error value" that every caller must test, but prefer a flag for an outcome that is not an error (`search` returns a flag, not an exception, when the string is absent).
