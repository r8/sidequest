# Introduction

## Records by hand

A record is a block of memory holding several related values: a point's `x` and `y`, a book's year and page count.
With what you know already you can lay one out by hand, giving each value an offset from the start:

```forth
: book-year  ( book -- addr )  ;
: book-pages ( book -- addr )  cell+ ;
create my-book  2 cells allot
1851 my-book book-year !   635 my-book book-pages !
```

That works, but every offset is counted by hand, and adding a field in the middle means renumbering all those after it.

## Structures

A _structure_ declares the fields and lets Forth work out the offsets and the total size:

```forth
begin-structure book
  field:  book-year
  field:  book-pages
  cfield: book-shelf
end-structure
```

This defines four words:

- `book ( -- u )`, the size of one record in address units, for `allot` and `allocate`;
- `book-year`, `book-pages` and `book-shelf`, each `( addr -- addr' )`: given the address of a record, the address of that field inside it.

A field word only adds its offset, so you still read and write with the usual words, `@ !` for cells and `c@ c!` for characters:

```forth
create moby-dick  book allot
1851 moby-dick book-year !
635 moby-dick book-pages !
[char] M moby-dick book-shelf c!

moby-dick book-pages @ .   \ prints 635
```

The field kinds are:

| Word | Holds | Read and write with |
| --- | --- | --- |
| `field:` | one cell | `@ ! +!` |
| `cfield:` | one character | `c@ c!` |
| `2field:` | a double | `2@ 2!` |
| `ffield:` | a float | `f@ f!` |
| `n +field name` | `n` address units of anything | whatever fits, often `move` |

`+field` reserves an arbitrary amount, such as room for a short name: `20 chars +field book-title`.
`field:` aligns its cell for you, so a cell after a character still sits at a cell boundary.

## Arrays of records

Records of the same structure can sit side by side, like the cells of an array.
The `i`-th record starts `i` record sizes after the first:

```forth
create shelf  10 book * allot
: shelf-book ( i -- addr )  book * shelf + ;

1851 3 shelf-book book-year !
```

Looping over them works as with cells, stepping by the record size instead of one cell.

## Names

Prefixing each field with the structure's name (`book-year`, not `year`) keeps fields of different structures apart, because all words share one dictionary.
A field word takes the record's address, so it reads naturally after it: `moby-dick book-pages @`.

## Pitfalls

- **The wrong fetch.** `@` on a `cfield:` reads a whole cell and picks up the neighbouring bytes; use `c@` for characters.
- **Forgetting the field.** `moby-dick @` reads the first field, whichever that is, and only by coincidence the one you meant.
- **The size, not a count.** `book allot` reserves one record; ten records are `10 book * allot`.
- **Uninitialised memory.** `allot` and `allocate` do not clear the record; set every field, or `erase` it first.
