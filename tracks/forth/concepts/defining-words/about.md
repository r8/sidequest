# About

## How it works

`create name` adds a word whose default behaviour is to push the address of the data space after it (its _body_).
`does>` inside a defining word ends the defining part and, when the defining word runs, replaces the behaviour of the word just created: from then on that word pushes its body address and runs the code after `does>`.

```forth
: array ( n "name" -- )
  create cells allot
  does> ( i -- addr ) swap cells + ;
```

Everything the created words need at run time must be in their body: the stack at definition time is gone by then.

## Patterns

- **Parameterised constants and conversions**: `create , does> @ …`.
- **Self-indexing arrays and tables**: `create … allot does> swap cells +`, possibly with bounds checks.
- **Stateful words**: counters, accumulators, generators — the body is their private state.
- **Records with behaviour**: several cells or a structure in the body, and a `does>` that acts on them.
- **Jump tables**: `create ' a , ' b , does> swap cells + @ execute`.
- **Defining words for defining words**: the body can hold an xt or another defining word's parameters.

## `>body`

`' name >body` reaches the data of a created word without running it: resetting a counter, inspecting a table, or patching a constant.
It is defined only for words made with `create` (and words defined by defining words built on it).

## Initialisation

`allot` does not clear memory; use `here n erase n allot` (or `allot` then `erase` from the body address) when zeros are expected.
Use `align` before `,` if anything of odd size was laid down with `c,` first.

## Beyond `does>`

gforth has more machinery for defining words, such as `interpret/compile:` for words with separate interpretation and compilation behaviour, and structures (see that concept) are built from the same primitives.
The standard word `buffer:` (not in gforth 0.7.3) is itself a one-line defining word: `create allot`.

## Thinking in defining words

Charles Moore's advice is to look for repetition in a program's definitions and turn it into a defining word, so the program reads as a set of declarations in the language of the problem.
A defining word is also how Forth programs build domain-specific languages: the declarations are data, and `does>` is the interpreter for it.
