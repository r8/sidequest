# Hints

## General

- The Janet documentation describes [arrays](https://janet-lang.org/docs/data_structures/arrays.html) and [tuples](https://janet-lang.org/docs/data_structures/tuples.html).
- The [array module](https://janet-lang.org/api/array.html) lists the `array/` functions.

## 1. Couple a car

- There is an `array/` function that adds to the end, and it returns the array.

## 2. Uncouple the last car

- There is an `array/` function that removes from the end and returns what it removed.

## 3. Look up a car

- One way to read an element returns `nil` when the index is out of range, and another raises an error. You want the first.

## 4. Insert a car

- `array/insert` takes the array, the index and the value.

## 5. Write the manifest

- The manifest is a new tuple with the same elements as the array.
- `tuple` builds a tuple from its arguments, and `;` spreads an array's elements out as arguments.
