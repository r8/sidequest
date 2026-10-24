# Introduction

A _defining word_ creates new words, as `variable` and `constant` do.
Write your own with `create` and `does>` inside a colon definition:

```forth
: coin ( pence "name" -- )
  create ,                 \ runs once, when a coin is defined
  does> ( n -- pence )     \ runs each time a coin is used,
    @ * ;                  \ with the address of its data on the stack

5 coin nickels
10 coin dimes
3 dimes 2 nickels + .      \ prints 40
```

The code before `does>` runs when a word is defined, laying down its data with `,` or `allot`; the code after it runs whenever that word is used, starting with the address of its data.
`>body ( xt -- addr )` gives the same address from the word's execution token.
