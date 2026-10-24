# Introduction

A Forth string is two cells: the address of its first character and its length, written `( c-addr u )`.
`s" text"` pushes the pair for literal text and `type` prints it.

```forth
s" sidequest" 4 /string type   \ quest: /string drops characters from the front
s" sidequest" drop 4 type      \ side:  a shorter length drops the end
```

`c@` fetches the character at an address, `i chars +` reaches index `i`, and `bounds ?do i c@ … loop` walks every character.
`compare` leaves 0 for equal strings (so equality is `compare 0=`), and `-trailing` drops trailing spaces.
Substrings share the original's memory: nothing is copied.
