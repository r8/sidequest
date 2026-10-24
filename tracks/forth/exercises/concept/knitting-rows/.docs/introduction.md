# Introduction

## Counted loops

A _counted loop_ runs its body a known number of times.
In Forth it takes two numbers, a _limit_ and a _start_, and counts from the start up to (but not including) the limit:

```forth
: five-stars ( -- )
  5 0 do ." *" loop ;
```

`do ( limit start -- )` takes both numbers off the stack and begins the loop; `loop` adds one to the loop index and goes back to the start of the body until the index reaches the limit.
The limit comes _first_ (deeper), the start on top: `5 0 do` runs with the index 0, 1, 2, 3 and 4.

Like `if`, loops only work inside definitions.

## The loop index: `i`

Inside the body, `i` pushes the current index:

```forth
: count-to ( n -- )
  1+ 1 do i . loop ;

4 count-to   \ prints 1 2 3 4
```

To include the number itself in the count, the limit has to be one more than it: `1+ 1 do` counts from 1 to `n`.

## Accumulating

A loop that computes a result keeps a running total on the stack, below the loop's own bookkeeping.
Push the starting value before the loop, and let each pass update it:

```forth
: sum-of-squares ( n -- sum )
  0 swap 0 ?do i dup * + loop ;
```

Before `?do` the stack is `0 n 0`: the total, the limit and the start.
`?do` takes the limit and the start, leaving the total; every pass adds `i²` to it.

## `?do` and empty loops

`do` always runs its body at least once, even when the start already equals the limit: `0 0 do … loop` runs (almost) forever, because the index walks all the way round the numbers before it meets the limit again.
`?do` checks first and skips the loop entirely when the start equals the limit.
Use `?do` whenever the count can be zero.

## Other steps: `+loop`

`n +loop` adds `n` to the index instead of 1:

```forth
: evens ( -- )
  10 0 ?do i . 2 +loop ;   \ prints 0 2 4 6 8
```

With a negative step the loop counts down, and then the limit _is_ included: it stops only when the index moves past the limit.

```forth
: countdown ( -- )
  0 10 do i . -1 +loop ;   \ prints 10 9 8 … 1 0
```

A loop counting down to 1 therefore uses 1 as its limit.

## Nested loops: `j`

Loops can be nested.
`i` always means the innermost loop's index; `j` is the index of the loop around it:

```forth
: table ( -- )
  4 1 do
    4 1 do  i j * .  loop  cr
  loop ;
```

## Leaving early

`leave` ends the loop at once and continues after `loop`.
To leave the whole _word_ from inside a loop, the loop's bookkeeping must be thrown away first with `unloop`, then `exit`:

```forth
: first-multiple ( n -- m )   \ the first multiple of n above 100, up to 1000
  1000 101 do
    i over mod 0= if drop i unloop exit then
  loop drop 0 ;
```

`i` must be read before `unloop`, since afterwards the loop no longer exists.

## Pitfalls

- **Argument order.** `limit start do`: `10 1 do` counts 1 to 9, `1 10 do` is a bug.
- **The limit is excluded** when counting up. Add one to include it.
- **`do` with no work.** Use `?do` when the count can be zero.
- **Keep the stack balanced inside the body.** Each pass must leave the stack as the next pass expects it: a pass that leaves an extra item builds up a pile.
- **`exit` inside a loop** needs `unloop` first, once for each loop it leaves.
