# Introduction

A structure names the fields of a record and works out their offsets and the record's size:

```forth
begin-structure book
  field:  book-year     \ a cell
  field:  book-pages    \ a cell
  cfield: book-shelf    \ a character
end-structure
```

`book ( -- u )` is the size of a record, and each field word `( addr -- addr' )` adds its offset to a record's address; read and write the field with `@ !` or `c@ c!`:

```forth
create moby-dick  book allot
1851 moby-dick book-year !
moby-dick book-year @ .
```

`2field:` and `ffield:` hold doubles and floats, and `n +field name` reserves `n` address units.
An array of records is `n book * allot`, with the `i`-th record at `i book * +`.
