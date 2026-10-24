# Instructions

Your new fitness tracker counts the steps you take each day and keeps them as a list, oldest day first. Its
app is disappointing, so you are writing your own reports in BQN.

## 1. Convert steps to metres

Write the function `Distance`. Its left argument is the length of your stride in metres and its right argument
the list of daily step counts. Return the list of metres walked each day.

```bqn
0.75 Distance 4000‿8000‿6000
# ⇒ ⟨3000, 6000, 4500⟩
```

## 2. Check the daily goal

Write the function `GoalMet`. Its left argument is your daily goal and its right argument the daily step
counts. Return a list with `1` for each day you reached the goal (or went past it) and `0` for each day you did
not.

```bqn
10000 GoalMet 12000‿8000‿10000
# ⇒ ⟨1, 0, 1⟩
```

## 3. Count the days

Write the function `DaysRecorded`. It takes the daily step counts and returns how many days the tracker has
recorded.

```bqn
DaysRecorded 3000‿4000‿5000‿6000
# ⇒ 4
```

## 4. Record a new day

Write the function `AddDay`. Its left argument is the daily step counts so far and its right argument the step
count of a new day. Return the counts with the new day at the end.

```bqn
4000‿5000 AddDay 6000
# ⇒ ⟨4000, 5000, 6000⟩
```

## 5. Compare two weeks

Write the function `Change`. Its left argument is last week's daily counts and its right argument this week's,
day for day. Return how many more steps you took on each day this week (negative where you took fewer).

```bqn
5000‿6000‿7000 Change 5500‿5000‿7000
# ⇒ ⟨500, ¯1000, 0⟩
```

## 6. Number the days

Write the function `DayNumbers`. It takes the daily step counts and returns the day numbers for the report,
counting from 1.

```bqn
DayNumbers 300‿200‿500
# ⇒ ⟨1, 2, 3⟩
```
