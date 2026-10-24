# Introduction

A counted loop knows in advance how many times it will run.
Often the number of passes is only known once the loop is running: keep halving until a number is small enough, keep reading until there is nothing left.
Forth's _indefinite loops_ start with `begin` and keep going until a flag tells them to stop.

## `begin … until`

`until ( flag -- )` ends the loop when its flag is true, and goes back to `begin` when it is false:

```forth
: countdown ( n -- )
  begin  dup .  1-  dup 0= until  drop ;

3 countdown   \ prints 3 2 1
```

The body always runs at least once, because the test comes at the end.
`until` consumes its flag, so the usual pattern is the same as with `if`: `dup` the number before testing it.

## `begin … while … repeat`

When the loop may need to run zero times, test at the start.
`while ( flag -- )` continues with the words after it when the flag is true, and leaves the loop, continuing after `repeat`, when it is false.
`repeat` jumps back to `begin`.

```forth
: halve-below ( n limit -- n' )   \ halve n until it is below limit
  begin  2dup >=  while  swap 2/ swap  repeat  drop ;

40 10 halve-below .   \ prints 5
8 10 halve-below .    \ prints 8: the body never runs
```

The words between `begin` and `while` run on every pass, including the last one that fails the test; the words between `while` and `repeat` run only while the test passes.

## `begin … again`

`again` jumps back to `begin` unconditionally: the loop never ends by itself.
It is useful together with `exit`, when the natural place to stop is in the middle of a longer body:

```forth
: first-power-above ( n -- p )   \ the first power of 2 above n
  1 begin
    2dup < if nip exit then
    2*
  again ;
```

Since `exit` leaves the whole word, everything the word should not return has to be dropped first; here `nip` gets rid of `n`.
(Unlike a counted loop, an indefinite loop keeps nothing on the return stack, so `exit` needs no `unloop`.)

## Keeping state

An indefinite loop has no index like `i`.
Whatever it needs to remember between passes — a counter, a running total, the current value — lives on the data stack, and every pass must leave the stack in the shape the next pass expects.
A counter is usually pushed below the value the loop works on:

```forth
: doublings ( n limit -- count )   \ how many times n doubles before reaching limit
  0 -rot                \ count n limit
  begin  2dup <  while
    swap 2* swap  rot 1+ -rot
  repeat 2drop ;
```

Write the stack shape at `begin` as a comment, and check that the body restores it.

## Choosing a loop

- Known number of passes: `do … loop` or `?do … loop`.
- At least one pass, test at the end: `begin … until`.
- Possibly no passes, test at the start: `begin … while … repeat`.
- Stop somewhere in the middle: `begin … again` with `exit`, or `while` placed in the middle of the body.

## Pitfalls

- **Loops that never end.** If the body never changes what the test looks at, the loop runs forever; the tests in this track stop after a time limit and report an error.
- **The flag is consumed** by `until` and `while`. `dup` (or `2dup`) the values the test needs if the body needs them too.
- **Unbalanced passes.** A pass that leaves one more item than it found grows the stack every time round; one that takes one too many soon underflows.
- **`exit` from `again`** must leave exactly the word's results, like any other exit.
