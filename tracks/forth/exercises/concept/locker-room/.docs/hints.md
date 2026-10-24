# Hints

## General

- [Memory access](https://gforth.org/manual/Memory-Access.html), [Dictionary allocation](https://gforth.org/manual/Dictionary-allocation.html) and [Address arithmetic](https://gforth.org/manual/Address-arithmetic.html) in the Gforth manual.
- The [Memory tutorial](https://gforth.org/manual/Memory-Tutorial.html) builds records step by step.

## 1. Install a locker

- The new locker starts at `here`; get that address before you lay anything down.
- Lay the cells down in order with `,`, and remember that a new locker is closed.

## 2. Read a locker

- The first field is at the locker's own address; the next one is a cell further on.

## 3. Open a locker

- A word that computes the address of the open flag is useful in this task and the next two.
- Only store into the flag when the combination matches.

## 4. Lock up

- Store false into the open flag.

## 5. Hand a locker over

- The locker's address is needed for every store; `tuck` keeps a copy of it below the value you are storing.
