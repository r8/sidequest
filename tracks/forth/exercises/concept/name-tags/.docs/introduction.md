# Introduction

Forth has no string type.
A string is two cells on the stack: the _address_ of its first character in memory, and its _length_.
The stack effect writes this pair as `( c-addr u )`, and almost every word that works on text takes or leaves one.

## String literals

`s" …"` gives the pair for a piece of literal text:

```forth
: greeting ( -- c-addr u )
  s" Hello" ;

greeting . .   \ prints 5, then an address
greeting type  \ prints Hello
```

Mind the space after `s"`: it is a word, and the text starts after that space and runs to the next `"`.
`type ( c-addr u -- )` prints a string.
Inside a definition, the text is stored with the definition; at the interpreter, gforth keeps it in a temporary buffer.
Treat literal strings as read-only.

## Addresses and characters

An address is a number, too: it says where a byte sits in memory.
`c@ ( c-addr -- c )` fetches the character stored at an address.
The characters of a string sit one after another, so the character at index `i` (counting from 0) is at the address plus `i chars`.
`chars` turns a count of characters into a count of bytes; in gforth it changes nothing, but it says what you mean:

```forth
: third-char ( c-addr u -- c )
  drop 2 chars + c@ ;

s" Forth" third-char emit   \ prints r
```

## Walking through a string

`bounds ( c-addr u -- c-addr+u c-addr )` turns a string into the end and start addresses that a counted loop wants, and inside the loop `i` is the address of the current character:

```forth
: digits ( c-addr u -- n )   \ how many characters are digits
  0 -rot bounds ?do
    i c@ [char] 0 [char] 9 1+ within if 1+ then
  loop ;

s" R2-D2" digits .   \ prints 2
```

Use `?do`, not `do`: an empty string gives equal bounds, and `?do` then skips the loop.

## Substrings for free

A substring needs no copying: any address inside the string and a smaller length describe part of it.
`/string ( c-addr u n -- c-addr+n u-n )` drops the first `n` characters, and keeping the address while lowering the length drops the end:

```forth
s" sidequest" 4 /string type   \ prints quest
s" sidequest" drop 4 type      \ prints side
```

`-trailing ( c-addr u -- c-addr u2 )` shortens the length to drop trailing spaces.
None of these change the text; they only describe a different part of it, so the result is valid as long as the original is.

## Comparing strings

`=` compares two cells, so it would compare addresses, not text.
`compare ( c-addr1 u1 c-addr2 u2 -- n )` compares the characters: it leaves 0 when the strings are equal, -1 when the first sorts before the second and 1 when it sorts after.

```forth
s" apple" s" apple" compare .   \ prints 0
s" apple" s" berry" compare .   \ prints -1
```

Because equal strings give 0, the flag for "equal" is `compare 0=`.
The comparison is by character code, so it is case-sensitive: `A` (65) sorts before `a` (97).

## Pitfalls

- **Two cells, not one.** Use `2dup`, `2drop` and `2swap` to move a string as a whole; `dup` copies only the length.
- **The length is on top.** `( c-addr u )` means the address is below; `drop` leaves the address and `nip` the length.
- **Empty strings.** A length of 0 is a perfectly good string; its address must not be read from.
- **Never step past the end.** `/string` with more than the length gives a negative length, which every later word will misread.
