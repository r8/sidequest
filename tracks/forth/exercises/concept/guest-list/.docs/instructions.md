# Instructions

Odile is organising her grandparents' golden wedding anniversary, and the guest list keeps changing.
Names arrive in a shared input buffer that is reused for the next name, so every name she wants to keep has to be copied somewhere of its own; and the table plan grows every time a cousin calls.
Help her with words that use allocated memory.
Each word that returns memory leaves it to the caller to `free` it.

## 1. Keep a name

Define `copy-name ( c-addr u -- c-addr2 u )`, which copies a name into newly allocated memory and returns the copy.

```forth
s" Ada" copy-name   \ leaves a new copy of "Ada"
```

## 2. Write a place card

A place card has the guest's first name, a space and their surname.
Define `full-name ( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 )`, which returns the card's text in newly allocated memory.

```forth
s" Ada" s" Lovelace" full-name   \ leaves a new string "Ada Lovelace"
```

## 3. Lay the tables

Each seat at a table holds the number of the guest sitting there, and 0 for an empty seat.
Define `guest-slots ( n -- addr )`, which allocates `n` cells, all set to 0.

```forth
8 guest-slots   \ leaves the address of 8 empty seats
```

## 4. Move to a bigger room

Define `resize-slots ( addr n1 n2 -- addr2 )`, which changes a block of `n1` seats from `guest-slots` to `n2` seats.
The first seats keep their guests; any new seats are empty.
`addr` must not be used afterwards.

```forth
8 guest-slots 8 12 resize-slots   \ leaves the address of 12 seats, the last 4 empty
```
