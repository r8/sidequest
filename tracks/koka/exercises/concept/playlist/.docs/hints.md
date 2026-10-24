# Hints

## General

- [The `std/core/list` documentation](https://koka-lang.github.io/koka/doc/std_core_list.html) lists the
  functions on lists.

## 1. Queue a song next

- One of the two ways a list is built puts an element in front of a list.

## 2. Queue a song last

- `++` joins two lists, so the song needs to be in a list of its own.

## 3. Skip songs

- There is a function that leaves out the first elements of a list.

## 4. Check for a song

- The standard library can ask whether a list holds an element.

## 5. Add up the playing time

- A `list<int>` can be added up with a single function.

## 6. Summarise the playlist

- Count the songs first and decide between the three cases with `if` and `elif`.
- `join` takes the separator to put between the titles.
