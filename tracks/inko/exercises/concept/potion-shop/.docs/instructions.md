# Instructions

Wren runs a tiny apothecary in the market square, selling potions brewed in the back room. She sells three kinds:
healing potions, which come in different strengths; invisibility potions, which last a number of minutes; and
luck potions, which are always the same. Her potions come in three kinds of bottle. The stub defines both as enums;
your job is to write their methods.

## 1. Measure the bottles

A vial holds 50 millilitres and a flask 250. Barrels come in different sizes, given in litres. Define the
`millilitres` method of `Bottle`:

```inko
Bottle.Flask.millilitres
# => 250
Bottle.Barrel(40).millilitres
# => 40000
```

## 2. Price a potion

Healing costs 10 silver coins per point of strength, invisibility 3 coins per minute, and luck always 100 coins.
Define the `price` method of `Potion`:

```inko
Potion.Healing(3).price
# => 30
```

## 3. Label a bottle

Define the `label` method of `Potion`, which returns `'Healing (strength N)'`, `'Invisibility (N min)'` or
`'Luck'`:

```inko
Potion.Invisibility(20).label
# => 'Invisibility (20 min)'
```

## 4. Brew it stronger

For a special order, Wren doubles the strength of a healing potion or the minutes of an invisibility potion; luck
can't be improved. Define the `stronger` method of `Potion`, which returns the stronger potion:

```inko
Potion.Healing(3).stronger
# => Potion.Healing(6)
```

## 5. Take an order

Orders come in as the kind of potion (`'healing'`, `'invisibility'` or `'luck'`) and an amount, which is the
strength or the minutes, and is ignored for luck. Define the `brew` method, which returns the potion, or `None` for a
kind Wren doesn't make:

```inko
brew('healing', 2)
# => Option.Some(Potion.Healing(2))
brew('flying', 1)
# => Option.None
```
