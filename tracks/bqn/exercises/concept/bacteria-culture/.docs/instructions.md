# Instructions

Dr. Okafor's lab grows bacteria in Petri dishes for a school science fair. Her favourite culture doubles every
hour, as long as the incubator stays warm. She asks you to write a few BQN functions so the students can
predict, and look back on, their cultures.

## 1. Grow the culture

Write the function `Grow`. Its left argument is a number of hours and its right argument the number of
bacteria now; it returns the number of bacteria after that many hours of doubling.

```bqn
3 Grow 100
# ⇒ 800
```

## 2. Show every hour

Write the function `Timeline`. Its arguments are the same as `Grow`'s; it returns the counts at every whole
hour, from now (hour 0) up to and including the last hour.

```bqn
3 Timeline 100
# ⇒ 100‿200‿400‿800
```

## 3. Look back in time

Write the function `Earlier`. Its left argument is a number of hours and its right argument the number of
bacteria now; it returns how many there were that many hours ago.

```bqn
2 Earlier 800
# ⇒ 200
```

## 4. Find how long it takes

Write the function `HoursNeeded`. Its left argument is the number of bacteria now and its right argument a
target; it returns how many hours of doubling it takes to reach the target exactly (a fraction of an hour when
the target is not a doubling of the start).

```bqn
100 HoursNeeded 1600
# ⇒ 4
```

## 5. Encode the temperature

The incubator's display shows a code instead of the temperature: it adds 10 to the temperature in degrees
Celsius, then multiplies by 3. Write the function `Encode`. It takes a temperature and returns its code.

```bqn
Encode 37
# ⇒ 141
```

## 6. Decode the temperature

Write the function `Decode`. It takes a code from the display and returns the temperature.

```bqn
Decode 141
# ⇒ 37
```
