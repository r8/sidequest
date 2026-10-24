# Introduction

So far, numbers have lived on the stack and in variables.
Behind a variable is something more general: memory, a long row of bytes, each with a numbered _address_.
Forth lets you reserve memory, compute addresses and read and write any of them directly.

## Cells and addresses

`variable balance` reserved one cell of memory and made `balance` a word that pushes its address.
`@ ( addr -- x )` and `! ( x addr -- )` work on _any_ address, not just a variable's.
A cell is several bytes (8 in gforth on a 64-bit machine), so neighbouring cells are several addresses apart.
`cells ( n -- n*size )` converts a number of cells to bytes, and `cell+ ( addr -- addr' )` steps to the next cell:

```forth
variable point  1 cells allot   \ two cells: x, then y
3 point !                       \ x
4 point cell+ !                 \ y
point cell+ @ .                 \ prints 4
point 1 cells + @ .             \ the same thing
```

`+! ( n addr -- )` adds to the cell at an address, as it did for variables.

## The dictionary and here

Definitions, variables and everything else Forth creates are laid down one after another in the _dictionary_.
`here ( -- addr )` is the address of the next free byte.
Two words extend the dictionary:

- `allot ( n -- )` reserves `n` bytes at `here` and moves `here` past them;
- `, ( x -- )` ("comma") stores a cell at `here` and moves past it. `c, ( c -- )` does the same for one byte.

`create name` adds a word whose only job is to push the address that was `here` when it was created; whatever you `allot` or `,` next belongs to it.

```forth
create origin  0 , 0 ,          \ an initialised two-cell record
create scratch  16 cells allot  \ sixteen cells, not initialised
```

`allot` does not clear the memory it reserves.
`erase ( addr u -- )` sets `u` bytes to zero, and `fill ( addr u c -- )` sets them to a byte value: `scratch 16 cells erase`.

## Building at run time

`here` and `,` are ordinary words, so a definition can use them to lay down new memory each time it runs.
The address it hands back is a _handle_ to the new piece of memory:

```forth
: new-counter ( start -- counter )
  here swap , ;

5 new-counter  dup @ .   \ prints 5
1 over +!  @ .           \ prints 6
```

Each call reserves one more cell, and the cells stay reserved: dictionary memory is not given back.

## Records

Memory that holds several related values is a _record_.
A good habit is to give each field a word that turns the record's address into the field's address; then reading and writing a field both go through the same word:

```forth
: y-of ( point -- addr ) cell+ ;

7 origin y-of !
origin y-of @ .   \ prints 7
```

## Bytes

`c@ ( c-addr -- c )` and `c! ( c c-addr -- )` read and write a single byte (a character), as you have used `c@` on strings.
`chars` converts a number of characters to bytes the way `cells` does for cells.
When bytes and cells share one region, `align` (or `aligned` on an address) rounds up to a cell boundary before the next `,`.

## Pitfalls

- **`!` takes the value first and the address on top**, as in `3 point !`.
- **Counting in bytes.** `point 1 +` is the second _byte_ of the first cell, not the second cell; use `cell+` or `cells +`.
- **Forgetting to initialise.** Memory from `allot` holds whatever was there; set every field before you read it.
- **Writing past the end.** Nothing stops `!` from overwriting the next word's memory. Keep track of how much you reserved.
