# Instructions

Rosa is writing a little kitchen helper for her bakery, where recipes come from three countries and nobody agrees on what a cup is.
Rather than write a word for every unit, every timer and every shelf by hand, she wants words that make them.

## 1. Define units

Define `unit ( ml "name" -- )`, which defines a unit of `ml` millilitres: a word `name ( n -- ml )` that converts `n` of that unit to millilitres.

```forth
250 unit cups
15 unit tablespoons
2 cups 3 tablespoons +   \ leaves 545
```

## 2. Count the stirs

Define `counter ( "name" -- )`, which defines a word `name ( -- n )` that counts how many times it has been used: it leaves 1 the first time, 2 the second, and so on.

```forth
counter stirs
stirs stirs stirs   \ leaves 1 2 3
```

## 3. Start counting again

Define `reset-counter ( xt -- )`, which sets the counter whose execution token it is given back to the start, so that its next use leaves 1.

```forth
' stirs reset-counter
stirs   \ leaves 1
```

## 4. Label the spice shelves

Define `shelf ( n "name" -- )`, which defines a shelf of `n` jars: a word `name ( i -- addr )` that leaves the address of jar `i`, a cell for the grams of spice in it, counting from 0.
Every jar starts empty, holding 0.

```forth
4 shelf spices
30 2 spices !
2 spices @   \ leaves 30
0 spices @   \ leaves 0
```
