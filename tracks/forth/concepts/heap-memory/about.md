# About

## Dictionary or heap

| | Dictionary (`create`, `allot`, `here`) | Heap (`allocate`) |
| --- | --- | --- |
| size | fixed when the code is loaded (or grows only at the end) | chosen at run time, changeable with `resize` |
| lifetime | until `marker`/`forget` or the end of the program | until `free` |
| typical use | tables, fixed buffers, variables | strings and arrays of unknown size, data structures that grow |

gforth's `allocate` is the C library's `malloc`, so `free` on an address it did not return (or freeing twice) is undefined behaviour that can crash the system instead of returning an ior.

## Ownership conventions

There are three ways a word can return a string or an array:

1. **Into a buffer the caller provides**: `( c-addr u buf -- buf u2 )`. Nothing to free; the caller decides the size.
2. **In a buffer the word owns**, valid until the next call. Nothing to free, but results cannot be kept side by side without copying.
3. **In newly allocated memory that the caller frees.** Each result is independent; every caller must remember `free`.

Whichever a word uses, its comment should say so.
Pairing each `allocate` with its `free` in the same word, or documenting the hand-over, is the way to avoid leaks.

## Handling the ior

- `throw` turns a non-zero ior into an exception, which `catch` can intercept (see the exceptions concept).
- To free memory while unwinding from an error, catch the error, free, and re-throw.

## Growing a buffer

The usual pattern for data of unknown size is to start small and double the capacity when it fills:

```forth
\ buf capacity used: double the capacity when used reaches it
: ensure ( buf cap used -- buf' cap' )
  over = if  2* tuck cells resize throw swap  then ;
```

Doubling keeps the total cost of all copies linear in the final size.
