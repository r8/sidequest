# Hints

## General

- The [search functions](https://mlochbaum.github.io/BQN/doc/search.html) documentation covers `⊐`, `∊` and `⊒`.
- [Self-search functions](https://mlochbaum.github.io/BQN/doc/selfcmp.html) covers `⍷`, monadic `∊` and
  monadic `⊐`.

## 1. Find the jars

- One primitive does exactly this, including the result for a missing spice.

## 2. Find what to buy

- Ask, for each spice of the recipe, whether it is on the rack.
- Then keep the ones for which the answer is no.

## 3. Use up the jars

- Index of always finds the first jar; you need a search that moves on to the next copy.

## 4. Write a shopping list

- Removing repeats while keeping the first copy is a single primitive.

## 5. Find the spare jars

- Mark the jars that are the first of their spice, then keep the others.
