# Introduction

Sooner or later a word is asked to do something it cannot do: divide by zero, take an item from an empty shelf, accept a number outside its range.
Forth's answer is _exceptions_: the word `throw`s a number, and the nearest `catch` further up receives it.

## `throw`

`throw ( code -- )` does nothing when the code is 0.
Any other code abandons the current word, and every word that called it, up to the nearest `catch`:

```forth
: halve-even ( n -- n/2 )
  dup 1 and if 7 throw then  2/ ;
```

`6 halve-even` leaves 3; `5 halve-even` throws 7 and never reaches `2/`.
Because `0 throw` does nothing, `throw` can be applied directly to a result code: a word that returns 0 for success can be followed by `throw` to turn any failure into an exception.

If nothing catches the code, gforth stops what it was doing and prints an error; for well-known codes it prints a message, such as `Division by zero` for -10.

## Choosing codes

The standard reserves the codes -1 to -255 for the system, with fixed meanings; a few you will meet:

| Code | Meaning                      |
| ---- | ---------------------------- |
| -1   | `abort`                      |
| -2   | `abort"`                     |
| -4   | stack underflow              |
| -10  | division by zero             |
| -13  | undefined word               |
| -24  | invalid numeric argument     |

Programs choose their own codes for their own errors, usually small positive numbers, and give them names with `constant`:

```forth
1 constant out-of-paper
```

This track signals a bad argument with -24, "invalid numeric argument", as the standard does.

## `abort"`

`abort" message"` takes a flag; when it is true, it throws -2 with the message attached, which gforth prints if nothing catches it.
The stubs in this track use it: `true abort" implement me"` always throws.

```forth
: check-age ( age -- age )
  dup 0< abort" negative age" ;
```

## `catch`

`catch ( i*x xt -- j*x 0 | i*x code )` runs the execution token `xt` as `execute` would.
If the word finishes normally, `catch` pushes 0 after whatever it left.
If it throws, `catch` puts the stacks back to the depth they had when `catch` started (without `xt`), and pushes the code.

```forth
6 ' halve-even catch   \ leaves 3 0
5 ' halve-even catch   \ leaves x 7
```

In the second line, the `x` is the cell that held the argument: the stack has its old _depth_ back, but the standard does not promise its old _contents_, because the word may have changed those cells before it threw.
The only safe thing to do with it is drop it.
When you still need an argument after a failure, keep a copy somewhere the failed word cannot touch, such as the return stack — `catch` puts the return stack back too, so `>r` before the `catch` and `r>` after it match up whichever way it ends.

A typical handler tests the code and either recovers or passes it on:

```forth
: halve-or-keep ( n -- n' )
  dup >r ['] halve-even catch
  if drop r> else r> drop then ;
```

To pass an unexpected code on, `throw` it again: the next `catch` up gets it.

## Cleaning up

`catch` is also how a word makes sure something happens even when the word it calls fails: catch, do the cleanup, then rethrow (or report) the code.

```forth
variable busy
: guard ( xt -- )
  true busy !  catch  false busy !  throw ;
```

## Pitfalls

- **Catching too much.** `catch` receives every code, including stack underflows and bugs; handle the codes you expect and rethrow the rest.
- **Using the restored items.** After a throw, the items below the code are placeholders. Drop them.
- **`throw` of 0 is not an error.** That is what makes `… throw` safe after a result code, and it also means 0 cannot be an error code.
