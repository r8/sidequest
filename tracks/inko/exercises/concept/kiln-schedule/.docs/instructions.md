# Instructions

Marta runs a small pottery studio with one electric kiln. Before a batch of bowls can go in, every piece is glazed
by hand, and once the kiln door closes it stays shut for the whole firing. Marta keeps losing track of time, so she
asks you to write a few methods that do the counting for her.

## 1. Know how long a firing takes

A glaze firing in Marta's kiln always takes 480 minutes. Define the `firing_minutes` method, which takes no
arguments and returns how many minutes a firing takes:

```inko
firing_minutes
# => 480
```

## 2. Work out how much of the firing is left

Define the `remaining_minutes` method, which takes how many minutes the kiln has been firing and returns how many
minutes are left:

```inko
remaining_minutes(elapsed: 200)
# => 280
```

## 3. Work out how long glazing takes

Glazing one piece takes Marta 12 minutes. Define the `glazing_minutes` method, which takes the number of pieces and
returns how many minutes it takes to glaze them all:

```inko
glazing_minutes(pieces: 5)
# => 60
```

## 4. Work out the time spent so far

Define the `total_minutes` method, which takes the number of pieces Marta glazed and how many minutes the kiln has
been firing, and returns the total number of minutes she has spent on the batch:

```inko
total_minutes(pieces: 5, elapsed: 200)
# => 260
```
