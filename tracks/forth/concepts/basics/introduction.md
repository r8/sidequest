# Introduction

A Forth program is a sequence of _words_ separated by whitespace, run left to right.
Words take their arguments from the _data stack_ and leave their results on it; a number pushes itself.
`2 3 +` pushes 2 and 3, and `+` replaces them with 5.

New words are defined with a colon definition:

```forth
: double ( n -- 2n )
  2 * ;
```

`( n -- 2n )` is the _stack-effect comment_: what the word takes, `--`, what it leaves, with the top of the stack on the right.
It is only a comment, but every definition should have one.
`\` comments to the end of the line.

In gforth's interactive mode `.` prints and removes the top of the stack, and `.s` shows the whole stack.
