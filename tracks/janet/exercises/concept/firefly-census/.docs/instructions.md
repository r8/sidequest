# Instructions

Every June the volunteers of the Willow Marsh nature reserve count fireflies.
Each night at dusk a volunteer walks the boardwalk and clicks a counter for every flash they see.
The counts for the season are kept in an array, one number per night, starting with the first night at index 0.
The reserve's warden would like some help making sense of them.

## 1. Count all the fireflies

Define the function `total` that takes the counts and returns how many fireflies were counted over the whole season.

```janet
(total @[12 0 31 7])
# => 50
```

## 2. Count the busy nights

Define the function `busy-nights` that takes the counts and a threshold and returns on how many nights the count was at least the threshold.

```janet
(busy-nights @[12 0 31 7] 10)
# => 2
```

## 3. Find the first quiet night

A night without a single firefly worries the warden.
Define the function `first-quiet-night` that takes the counts and returns the index of the first night with a count of 0, or `nil` when every night saw fireflies.

```janet
(first-quiet-night @[12 9 0 31 0])
# => 2
```

## 4. Correct the counts

It turns out that on the first night of every week — the nights at index 0, 7, 14 and so on — two volunteers walked the boardwalk together and both counts were added up.
Define the function `correct-counts!` that takes the counts, halves the count of each first night of a week in place, and returns the counts.

```janet
(correct-counts! @[20 3 3 3 3 3 3 8 1])
# => @[10 3 3 3 3 3 3 4 1]
```

## 5. Find when the goal was reached

The reserve's goal for the season is a number of fireflies.
Define the function `nights-to-reach` that takes the counts and the goal and returns how many nights it took for the total so far to reach the goal, or `nil` if the season's total never reached it.

```janet
(nights-to-reach @[12 0 31 7] 40)
# => 3
```
