# Instructions

The school's Statistics Club measures everything: the height of the bean plants on the windowsill, the minutes
the bus is late, the marks in the weekly quiz. This term the club has a challenge: every statistic must be a
train, with no blocks and no names for the arguments.

## 1. Find the mean

Write the function `Mean`. It takes a non-empty list of numbers and returns their mean: their sum divided by how
many there are.

```bqn
Mean 2‿4‿9
# ⇒ 5
```

## 2. Find the range

Write the function `Range`. It takes a non-empty list of numbers and returns the difference between the largest
and the smallest.

```bqn
Range 3‿9‿1
# ⇒ 8
```

## 3. Find how far each value is from the mean

Write the function `Deviations`. It takes a non-empty list of numbers and returns, for each of them, the value
minus the mean of the list.

```bqn
Deviations 2‿4‿9
# ⇒ ¯3‿¯1‿4
```

## 4. Find the variance

Write the function `Variance`. It takes a non-empty list of numbers and returns the mean of the squares of
their deviations.

```bqn
Variance 2‿4‿4‿4‿5‿5‿7‿9
# ⇒ 4
```

## 5. Count the values above a mark

Write the function `Above`. Its left argument is a mark and its right argument a list of numbers; it returns
how many of the numbers are greater than the mark.

```bqn
5 Above 3‿7‿9‿5
# ⇒ 2
```

## 6. Find a weighted mean

The quiz has questions worth different numbers of points. Write the function `WeightedMean`. Its left argument
is a list of weights and its right argument a list of values of the same length; it returns the sum of each
value times its weight, divided by the sum of the weights.

```bqn
1‿3 WeightedMean 10‿20
# ⇒ 17.5
```
