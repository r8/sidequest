# Introduction

## Characters

A string is made of characters, and a single character has its own type, `char`. Character literals are
written in single quotes; double quotes always make a string:

```koka
val letter : char = 'k'
val word : string = "k"       // a string of one character, not a char
```

The usual escapes work in character literals too: `'\n'` (newline), `'\t'` (tab), `'\''` (a single quote),
`'\\'` (a backslash), and `'€'` for any Unicode code point (here `€`).

## Characters are numbers

Every character is a Unicode _code point_, a number. `.int` gives the number and `.char` turns a number back
into a character:

```koka
'a'.int        // 97
'A'.int        // 65
66.char        // 'B'
```

In Unicode, as in ASCII, the letters `a` to `z` are consecutive, and so are `A` to `Z` and `0` to `9`. That
makes arithmetic on code points useful: the position of a letter in the alphabet is its distance from `'a'`,
and a digit's value is its distance from `'0'`:

```koka
'd'.int - 'a'.int      // 3
'7'.int - '0'.int      // 7
('a'.int + 2).char     // 'c'
```

`+` and `-` also work directly between two characters and return a character, which is rarely what you want;
converting to `int` and back keeps it clear.

Characters compare by code point with `==`, `!=`, `<`, `<=`, `>` and `>=`, so `c >= 'a' && c <= 'z'` checks for
a lower-case ASCII letter. They can be matched with literal patterns:

```koka
fun describe(c : char) : string
  match c
    ' ' -> "space"
    '\n' -> "new line"
    _ -> "something else"
```

## Classifying characters

The standard library has predicates for the common classes:

| Function | `True` for |
| --- | --- |
| `c.is-lower` | `a` to `z` |
| `c.is-upper` | `A` to `Z` |
| `c.is-alpha` | a letter, either case |
| `c.is-digit` | `0` to `9` |
| `c.is-alpha-num` | a letter or a digit |
| `c.is-white` | a space, tab, newline or carriage return |

They only know ASCII: `'é'.is-alpha` is `False`. There is no function to change the case of a single
character — `to-upper` and `to-lower` work on whole strings — so for letters, case is done with arithmetic:
`A` is 32 code points before `a`, and so on through the alphabet.

## From strings to characters and back

`s.list` turns a string into a `list<char>`, and `.string` turns a list of characters back into a string. In
between, everything you know about lists applies:

```koka
"typewriter".list.take(4).string             // "type"
"a1b22".list.filter(is-digit).length         // 3
'q'.string ++ "!"                            // "q!": one character as a string
```

Strings also have some character-wise functions of their own: `s.map(f)` applies a `(char) -> char` function
to every character, and `s.count(p)` counts the characters for which `p` is `True`:

```koka
"a1b22".count(is-digit)                      // 3
```

## Pitfalls

- `'a'` and `"a"` have different types and are never equal; compare a character with a character.
- `.count` of a string counts characters, not bytes: `"héllo".count` is `5`.
- `println` of a `char` shows it in quotes, like `show` does: `'A'`. Use `.string` to print the bare character.
