# Instructions

The conference starts tomorrow, and Bartholomew is printing the attendees' name tags from the registration list.
Names arrive as typed into the sign-up form — sometimes with stray spaces — and every one is a string `( c-addr u )`.
None of the words below needs to build new text: each answers with a number, a flag or a part of the name it was given.

## 1. Find the initial

Define `initial ( c-addr u -- c )`, the first character of a name.
The name is never empty.

```forth
s" Grace Hopper" initial emit   \ prints G
```

## 2. Count a letter

Define `count-letter ( c-addr u c -- n )`, how many times the character `c` appears in the name (case matters).

```forth
s" Barbara Liskov" char a count-letter   \ leaves 3
```

## 3. Spot a duplicate registration

Define `same-name? ( c-addr1 u1 c-addr2 u2 -- flag )`, true if the two names are exactly the same text.

```forth
s" Ada Lovelace" s" Ada Lovelace" same-name?   \ leaves true
s" Ada Lovelace" s" Ada lovelace" same-name?   \ leaves false
```

## 4. Trim the spaces

Define `trim ( c-addr u -- c-addr2 u2 )`, the name without spaces at the start or the end.

```forth
s"   Alan Turing " trim type   \ prints Alan Turing
```

## 5. Take the first name

Define `first-name ( c-addr u -- c-addr u2 )`, the part of the name before the first space, or the whole name if it has no space.

```forth
s" Edsger Dijkstra" first-name type   \ prints Edsger
```

## 6. Take the surname

Define `surname ( c-addr u -- c-addr2 u2 )`, the part of the name after the first space; a name without a space has an empty surname.

```forth
s" Edsger Dijkstra" surname type   \ prints Dijkstra
```
