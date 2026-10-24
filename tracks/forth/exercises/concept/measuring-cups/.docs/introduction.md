# Introduction

`variable` and `constant` are _defining words_: each use creates a new word, and every word it creates behaves the same way with its own data.
Forth lets you write defining words of your own, and this is one of the things the language is best known for.

## `create`, again

`create name` makes a word that leaves the address of the data space that follows it.
Whatever is compiled or allotted right after belongs to that word:

```forth
create answer 42 ,
answer @ .    \ prints 42
```

`create` can also be used _inside_ a colon definition.
Then it does its work when the definition runs, reading the new word's name from the input at that moment:

```forth
: my-variable ( "name" -- )
  create 0 , ;

my-variable hits    \ hits is now a word that leaves an address
3 hits !  hits @ .  \ prints 3
```

`my-variable` reads `hits` from the source, just as `variable` would: its stack-effect comment shows that with `"name"`.

## `does>`

`does>` gives the words a defining word creates their run-time behaviour.
The part of the definition before `does>` runs once, when a new word is defined; the part after `does>` runs every time one of the new words is used, with the address of that word's data on the stack:

```forth
: my-constant ( n "name" -- )
  create ,          \ at definition: store n in the new word's data
  does> ( -- n )
    @ ;             \ at use: fetch it

7 my-constant days
days .              \ prints 7
```

When `days` runs, `does>` code receives the address where `7` was stored, and `@` fetches it.
Write the stack effect of the created words after `does>`, as above: what they take and leave, not counting the address `does>` provides.

The data can be anything `,` and `allot` can lay down: several cells, a counter that changes, a table.

```forth
: tally ( "name" -- )
  create 0 ,
  does> ( -- )
    1 swap +! ;

tally visits
visits visits
' visits >body @ .   \ prints 2
```

## `>body`

`>body ( xt -- addr )` takes the execution token of a word made by `create` and gives the address of its data: the same address its `does>` code receives.
It lets other words reach into a created word's data without running it, as in the last example.

## Words that make words

A defining word turns a pattern into vocabulary.
Instead of writing ten nearly identical colon definitions, you write the pattern once, and each line of the program that uses it reads like a declaration:

```forth
: coin ( pence "name" -- ) create , does> ( n -- pence ) @ * ;
5 coin nickels
10 coin dimes
3 dimes 2 nickels + .   \ prints 40
```

## Pitfalls

- **Two times, two stacks.** The code before `does>` runs when a word is _defined_, and the code after it when the word is _used_. Arguments for one are not there for the other: everything a created word needs later must be stored in its data.
- **`create` reads the next word of the input.** A defining word cannot be given the new name on the stack.
- **Allot what you initialise.** `n cells allot` reserves space but leaves whatever was there; clear it with `erase` when the words expect zeros.
- **`>body` works only on words made with `create`**, not on colon definitions.
