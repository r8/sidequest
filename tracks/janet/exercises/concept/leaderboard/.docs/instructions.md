# Instructions

The village bowling alley has a chalkboard by the bar where the evening's scores go up.
On league nights the board gets crowded, arguments start about who is really winning, and the chalk runs out.
The owner, Dot, has bought a screen instead, and she wants you to write the code that keeps the leaderboard in order.

A player is a struct with a `:name` and a `:score`:

```janet
{:name "Ines" :score 212}
```

## 1. List the scores from best to worst

Define the function `ranked-scores` that takes an indexed collection of scores (numbers) and returns a new array with the scores from highest to lowest.
The collection passed in must not change.

```janet
(ranked-scores [180 212 97])
# => @[212 180 97]
```

## 2. List the players alphabetically

Define the function `by-name` that takes an indexed collection of players and returns a new array of the same players ordered by name.

```janet
(by-name [{:name "Ruth" :score 150} {:name "Al" :score 190}])
# => @[{:name "Al" :score 190} {:name "Ruth" :score 150}]
```

## 3. Show the podium

Define the function `podium` that takes an indexed collection of players and returns the names of the best three, highest score first.
With fewer than three players, it returns all of their names.
No two players have the same score here.

```janet
(podium [{:name "Ruth" :score 150} {:name "Al" :score 190}
         {:name "Ines" :score 212} {:name "Bo" :score 88}])
# => ["Ines" "Al" "Ruth"]
```

## 4. Rank the board in place

The screen keeps one array of players and reorders it after every frame.
Define the function `rank!` that takes an array of players, sorts it in place from the highest score to the lowest, and returns the same array.
Players with equal scores are ordered by name.

```janet
(def board @[{:name "Bo" :score 150} {:name "Al" :score 150} {:name "Ines" :score 212}])
(rank! board)
# => @[{:name "Ines" :score 212} {:name "Al" :score 150} {:name "Bo" :score 150}]
```
