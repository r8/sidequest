# Introduction

The Name Tags lesson only ever handed back parts of the strings it was given.
A word that makes _new_ text — an upper-case copy, two strings joined together — has nowhere on the stack to put it: the stack holds cells, and a string is an address and a length.
The characters have to be written somewhere in memory, and somebody has to own that memory.

## Who owns the result

There are two common answers in Forth:

1. **The caller provides the buffer.** The word takes the address and size of memory to write into, as gforth's own `place` does.
2. **The word owns the buffer.** The word writes into memory it reserved for itself and leaves `( c-addr u )` pointing there.

This track uses the second: a word that returns a string leaves it in a buffer that belongs to the solution, and the result is _valid until the next call_ of that word.
The caller uses the result straight away — prints it, compares it, or copies it somewhere safe — before calling the word again.
This is how `s"` at the interpreter and gforth's number formatting behave, too.

## A buffer of your own

A buffer is memory reserved with `create` and `allot`, plus a record of how much of it is in use.
Keeping the length in the first cell, and the characters after it, keeps the two together:

```forth
40 constant capacity
create note 0 , capacity chars allot   \ a length, then room for the text

: note-text ( -- c-addr u )  note cell+  note @ ;
```

`note-text` is now a string like any other: it can be typed, compared or sliced.

## Copying characters

`move ( from to u -- )` copies `u` bytes from one address to another.
To put a string into the buffer, copy its characters and record its length:

```forth
: note! ( c-addr u -- )
  capacity min  dup note !  note cell+ swap move ;

s" Gone fishing" note!  note-text type   \ prints Gone fishing
```

`capacity min` makes sure nothing is written past the end of the buffer: a longer string is cut short instead.
Forth will not stop you from writing past the end, and what lies beyond is usually the next definition.

## Appending

Building a result piece by piece is appending: copy the new characters to the end of what is already there, and add to the length.
The end is the start of the text plus the length so far:

```forth
: note-end ( -- c-addr )  note cell+  note @ chars + ;
: room ( -- u )  capacity note @ - ;

: +note ( c-addr u -- )
  room min  note-end swap  dup note +!  move ;

s" Gone" note!  s"  fishing" +note  note-text type   \ prints Gone fishing
```

A single character can be appended by storing it with `c!` at the end and adding one to the length — after checking there is room.
A word that builds a result starts by setting the length to 0, appends the pieces, and finishes with the `( c-addr u )` of the buffer:

```forth
: exclaimed ( c-addr u -- c-addr2 u2 )
  0 note !  +note  s" !" +note  note-text ;
```

## One buffer per word

If two words share a buffer, the second one's result overwrites the first.
Give each word that returns a string its own buffer, and the caller can use the results of different words together — including passing one word's result to another.

Passing a word its _own_ previous result is different: it would read the text it is overwriting.
That is the meaning of "valid until the next call".

## Pitfalls

- **Forgetting to reset the length**, so each call appends to the previous result.
- **Writing past the end.** Clamp every copy with `min` against the room that is left.
- **The order of `move`'s arguments**: source first, then destination, then the count.
- **Keeping a result too long.** A result stored away and read after the next call has changed under you; copy it if you need to keep it.
