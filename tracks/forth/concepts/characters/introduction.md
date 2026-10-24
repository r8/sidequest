# Introduction

A character in Forth is just a number: its ASCII code.
`char A` pushes 65 outside a definition; inside one, write `[char] A`, which reads the character when the definition is compiled.
`emit ( c -- )` prints a character and `bl` is the code of a space.

Because the letters and digits each form one unbroken run of codes, ordinary arithmetic and comparisons do the work:

```forth
: digit? ( c -- flag )      [char] 0 [char] 9 1+ within ;
: digit-value ( c -- n )    [char] 0 - ;
```

Upper- and lower-case letters are 32 apart (`[char] a [char] A -`); convert only after checking the character is a letter.
