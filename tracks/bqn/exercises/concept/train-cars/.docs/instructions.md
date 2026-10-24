# Instructions

You have just started work at a shunting yard, where freight trains are taken apart and put back together. The
yard's computer knows a train as a list of car numbers, the locomotive first, and an empty slot as `0`. Your
supervisor needs a few tools for the day's moves.

## 1. Pick the cars at the front

Write the function `Front`. Its left argument is a count and its right argument a train; it returns the first
that many cars.

```bqn
2 Front 7‿31‿12‿45
# ⇒ ⟨7, 31⟩
```

## 2. Uncouple cars at the back

Write the function `Uncouple`. Its left argument is a count and its right argument a train; it returns the train
without its last that many cars.

```bqn
1 Uncouple 7‿31‿12‿45
# ⇒ ⟨7, 31, 12⟩
```

## 3. Turn the train around

The locomotive drives around to the other end of the train, so it stays first while the cars behind it come in
reverse order. Write the function `Turn`. It takes a train and returns the turned train.

```bqn
Turn 7‿31‿12‿45
# ⇒ ⟨7, 45, 12, 31⟩
```

## 4. Spin the turntable

The roundhouse has a turntable with a ring of bays. Turning it one step moves every bay one place towards the
front of the list, and the first bay to the back. Write the function `Turntable`. Its left argument is the number
of steps and its right argument the list of bays; it returns the bays after turning. A negative number of steps
turns the other way.

```bqn
1 Turntable 3‿0‿8‿5
# ⇒ ⟨0, 8, 5, 3⟩
```

## 5. Push a car into the siding

A siding is a dead-end track with a fixed number of slots. Pushing a car in at the front moves every car one slot
along, and whatever was in the last slot rolls out of the far end. Write the function `Siding`. Its left argument
is the new car and its right argument the siding; it returns the siding afterwards.

```bqn
9 Siding 4‿6‿0
# ⇒ ⟨9, 4, 6⟩
```

## 6. Fit a train to the platform

A platform has room for a fixed number of cars, counted from the buffer stop at its far end, where the last car
of the train stops. Write the function `Platform`. Its left argument is the platform's length and its right
argument a train; it returns exactly that many slots: the last cars of the train, with empty slots in front when
the train is shorter than the platform.

```bqn
5 Platform 7‿31‿12
# ⇒ ⟨0, 0, 7, 31, 12⟩
```
