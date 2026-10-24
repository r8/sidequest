# Instructions

Mabel runs the breakfast griddle at the Short Stack Diner.
Every order is a stack of pancakes, and Mabel wants a few words to do the sums while she flips.

## 1. Count the pancakes for a table

Each guest gets three pancakes, but Mabel never makes fewer than six: a smaller batch of batter is not worth mixing.
Define `pancakes-for ( guests -- pancakes )`.

```forth
4 pancakes-for   \ leaves 12
1 pancakes-for   \ leaves 6
```

## 2. Measure the stack

A pancake is 8 mm thick, and every stack gets a 5 mm pat of butter on top.
Define `stack-height ( pancakes -- mm )`.

```forth
3 stack-height   \ leaves 29
```

## 3. Fill the plates

A plate holds four pancakes.
Define `full-plates ( pancakes -- plates )`, the number of plates that can be filled completely.

```forth
10 full-plates   \ leaves 2
```

## 4. Keep the spares

Define `spare-pancakes ( pancakes -- spare )`, the pancakes left over after filling as many plates as possible.

```forth
10 spare-pancakes   \ leaves 2
```

## 5. Plan the griddle

The griddle cooks six pancakes at a time.
Define `griddle-rounds ( pancakes -- rounds )`, how many rounds it takes to cook them all; a round that is not full still counts.

```forth
12 griddle-rounds   \ leaves 2
13 griddle-rounds   \ leaves 3
```
