# Instructions

Wren is apprenticed to Ondine, a wizard with an unusual spell book: every spell in it is written as a Janet form.
A spell is a list whose first element is the spell's name, a symbol, followed by its arguments: `(fireball 3)`.
Before Wren may cast anything, she has to learn to read, write and combine the spells.

## 1. Name a spell

Spell names are made of words joined by dashes.
Define the function `spell-name` that takes an array or tuple of words (strings) and returns the spell's name as a symbol.

```janet
(spell-name ["frost" "nova"])
# => frost-nova
```

## 2. Recognise a spell

Define the function `spell?` that takes any value and returns `true` when it is a spell — a tuple written with parentheses whose first element is a symbol — and `false` otherwise.

```janet
(spell? '(fireball 3))
# => true

(spell? '[fireball 3])
# => false
```

## 3. Write a spell

Define the function `write-spell` that takes a spell name (a symbol) and a power (a number) and returns the spell that casts it with that power.

```janet
(write-spell 'fireball 3)
# => (fireball 3)
```

## 4. Chain spells

Ondine casts several spells in a row by putting them in a `do`.
Define the function `chain` that takes an array or tuple of spells and returns one form that casts them in order.

```janet
(chain ['(fireball 3) '(frost-nova 2)])
# => (do (fireball 3) (frost-nova 2))
```

## 5. Brew a potion

A potion's strength is written as an arithmetic spell: an operator, such as `+` or `*`, applied to amounts of ingredients.
Define the function `brew` that takes an operator (a symbol) and an array or tuple of amounts, and returns the strength of the potion: the value of applying the operator to the amounts.
Build the form and evaluate it.

```janet
(brew '* [2 3 4])
# => 24
```
