# Instructions

Hannelore has inherited her grandmother's recipe box.
Half the cards are in grams and kilograms, the other half in ounces and pounds, and Hannelore wants one tool that turns any recipe into a shopping list in grams.
She has already decided how to split the code: a small `units` module that knows about weights, and the recipe book itself, which imports it.

Your solution has two files, `units.janet` and `recipe-book.janet`.
A recipe is a tuple of lines, and each line is a tuple of an ingredient's name, an amount and a unit keyword:

```janet
[["flour" 1 :kg] ["water" 700 :g] ["salt" 20 :g]]
```

## 1. Convert to grams

In `units.janet`, define the function `to-grams` that takes an amount and a unit — `:g`, `:kg`, `:oz` or `:lb` — and returns the amount in grams.
One kilogram is 1000 grams, an ounce counts as 28 grams and a pound as 454 grams.
Keep the table of conversion factors in a definition called `grams-per`, private to the module.

```janet
(to-grams 8 :oz)
# => 224
```

## 2. Format a weight

In `units.janet`, define the function `format-grams` that takes a weight in grams and returns it as text: below 1000 grams in grams, otherwise in kilograms.

```janet
(format-grams 250)
# => "250 g"
(format-grams 1500)
# => "1.5 kg"
```

## 3. Weigh the ingredients

In `recipe-book.janet`, import the `units` module.
Then define the function `in-grams` that takes a recipe and returns a table from each ingredient's name to its weight in grams.

```janet
(in-grams [["butter" 8 :oz] ["flour" 250 :g]])
# => @{"butter" 224 "flour" 250}
```

## 4. Write the shopping list

In `recipe-book.janet`, define the function `shopping-list` that takes a recipe and a factor to scale it by, and returns an array with one line per ingredient, in the recipe's order: its name, `": "`, and its scaled weight formatted by `format-grams`.

```janet
(shopping-list [["flour" 1 :kg] ["water" 700 :g]] 3)
# => @["flour: 3 kg" "water: 2.1 kg"]
```

## 5. Weigh the whole recipe

In `recipe-book.janet`, define the function `total-weight` that takes a recipe and returns the total weight of its ingredients, formatted by `format-grams`.

```janet
(total-weight [["flour" 1 :kg] ["water" 700 :g] ["salt" 20 :g]])
# => "1.72 kg"
```
