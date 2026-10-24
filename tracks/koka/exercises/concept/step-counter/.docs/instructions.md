# Instructions

Dana's new fitness tracker records how many steps she walks each day, as a list of numbers, oldest day first.
The tracker's firmware is written in Koka, and the statistics screen is still empty. Fill it in.

## 1. Add up the steps

Define `total-steps`: it takes the daily step counts and returns how many steps Dana walked in total.

```koka
total-steps([4000, 12000, 9000])
// => 25000
```

## 2. Count the good days

Define `goal-days`: it takes the daily step counts and a daily goal, and returns on how many days Dana walked at
least that many steps.

```koka
goal-days([4000, 12000, 9000], 9000)
// => 2
```

## 3. Find the longest streak

Define `longest-streak`: it takes the daily step counts and a daily goal, and returns the length of the longest
run of consecutive days on which she met the goal.

```koka
longest-streak([10000, 11000, 2000, 10000, 10500, 12000, 300], 10000)
// => 3
```

## 4. Find the best day

Define `best-day`: it takes the daily step counts and returns the number of the day with the most steps, counting
the first day as day 1. When several days share the record, the earliest counts; with no days at all, it returns
0.

```koka
best-day([4000, 12000, 9000, 12000])
// => 2
```

## 5. Plan the training

Dana's coach wants her daily average to grow by the same number of steps every week. Define `weeks-to-goal`: it
takes her current daily steps, the increase per week (always more than 0) and the goal, and returns after how many
weeks of training her daily steps reach the goal for the first time.

```koka
weeks-to-goal(6000, 1500, 10000)
// => 3
```
