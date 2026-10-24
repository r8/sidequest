# Instructions

Ines works the customs desk at a small island airport. Each arriving traveller fills in a declaration — how many
bottles of wine they bring and how much cash they carry — and Ines must either wave them through or tell them,
precisely, what is wrong. She has asked you to write the checks for her new terminal.

## 1. Check the bottles

Each traveller may bring at most 4 bottles. Define `check-bottles`: it takes the number of bottles and returns
`Right` with that number when it is allowed, `Left("too many bottles")` when it is more than 4, and
`Left("bottles cannot be negative")` when it is below 0.

```koka
check-bottles(2)
// => Right(2)
check-bottles(6)
// => Left("too many bottles")
```

## 2. Check the cash

Cash above 10000 must be declared at the red desk. Define `check-cash`: it takes the amount of cash and returns
`Right` with the amount when it is at most 10000, and `Left("declare cash over 10000")` otherwise.

```koka
check-cash(800)
// => Right(800)
```

## 3. Read the form

Declarations arrive as text from the terminal's keypad. Define `read-amount`: it takes the text and returns
`Right` with the number it spells, or `Left("unreadable: <text>")` when it is not a number.

```koka
read-amount("250")
// => Right(250)
read-amount("lots")
// => Left("unreadable: lots")
```

## 4. Check a whole declaration

Define `check-declaration`: it takes the number of bottles and the cash, and returns `Right` with both as a pair
`(bottles, cash)` when both checks pass. Otherwise it returns the first failure: the bottles are checked before
the cash.

```koka
check-declaration(3, 900)
// => Right((3, 900))
check-declaration(9, 20000)
// => Left("too many bottles")
```

## 5. Tell the traveller

Define `verdict`: it takes the result of a check of a whole declaration and returns what Ines says —
`"Welcome to the island!"` when it passed, and `"Please step aside: <problem>"` when it did not.

```koka
verdict(check-declaration(1, 15000))
// => "Please step aside: declare cash over 10000"
```
