# Instructions

Mei runs a small tea house where every pot is timed to the minute. Her old kitchen timer has finally given up,
so she has asked you to write the arithmetic for a new one.

## 1. Know how long tea steeps

Define the `steep-minutes` function: it takes no arguments and returns how many minutes a pot of tea steeps,
which in Mei's tea house is always 4.

```koka
steep-minutes()
// => 4
```

## 2. Work out the minutes left

Define the `minutes-left` function: it takes how many minutes a pot has been steeping and returns how many
minutes are left, using the steeping time from task 1.

```koka
minutes-left(1)
// => 3
```

## 3. Time the kettle

Boiling the water takes 2 minutes per cup in the pot. Define the `boiling-minutes` function: it takes the number
of cups and returns how many minutes the kettle needs.

```koka
boiling-minutes(3)
// => 6
```

## 4. Work out the time spent so far

Define the `elapsed-minutes` function: it takes the number of cups and how many minutes the pot has been
steeping, and returns the total minutes spent on that pot so far — boiling the water, then steeping.

```koka
elapsed-minutes(3, 2)
// => 8
```
