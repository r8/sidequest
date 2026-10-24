# Hints

## General

- The [ordering functions](https://mlochbaum.github.io/BQN/doc/order.html) documentation covers sort and grade.
- [Select](https://mlochbaum.github.io/BQN/doc/select.html) puts a list in the order of a list of indices.

## 1. Sort the times

- There is a primitive that sorts in ascending order.

## 2. List the runners alphabetically

- The same primitive sorts strings too.

## 3. Put the runners in finishing order

- You need the order that sorts the times, as indices, and then the names in that order.

## 4. Find the winner

- The first index of a grade is where the smallest value is.

## 5. Print the places

- A grade says who is in each place; grading it again says what place each runner is in.
- Places in the result start from 1, grades from 0.

## 6. Rank the fancy dress contest

- Grade down sorts from largest to smallest, and keeps equal values in their original order.
