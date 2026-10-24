# Instructions

You and a friend are planning a long road trip in an old hatchback. It burns 6 litres of fuel every 100
kilometres, its tank lasts only so far, and the snack budget is tight. Before setting off you write a few
helpers in BQN to answer the questions that will come up on the way.

## 1. Estimate the fuel

Write the function `FuelNeeded`. It takes a distance in kilometres and returns the litres of fuel the car burns
over it, at 6 litres per 100 kilometres.

```bqn
FuelNeeded 250
# ⇒ 15
```

## 2. Count the fuel stops

Write the function `Stops`. Its left argument is how many kilometres the car goes on a full tank and its right
argument the length of a leg of the trip. You start every leg with a full tank; return how many times you must
stop to fill up before you arrive. A leg the tank covers needs no stops.

```bqn
500 Stops 1200
# ⇒ 2
```

## 3. Work out the arrival time

Write the function `ArrivalTime`. Its left argument is the hour you leave, on the 24-hour clock, and its right
argument the whole number of hours the drive takes. Return the hour on the clock when you arrive.

```bqn
22 ArrivalTime 5
# ⇒ 3
```

## 4. Buy snacks

Write the function `Snacks`. Its left argument is the money you have and its right argument the price of one
snack; return how many whole snacks you can buy.

```bqn
10 Snacks 3
# ⇒ 3
```

## 5. Measure as the crow flies

Your friend wants to know how far you really are from home. Write the function `Distance`. Its left argument
is how many kilometres east you are and its right argument how many kilometres north (either can be negative);
return the straight-line distance, the square root of the sum of their squares.

```bqn
3 Distance 4
# ⇒ 5
```
