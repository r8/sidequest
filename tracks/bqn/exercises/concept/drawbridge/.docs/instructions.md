# Instructions

You have just become the keeper of the old drawbridge over the river. Boats with tall masts need the bridge
raised; cars queue up and pay a toll when it is down. The town council has rules about all of it, and you
decide to write them down in BQN before your first shift.

## 1. Check whether a boat fits under the bridge

The closed bridge leaves 6 metres of clearance above the water. Write the function `CanPass`. It takes the
height of a boat's mast in metres and returns `1` if the boat fits under the closed bridge (its mast is lower
than 6 metres), else `0`.

```bqn
CanPass 4.5
# ⇒ 1
```

## 2. Check for rush hour

Write the function `IsRushHour`. It takes an hour of the day (a whole number from 0 to 23) and returns `1`
during rush hour, which runs from 7 to 9 and from 16 to 18, both ends included, else `0`.

```bqn
IsRushHour 8
# ⇒ 1
```

## 3. Decide whether to raise the bridge

Write the function `MustRaise`. Its left argument is the hour and its right argument a boat's mast height. The
bridge is raised when the boat does not fit underneath and it is not rush hour; return `1` or `0`.

```bqn
12 MustRaise 9
# ⇒ 1
```

## 4. Charge the toll

Every vehicle pays 2 coins, and 3 more if it pulls a trailer, but residents of the town cross for free. Write
the function `Toll`. Its left argument is `1` for a resident and `0` otherwise, and its right argument `1` if
the vehicle pulls a trailer and `0` otherwise. Return the toll in coins.

```bqn
0 Toll 1
# ⇒ 5
```

## 5. Spot a blown bulb

Each end of the bridge has a warning lamp, and the two are always switched on and off together. If exactly one
of them is lit, a bulb has blown. Write the function `BulbBlown`. Its arguments are the two lamps, `1` for lit
and `0` for dark; return `1` if a bulb has blown, else `0`.

```bqn
1 BulbBlown 0
# ⇒ 1
```
