# Instructions

Rosa paints shop signs, and her customers send their wording by text message.
Before she picks up a brush, she lays out each sign with a few Forth words.
Every word takes the customer's text as `( c-addr u )` and leaves the sign's text in a buffer of its own, valid until that word is called again.

A sign board holds at most 80 characters: any result longer than that is cut off after the 80th character.

## 1. Make it loud

Define `shout ( c-addr u -- c-addr2 u )`, the text with every lower-case letter turned to upper case and every other character unchanged.

```forth
s" Fresh bread!" shout type   \ prints FRESH BREAD!
```

## 2. Frame it

Define `framed ( c-addr u -- c-addr2 u2 )`, the text with `* ` before it and ` *` after it.

```forth
s" Open" framed type   \ prints * Open *
```

## 3. Say it again

Define `repeated ( c-addr u n -- c-addr2 u2 )`, `n` copies of the text with a single space between each copy and the next.
`n` of 0 gives an empty sign.

```forth
s" SALE" 3 repeated type   \ prints SALE SALE SALE
```

## 4. Space it out

Define `spaced-out ( c-addr u -- c-addr2 u2 )`, the text with a space between every two characters.

```forth
s" SALE" spaced-out type   \ prints S A L E
```
