# Instructions

Your kitchen has a long spice rack: a row of labelled jars, numbered from 0 on the left. Some spices have
more than one jar, because you keep buying salt without checking. Before you cook, you want the computer to
tell you where everything is.

The rack and every recipe are lists of spice names.

## 1. Find the jars

Write the function `Slots`. Its left argument is the rack and its right argument a list of spices; it returns
the slot of the first jar of each spice, or the number of jars on the rack for a spice that is not there.

```bqn
"basil"‿"cumin"‿"dill" Slots "dill"‿"salt"
# ⇒ ⟨ 2 3 ⟩
```

## 2. Find what to buy

Write the function `Missing`. Its left argument is the rack and its right argument a recipe; it returns the
spices of the recipe that are not on the rack, in the recipe's order.

```bqn
"basil"‿"cumin"‿"dill" Missing "salt"‿"cumin"‿"saffron"
# ⇒ ⟨ "salt" "saffron" ⟩
```

## 3. Use up the jars

Each step of a big recipe empties a whole jar. Write the function `JarsFor`. Its left argument is the rack and
its right argument the spices of the steps, in order; it returns the slot of the jar each step uses, never
using a jar twice, or the number of jars on the rack when no full jar of that spice is left.

```bqn
"salt"‿"dill"‿"salt" JarsFor "salt"‿"salt"‿"salt"
# ⇒ ⟨ 0 2 3 ⟩
```

## 4. Write a shopping list

Write the function `Restock`. It takes a list of spices that ran out, with repeats, and returns each spice
once, in the order it first appears.

```bqn
Restock "salt"‿"dill"‿"salt"‿"cumin"‿"dill"
# ⇒ ⟨ "salt" "dill" "cumin" ⟩
```

## 5. Find the spare jars

Write the function `Spares`. It takes the rack and returns the jars that repeat a spice already on the rack to
their left, in order.

```bqn
Spares "salt"‿"dill"‿"salt"‿"cumin"‿"salt"
# ⇒ ⟨ "salt" "salt" ⟩
```
