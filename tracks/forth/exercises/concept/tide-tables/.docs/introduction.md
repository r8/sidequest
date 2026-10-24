# Introduction

An array in Forth is nothing more than cells laid down next to each other in memory.
There is no array type and no stored length: you hand an array around as its address and the number of elements, `( addr n )`, just as a string is an address and a length.

## Making an array

To reserve room for an array, `create` a name and `allot` the cells:

```forth
create scores 10 cells allot   \ ten cells, not initialised
scores 10 cells erase          \ now all zero
```

To make one with known contents, lay the elements down with `,`:

```forth
create primes 2 , 3 , 5 , 7 , 11 ,
```

`primes` pushes the address of the first element; the `5` stored with it is up to you to remember, often as a constant:

```forth
5 constant #primes
primes #primes   \ the array as ( addr n )
```

## Elements

Element `i` (counting from 0) sits `i` cells after the start:

```forth
: element ( addr i -- addr' )
  cells + ;

primes 2 element @ .   \ prints 5
99 scores 0 element !  \ the first score is now 99
```

Nothing checks that `i` is less than the length: reading past the end gives whatever happens to follow, and writing past it overwrites it.

## Visiting every element

There are two ways to loop over an array.
By index, when you need to know the position:

```forth
: .all ( addr n -- )
  0 ?do  dup i cells + @ .  loop drop ;
```

Or by address, which is shorter when the position does not matter.
`cells bounds` gives the address just past the end and the first address, and `cell +loop` steps one cell at a time; inside, `i` is the address of the current element:

```forth
: count-odd ( addr n -- count )
  0 -rot cells bounds ?do  i @ 1 and +  loop ;
```

Both use `?do`, so an empty array — `n` of 0 — runs the loop zero times.

## Changing elements in place

`!` and `+!` work on any address, so an array can be updated where it is, without making a new one:

```forth
: zero-negatives ( addr n -- )
  cells bounds ?do  i @ 0< if 0 i ! then  cell +loop ;
```

A word that changes the array it was given has a stack effect that leaves nothing: the caller still has the address.

## Finding an element

A search usually stops as soon as it finds what it is looking for.
`unloop exit` leaves the definition from inside a counted loop (`unloop` drops the loop's bookkeeping first):

```forth
: contains? ( addr n x -- flag )
  -rot cells bounds ?do
    dup i @ = if drop true unloop exit then
  cell +loop drop false ;
```

When the answer is a position rather than a flag, loop over indices instead, and agree on a value such as -1 that means "not found".

## Pitfalls

- **Index versus address.** In a `cells bounds ?do` loop, `i` is an address; in a `0 ?do` loop it is an index. Mixing them up reads nonsense.
- **The step of `+loop`.** Stepping over cells needs `cell +loop`; a plain `loop` would visit every byte.
- **Empty arrays.** `create empty` with nothing after it is a perfectly good array of length 0; make sure every word handles `n` = 0 where it makes sense.
- **Off by one.** The last element of an array of `n` is element `n 1-`.
