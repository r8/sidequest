# Instructions

Ottoline is making a word game with wooden letter tiles.
Players draw a handful of tiles, and the scoring depends on what is printed on them.
Every tile is a single ASCII character, and it may be a letter in either case, a digit, or a blank or punctuation tile.
Help her write the words the scorer needs.

## 1. Spot a letter

Define `letter? ( c -- flag )`, true if `c` is a letter, upper- or lower-case.

```forth
char g letter?   \ leaves true
char 7 letter?   \ leaves false
```

## 2. Make it upper case

Define `upper-case ( c -- c' )`: a lower-case letter becomes the same letter in upper case, and any other character is left as it is.

```forth
char g upper-case emit   \ prints G
char ! upper-case emit   \ prints !
```

## 3. Spot a vowel

Define `vowel? ( c -- flag )`, true if `c` is one of the vowels A, E, I, O or U, in either case.

```forth
char e vowel?   \ leaves true
char Y vowel?   \ leaves false
```

## 4. Number the letters

Define `letter-number ( c -- n )`, the place of the letter in the alphabet, from 1 for A to 26 for Z.
Upper- and lower-case letters have the same number, and `c` is always a letter.

```forth
char c letter-number   \ leaves 3
char Z letter-number   \ leaves 26
```

## 5. Score a tile

Define `tile-points ( c -- points )`:

- a tile that is not a letter scores 0;
- a vowel scores 1;
- J, Q, X and Z score 8;
- every other letter scores 2.

Case does not matter.

```forth
char q tile-points   \ leaves 8
char ? tile-points   \ leaves 0
```
