# Hints

## General

- [Rank and cells](https://mlochbaum.github.io/BQN/doc/rank.html) explains `˘` and `⎉`.
- [Fold and insert](https://mlochbaum.github.io/BQN/doc/fold.html) explains `˝` beside `´`.

## 1. Total each student's marks

- A student's total is the sum of a row; apply a sum to each row.

## 2. Total each assignment

- Adding the rows together adds them column by column.

## 3. Find the top mark of each assignment

- Like task 2, with a different function between the rows.

## 4. Average each student

- Write the average of one list as a block, then apply it to each row.

## 5. Count the passes

- Comparing the whole table with the pass mark gives a table of 1s and 0s; count the 1s in each row.

## 6. Curve the hard assignments

- Plain `+` would match the extra marks with the rows; you need them matched with each row's elements.
