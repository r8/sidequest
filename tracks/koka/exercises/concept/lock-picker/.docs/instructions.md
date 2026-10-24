# Instructions

Ada is a locksmith. Customers bring her combination locks they have lost the combination to, and she sets her
lock-picking machine on them. The machine runs small programs: a program asks for the next digit to try with
`pick-digit`, offering the digits that dial can show, and gives up on an attempt with `dead-end`. Which digits
are actually tried, and in what order, is up to the handler the machine runs the program under.

The `pick` effect is declared in the stub.

## 1. Try everything

Define `all-outcomes`: it takes a program and returns the program's results for every digit it could pick, in
the order of the options. Attempts that hit a dead end leave no result.

```koka
all-outcomes { pick-digit([1, 2]) * 10 + pick-digit([3, 4]) }
// => [13, 14, 23, 24]
```

## 2. Count the ways

Define `count-outcomes`: it takes a program and returns how many ways of picking digits let the program finish.

```koka
count-outcomes { val d = pick-digit(list(0, 9)); if d.is-odd then dead-end() else d }
// => 5
```

## 3. Stop at the first

Define `first-outcome`: it takes a program and returns `Just` its first result, in the order of the options, or
`Nothing` when every attempt is a dead end. It must not try any more digits once it has found a result.

```koka
first-outcome { val d = pick-digit([1, 2, 3]); if d >= 2 then d else dead-end() }
// => Just(2)
```

## 4. Dial a combination

Define `combination`: it takes the number of dials and the digits each dial shows, and picks one digit per dial,
returning the combination as a list, first dial first.

```koka
all-outcomes { combination(2, [0, 1]) }
// => [[0, 0], [0, 1], [1, 0], [1, 1]]
```

## 5. Find the opening

Define `opening`: it takes the number of dials, the digits, and a function that tells whether a combination fits
what Ada knows about the lock, and returns a combination that fits, giving up on every one that does not.

```koka
all-outcomes { opening(2, [1, 2, 3], fn(c) c.sum == 4) }
// => [[1, 3], [2, 2], [3, 1]]
```
