# Introduction

Memory is a row of bytes with numbered addresses, and Forth reads and writes it directly:
`@ ( addr -- x )` and `! ( x addr -- )` for cells, `c@` and `c!` for bytes, `+!` to add to a cell.
`cells` converts a count of cells to bytes and `cell+` steps to the next cell.

The dictionary grows at `here`: `allot ( n -- )` reserves `n` bytes, `,` stores a cell and `c,` a byte.
`create name` makes a word that pushes the address of whatever is laid down after it.

```forth
create origin  0 , 0 ,          \ an initialised two-cell record
: y-of ( point -- addr ) cell+ ;
7 origin y-of !   origin y-of @ .   \ 7
: new-counter ( start -- counter ) here swap , ;
```

Memory from `allot` is not cleared; `erase` and `fill` set it.
