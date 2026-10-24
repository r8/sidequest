# Introduction

## `if … then`

A conditional takes a flag from the stack and runs some words only when it is true:

```forth
: warn-if-hot ( celsius -- celsius )
  dup 90 > if ." careful! " then ;
```

(`." careful! "` prints the text up to the closing quote.)
`if` consumes the flag.
When it is non-zero, the words between `if` and `then` run; when it is zero, they are skipped and execution continues after `then`.
(`then` marks where the paths join again, not "what happens next": read it as "endif".)

Because `if` consumes its flag, the usual pattern is to `dup` the number before comparing it, so the number is still there afterwards, as `warn-if-hot` does.

## `if … else … then`

`else` adds the words to run when the flag is false:

```forth
: parity ( n -- 0|1 )
  2 mod 0= if 0 else 1 then ;
```

Both branches should leave the stack in the same shape.
If one branch leaves a number and the other does not, whatever runs next gets a different stack depending on the data, which is a bug that tests only catch on some inputs.
Comment the stack at `if` and at `then` to check it.

Conditionals can only be used inside a definition, not typed at the top level of a file.

## Nesting

A branch can contain another conditional.
Each `if` is matched with the nearest following `then`, like brackets:

```forth
: sign-of ( n -- -1|0|1 )
  dup 0< if
    drop -1
  else
    0> if 1 else 0 then
  then ;
```

Indent nested conditionals so the matching is visible.

## Leaving early with `exit`

`exit` leaves the current word at once.
Inside a conditional it gives "guard clauses": handle a special case first and stop, so the rest of the word deals only with the ordinary case.

```forth
: postage ( grams -- pence )
  dup 0= if exit then     \ nothing to send costs nothing
  dup 100 > if drop 300 exit then
  drop 150 ;
```

Each path through the word must still leave the same stack effect: here every path leaves exactly one number.
That style often replaces deep nesting.

## `?dup`

`?dup ( n -- n n | 0 )` duplicates its argument only when it is not zero.
It fits right before `if`: when the number is non-zero, `if` consumes the copy and the original is there to use; when it is zero, `if` consumes the only copy and nothing is left.

```forth
: show-count ( n -- )
  ?dup if . ." items" then ;
```

## Branches without `if`

Some decisions are not branches at all.
`max` and `min` already pick between two numbers, and a flag can be used as a number.
When an `if` only chooses between two values to compute, see whether one of those words says it more directly.

## Pitfalls

- **The flag is consumed.** `n 10 > if …` leaves no `n` for the branch; `dup` first if you need it.
- **Unbalanced branches.** If the `if` branch drops a number and the `else` branch does not, the word's stack effect depends on its input. Make both branches agree.
- **Missing `then`.** Every `if` needs a `then`. gforth reports a forgotten one as "unstructured" when it reaches `;`.
- **`exit` and the stack.** `exit` does not tidy the stack for you: drop whatever the early path should not leave behind before you exit.
