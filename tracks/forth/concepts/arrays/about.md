# About

## The convention

Forth has no array type; an array is a region of memory plus a length that travels with it.
Passing `( addr n )` keeps words general: the same word works on a whole array, on part of one (`addr k cells + n k -`), or on an array laid down by `create`, `allot` or `allocate`.
This track's tests compare arrays with `assert-cells= ( addr1 n1 addr2 n2 -- )`.

Some code stores the length in the first cell instead (a _counted_ array, like a counted string): `create evens 3 , 2 , 4 , 6 ,` and `: items ( a -- addr n ) dup cell+ swap @ ;`.
That suits arrays whose length changes, such as a buffer that is filled up over time.

## Element access

- Element address: `addr i cells +`. It is worth a word of its own, such as `: th ( addr i -- addr' ) cells + ;` (newer gforths define `th`; 0.7.3 does not).
- Byte arrays use `chars` (or nothing) and `c@`/`c!`.
- Two dimensions: store row after row and compute `row width * col + cells +`.

## Loops

```forth
: sum ( addr n -- total )   0 -rot cells bounds ?do i @ + cell +loop ;
: .each ( addr n -- )       0 ?do dup i cells + @ . loop drop ;
```

Address loops are shorter and avoid recomputing addresses; index loops are needed when the position matters.
Going backwards over addresses uses a negative step: `… -1 cells +loop`, with `do` rather than `?do` when the limits are equal for one element, as the loop runs down to and including the limit.

## Sizes

Name sizes with constants (`20 constant max-readings`), and reserve with `create readings max-readings cells allot`.
A word that fills an array the caller provides should take its capacity and refuse (or stop) at it; a word that returns a fresh array in a buffer it owns documents how long it stays valid.

## No bounds checking

Reading past the end returns whatever follows in memory; writing past it silently corrupts the next definition.
Validate indices that come from outside, for example with `0 n within`.
