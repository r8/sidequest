# Instructions

Every Friday you host pizza night for your friends. The dough is made in the afternoon and needs 90 minutes to
rise; each pizza then spends 12 minutes in the oven, which takes 15 minutes to heat up first. Your friends keep
asking when dinner will be ready, so you decide to write it down in BQN.

## 1. Work out how long the dough still has to rise

Write the function `RiseTimeLeft`. It takes the minutes the dough has risen so far and returns how many of the
90 minutes are left.

```bqn
RiseTimeLeft 25
# ⇒ 65
```

## 2. Work out the baking time

Write the function `BakingTime`. It takes the number of pizzas and returns the minutes from switching the oven
on until the last pizza comes out: 15 minutes to heat up, then 12 minutes per pizza, one after another.

```bqn
BakingTime 3
# ⇒ 51
```

## 3. Work out how much dough to make

Write the function `DoughNeeded`. It takes the number of pizzas and returns the grams of dough to make: 250 grams
for each pizza, plus one spare 250-gram ball in case a pizza ends up on the floor.

```bqn
DoughNeeded 4
# ⇒ 1250
```

## 4. Work out when dinner is ready

Write the function `TotalTime`. Its left argument is the number of pizzas and its right argument the minutes
the dough has risen so far. It returns the minutes until the last pizza is out of the oven, if you switch the
oven on only once the dough has finished rising.

```bqn
3 TotalTime 25
# ⇒ 116
```

## 5. Share the slices

Each pizza is cut into 8 slices. Write the function `SlicesEach`. Its left argument is the number of guests and
its right argument the number of pizzas; it returns how many slices each guest gets.

```bqn
6 SlicesEach 3
# ⇒ 4
```
