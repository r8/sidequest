# Hints

## General

- [Characters and strings](https://gforth.org/manual/Characters-and-Strings-Tutorial.html) in the Gforth tutorial.
- [Displaying characters and strings](https://gforth.org/manual/Displaying-characters-and-strings.html) lists `char`, `[char]`, `emit` and `bl`.
- An [ASCII table](https://en.wikipedia.org/wiki/ASCII#Printable_characters) shows every code.

## 1. Spot a letter

- Test the two ranges separately and combine the flags.
- Remember that the top of a `within` range is not included.

## 2. Make it upper case

- Change the character only when it is in the lower-case range; the distance between the cases is the same for every letter.

## 3. Spot a vowel

- Converting to one case first halves the number of characters to compare against.
- In a `case`, the default branch must leave its result below the selector, which `endcase` drops.

## 4. Number the letters

- A letter's place is its distance from the first letter, plus one.

## 5. Score a tile

- Deal with the easy cases first and leave the definition early with `exit`, so the rest only sees letters.
