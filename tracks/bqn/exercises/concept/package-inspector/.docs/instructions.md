# Instructions

You work the night shift at a parcel depot. Every parcel that comes in has to be weighed and measured, and the
sorting machine jams on anything too heavy or too big. Your supervisor wants the checks written in BQN: a
parcel that breaks a rule must be stopped with a clear message, and the depot's dashboard must keep running
whatever the parcels look like.

## 1. Check the weight

Write the function `CheckWeight`. It takes a weight in kilograms and returns it unchanged if it is valid. It
raises the error `"weight must be positive"` if the weight is 0 or less, and `"too heavy"` if it is more than 30.

```bqn
CheckWeight 12
# ⇒ 12
CheckWeight 31
# Error: too heavy
```

## 2. Measure the parcel

Write the function `Volume`. It takes the parcel's length, width and height in centimetres, as a list of three
numbers, and returns its volume in cubic centimetres. It raises `"sides must be positive"` if any side is 0 or
less, and otherwise `"too big"` if the three sides add up to more than 150.

```bqn
Volume 20‿30‿10
# ⇒ 6000
Volume 100‿40‿20
# Error: too big
```

## 3. Work out the postage

Write the function `Postage`. Its left argument is the price per kilogram and its right argument the weight; it
returns the price of sending the parcel. A weight that `CheckWeight` rejects raises the same error.

```bqn
2 Postage 12
# ⇒ 24
```

## 4. Keep the scales display running

The display at the scales must never crash. Write the function `SafeWeight`. It takes a weight and returns it if
`CheckWeight` accepts it, and `0` otherwise.

```bqn
SafeWeight 31
# ⇒ 0
```

## 5. Report on a parcel

Write the function `Inspect`. It takes the three sides of a parcel, like `Volume`, and returns `"ok"` if
`Volume` accepts them, and otherwise the message of the error `Volume` raised.

```bqn
Inspect 100‿40‿20
# ⇒ "too big"
```
