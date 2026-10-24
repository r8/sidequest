# Hints

## General

- [Heap allocation](https://gforth.org/manual/Heap-Allocation.html) in the Gforth manual, and the [Memory-Allocation word set](https://forth-standard.org/standard/memory) in the standard.
- `allocate throw` gives you the address or stops with the error.

## 1. Keep a name

- Allocate as many characters as the name has, then `move` the name into the new memory.
- The result is the new address with the original length.

## 2. Write a place card

- The card needs room for both names and the space between them.
- A variable that remembers where the next characters go makes the copying easy; the string-buffer words you wrote for signs work here too.

## 3. Lay the tables

- `allocate` does not clear the memory; `erase` does.

## 4. Move to a bigger room

- `resize` keeps the old seats but leaves any new ones as they happen to be.
- The new seats start `n1` cells after the new address; there are `n2 - n1` of them, or none when the room shrinks.
