# Introduction

## Choosing among many values

When a word must do something different for each of several values, nested `if`s pile up quickly:

```forth
: grade ( n -- points )
  dup 1 = if drop 10 else
  dup 2 = if drop 6 else
  dup 3 = if drop 3 else
  drop 0 then then then ;
```

Forth has a dedicated structure for this, `case`.

## `case … of … endof … endcase`

```forth
: grade ( n -- points )
  case
    1 of 10 endof
    2 of  6 endof
    3 of  3 endof
    0 swap
  endcase ;
```

`case` starts the structure; the value to examine, the _selector_, is on top of the stack.
Each `of` compares the selector with the number pushed just before it.
When they are equal, `of` drops both, runs the words up to `endof`, and then jumps to after `endcase`.
When they differ, `of` drops only the test value, keeps the selector, and moves on to the next `of`.

So inside a matching branch the selector is gone, and the branch leaves whatever it computes: `1 of 10 endof` replaces 1 with 10.

## The default branch

Words after the last `endof` and before `endcase` are the _default_: they run when no `of` matched.
In the default branch, the selector is still on the stack, and `endcase` drops it.

That is the one trap of `case`.
A default branch that simply pushes a result would have that result dropped by `endcase`, and leave the selector instead.
The default has to put its result _under_ the selector, so that `endcase` drops the selector and the result remains:

```forth
    0 swap      \ selector -- 0 selector; endcase drops the selector
```

A default that computes from the selector does the same with a copy:

```forth
: next-floor ( floor -- floor' )
  case
    13 of 14 endof        \ there is no thirteenth floor
    dup 1+ swap           \ floor+1 floor; endcase drops floor
  endcase ;
```

With no default at all, `endcase` drops an unmatched selector and the `case` leaves nothing; that only suits words that leave nothing in any branch.

## Several values, one result

Each `of` tests one value.
When several values share a result, give each its own `of` with the same branch:

```forth
: weekend? ( day -- flag )
  case
    6 of true endof
    7 of true endof
    false swap
  endcase ;
```

`case` only tests equality.
For ranges ("from 3 to 5"), use comparisons and `if`, or compute the answer arithmetically.

## Branches with more on the stack

The selector is on top, but other items can be below it.
A branch can use them, and every branch must leave the same stack effect, so a branch that does not need an item below has to drop it:

```forth
: price ( member? item -- pence )
  case
    1 of if 80 else 100 then endof   \ members pay less for item 1
    2 of drop 50 endof               \ item 2 has one price
    nip 0 swap                       \ unknown item: free, flag dropped
  endcase ;
```

## Pitfalls

- **The default's result is dropped.** Push the result under the selector (`… swap`), never on top of it.
- **Every branch, one stack effect.** Like `if … else … then`, each `of` branch and the default must leave the same number of items.
- **`of` compares with the value pushed right before it.** `1 of` is "is the selector 1?", not "is it greater than 1".
- **`case` is compile-only**, like `if`: use it inside definitions.
