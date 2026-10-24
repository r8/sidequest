# Introduction

## Memory that comes and goes

`create` and `allot` take memory from the dictionary, and it stays there for as long as the program runs.
That suits buffers with a fixed size, but not data whose size is known only at run time, or that should be given back when it is no longer needed.
For those, Forth has the _heap_: memory you ask for, use, and return.

| Word | Stack effect | |
| --- | --- | --- |
| `allocate` | `( u -- addr ior )` | reserve `u` address units |
| `free` | `( addr -- ior )` | give back memory from `allocate` or `resize` |
| `resize` | `( addr u -- addr2 ior )` | change its size to `u`, keeping the contents |

Sizes are in address units, so use `chars` and `cells` as you would with `allot`: `10 cells allocate` reserves room for ten cells.
The new memory is not cleared; `erase ( addr u -- )` sets it to zeros when that matters.

## The ior

Each of these words leaves an _I/O result_, or _ior_: 0 when it worked, and a non-zero error code when it did not (out of memory, or an address that was never allocated).
Code that does not want to deal with failure on the spot passes the ior to `throw`:

```forth
100 chars allocate throw   ( addr )
```

`throw` does nothing with 0, and with any other number it stops the program with that error, the same way `abort"` does.
The exceptions lesson shows how to catch such errors; for now, `allocate throw` simply means "allocate, or fail loudly".

## Using heap memory

```forth
: numbers ( n -- addr )
  dup cells allocate throw      \ n addr
  tuck swap cells erase ;       \ addr, with n zeroed cells

5 numbers   ( addr )
42 over 3 cells + !            \ use it like any other memory
free throw                     \ and give it back
```

`resize` may have to move the data to make room, so it returns a new address; the old one must not be used again:

```forth
( addr ) 10 cells resize throw   ( addr2 )
```

When it grows the block, the old contents are kept at the start and the rest is not cleared.

## Who frees it?

A word that returns heap memory hands over a responsibility along with the address: someone must eventually `free` it, exactly once.
That is a different convention from a buffer the word owns itself, which the caller only borrows until the next call.
Say which one a word uses in its comment:

```forth
\ Returns a copy of the string in allocated memory; the caller frees it.
: clone ( c-addr u -- c-addr2 u )
```

The caller then writes `drop free throw` on the string (`free` wants only the address) when it is done with it.
Because each call returns new memory, two results of the same word can be kept side by side, which an owned buffer does not allow.

## Pitfalls

- **Leaks.** Memory that is never freed stays reserved until the program ends.
- **Using memory after `free`**, or the old address after `resize`, reads whatever has since been put there.
- **Freeing twice, or freeing an address that `allocate` did not return** (a `create`d buffer, a string literal), is an error and can crash gforth.
- **Forgetting the units.** `10 allocate` reserves ten bytes, not ten cells.
- **Dropping the ior** instead of checking it hides an out-of-memory failure until much later.
