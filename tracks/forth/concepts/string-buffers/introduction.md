# Introduction

A word that makes new text has to write it into memory, and in this track that memory belongs to the solution:
the word leaves `( c-addr u )` pointing into a buffer of its own, and the result is valid until the next call of that word.

```forth
40 constant capacity
create note 0 , capacity chars allot          \ a length, then the characters
: note-text ( -- c-addr u )  note cell+ note @ ;
: note-end ( -- c-addr )     note-text chars + ;
: +note ( c-addr u -- )                       \ append as much as fits
  capacity note @ - min  note-end swap  dup note +!  move ;
```

A word resets the length to 0, appends its pieces with `move` (source, destination, count) or `c!`, and leaves the buffer's text.
Clamp every copy to the room left, and give each word its own buffer so results of different words can be used together.
