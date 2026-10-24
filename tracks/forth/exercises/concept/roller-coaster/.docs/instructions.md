# Instructions

The Corkscrew is the newest roller coaster at Ashgrove Fun Park, and the ride attendants check every rider at the gate.
The park wants the rules in Forth, so the gate can check them before the attendants do.

## 1. Check the height

A rider must be at least 120 cm tall.
Define `tall-enough? ( cm -- flag )`.

```forth
125 tall-enough?   \ leaves true
110 tall-enough?   \ leaves false
```

## 2. Check the seat

The harness also does not close over riders taller than 195 cm.
Define `fits-the-seat? ( cm -- flag )`, true for riders from 120 cm through 195 cm.

```forth
195 fits-the-seat?   \ leaves true
196 fits-the-seat?   \ leaves false
```

## 3. Check the rider

A rider may ride when they fit the seat and are at least 8 years old.
Define `may-ride? ( cm age -- flag )`.

```forth
140 9 may-ride?   \ leaves true
140 7 may-ride?   \ leaves false
```

## 4. Check the pair

Two riders share a car, and at least one of them must be 16 or older.
Define `ride-together? ( age1 age2 -- flag )`.

```forth
12 17 ride-together?   \ leaves true
12 15 ride-together?   \ leaves false
```

## 5. Count the riders

The gate checks a group of three and gets three flags.
Define `riders ( flag1 flag2 flag3 -- n )`, the number of those flags that are true.
The flags are well-formed: each is `true` or `false`.

```forth
true false true riders   \ leaves 2
```
