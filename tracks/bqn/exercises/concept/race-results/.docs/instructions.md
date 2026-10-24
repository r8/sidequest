# Instructions

The village fun run is over and the results volunteers have a clipboard full of names and finishing times.
Before the prizes can be handed out, they need the results put in order. Times are in minutes, and the runners'
names and times are two lists in the same order: the first time belongs to the first name.

## 1. Sort the times

Write the function `SortedTimes`. It takes a list of times and returns them from fastest (smallest) to
slowest.

```bqn
SortedTimes 31‿27‿35‿27
# ⇒ ⟨ 27 27 31 35 ⟩
```

## 2. List the runners alphabetically

Write the function `Alphabetical`. It takes a list of names, each starting with a capital letter, and returns
them in alphabetical order.

```bqn
Alphabetical "Cy"‿"Ana"‿"Dee"‿"Ben"
# ⇒ ⟨ "Ana" "Ben" "Cy" "Dee" ⟩
```

## 3. Put the runners in finishing order

Write the function `Finishers`. Its left argument is the list of names and its right argument their times; it
returns the names from fastest to slowest. Runners with the same time stay in the order they are listed.

```bqn
"Ana"‿"Ben"‿"Cy"‿"Dee" Finishers 31‿27‿35‿27
# ⇒ ⟨ "Ben" "Dee" "Ana" "Cy" ⟩
```

## 4. Find the winner

Write the function `Winner`. Its left argument is the list of names and its right argument their times; it
returns the name of the fastest runner, the first one listed if several share the best time.

```bqn
"Ana"‿"Ben"‿"Cy"‿"Dee" Winner 31‿27‿35‿27
# ⇒ "Ben"
```

## 5. Print the places

Write the function `Places`. It takes the list of times and returns each runner's place, counting from 1 for
the fastest, in the order the runners are listed. Of two runners with the same time, the one listed first
gets the better place.

```bqn
Places 31‿27‿35‿27
# ⇒ ⟨ 3 1 4 2 ⟩
```

## 6. Rank the fancy dress contest

The judges also scored everyone's costume, and here more points is better. Write the function `Leaderboard`.
Its left argument is the list of names and its right argument their points; it returns the names from most to
fewest points, keeping the listed order for equal points.

```bqn
"Ana"‿"Ben"‿"Cy"‿"Dee" Leaderboard 3‿5‿5‿1
# ⇒ ⟨ "Ben" "Cy" "Ana" "Dee" ⟩
```
