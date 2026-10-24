# Instructions

Every evening, beekeeper Pilar sits by her hive for ten minutes and counts the bees that fly in. She writes the
counts in her notebook, one per day, and now she wants to make sense of a season's worth of numbers. The counts are
an array of integers, the first one for day 1.

## 1. Count all the bees

Define the `total_bees` method, which returns the sum of all the counts:

```inko
total_bees([31, 40, 0, 52])
# => 123
```

## 2. Count the busy days

Define the `busy_days` method, which returns how many days had at least a given number of bees:

```inko
busy_days([31, 40, 0, 52], threshold: 40)
# => 2
```

## 3. Estimate the real numbers

Pilar only watches the hive for a few minutes, so the real number of bees is a multiple of her count. Define the
`estimates` method, which returns a new array with every count multiplied by a factor:

```inko
estimates([31, 40, 0, 52], factor: 10)
# => [310, 400, 0, 520]
```

## 4. Check for a quiet day

A day without any bees is worrying. Define the `quiet_day?` method, which returns whether any day had no bees:

```inko
quiet_day?([31, 40, 0, 52])
# => true
```

## 5. Track the daily changes

Define the `daily_changes` method, which returns, for every day after the first, how many more bees came in than
the day before (a negative number for fewer):

```inko
daily_changes([31, 40, 0, 52])
# => [9, -40, 52]
```

## 6. List the busy days

Define the `busy_day_numbers` method, which returns the day numbers (starting at 1) of the days with at least a
given number of bees:

```inko
busy_day_numbers([31, 40, 0, 52], threshold: 40)
# => [2, 4]
```
