# Hints

## General

- [Structures](https://gforth.org/manual/Forth200x-Structures.html) in the Gforth manual, and [BEGIN-STRUCTURE](https://forth-standard.org/standard/facility/BEGIN-STRUCTURE) in the standard.
- A field word only computes an address; `@ !` and `c@ c!` do the rest.

## 1. Describe a crew member

- Delete the placeholder definitions and declare the structure between `begin-structure` and `end-structure`.
- The deck letter is a character, so it has its own kind of field.

## 2. Enlist a crew member

- Each value goes into its field with the store word that fits its size; the record's address is needed for every one of them.
- Store the values in the opposite order from the stack: the deck is nearest the address.

## 3. Promote a crew member

- One word adds to a cell in memory.

## 4. Find a crew member in the roster

- Records are `crew-member` address units apart.

## 5. Find the most senior crew member

- Keep the address of the best record so far on the stack, and compare each other record's rank with it.
- A small word that picks the higher-ranked of two record addresses keeps the loop short.
