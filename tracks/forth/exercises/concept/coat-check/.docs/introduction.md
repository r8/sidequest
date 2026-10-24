# Introduction

## A second stack

Forth has two stacks.
The data stack holds arguments and results.
The _return stack_ is where Forth itself keeps track of which word to go back to when the current word finishes: every time a word calls another word, the place to come back to is pushed there, and `;` pops it.

You can borrow the return stack for a while to park a value out of the way.
That is often simpler than digging it out from under three other items with `rot` and `pick`.

## Moving values across

| Word  | Data stack     | Return stack   |
| ----- | -------------- | -------------- |
| `>r`  | `( x -- )`     | `( -- x )`     |
| `r>`  | `( -- x )`     | `( x -- )`     |
| `r@`  | `( -- x )`     | `( x -- x )`   |
| `rdrop` |              | `( x -- )`     |
| `2>r` | `( x1 x2 -- )` | `( -- x1 x2 )` |
| `2r>` | `( -- x1 x2 )` | `( x1 x2 -- )` |
| `2r@` | `( -- x1 x2 )` | `( x1 x2 -- x1 x2 )` |

`>r` ("to R") moves the top of the data stack to the return stack; `r>` ("R from") moves it back; `r@` copies it without removing it.
The `2` versions move a pair, keeping its order.

## Parking a value

To work on the items under the top, park the top, do the work, and bring it back:

```forth
: add-under ( a b n -- a+n b )
  swap >r + r> ;
```

`swap` brings `b` up, `>r` parks it, `+` adds `n` to `a`, and `r>` puts `b` back on top.

`r@` is for a value needed several times:

```forth
: scale3 ( a b c n -- a*n b*n c*n )
  >r  r@ *  rot r@ *  rot r> *  rot ;
```

## The rules

Because the return stack is also where the word's own way home is kept, borrowing it comes with rules:

1. **Give back what you take, in the same word.** Every `>r` needs a matching `r>` (or `rdrop`) before the word ends. If a word leaves an extra value there, `;` "returns" to that value instead of the caller, and the program crashes.
2. **Balance it on every path.** A value parked before an `if` must be taken back on both branches; one parked before `exit` must be removed before it.
3. **Not across loop boundaries.** `do` keeps the loop's limit and index on the return stack. A value parked before `do` is underneath them, so `r@` inside the loop does not see it, and `r>` inside the loop would take the loop's own data. Inside a loop body, `>r` and `r>` are fine as long as they balance within one pass.
4. **Not at the top level.** The return stack is only safe to use inside a definition.

## When to use it

- Three or more items in play and one of them is needed only at the end: park it.
- A value used repeatedly in a calculation: park it and `r@` it.
- A pair to set aside: `2>r … 2r>`.

The return stack is no substitute for designing good stack effects: if a word needs it twice to get anything done, it probably wants splitting into smaller words.

## Pitfalls

- **Forgotten `r>`** crashes the program at `;`, often with an "invalid memory address" error rather than a clear message.
- **`r@` inside a `do` loop** reads the loop's bookkeeping, not your value. (In gforth it gives the same as `i`.)
- **Order of pairs.** `2>r` and `2r>` keep a pair in order: `1 2 2>r 2r>` leaves `1 2`. Separate `>r`s come back last-parked first: after `1 2 >r >r`, the first `r>` gives back the 1.
