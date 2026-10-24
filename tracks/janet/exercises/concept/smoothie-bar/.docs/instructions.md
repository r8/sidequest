# Instructions

Pip has opened a smoothie bar on the beach.
Customers shout their orders across the counter, the order screen types them in as best it can, and the result is a mess like `" Mango, banana ,,KIWI"`.
Pip wants a few small functions to turn those orders into something the blender and the till can use.
Every one of them is a pipeline of small steps — the perfect place for Janet's threading macros.

## 1. Clean up an ingredient name

Define the function `clean-name` that takes the raw name of one ingredient and returns it without surrounding whitespace and in lower case.

```janet
(clean-name "  Mango ")
# => "mango"
```

## 2. List the ingredients of an order

An order is a string of ingredient names separated by commas.
Define the function `ingredients` that takes an order and returns the cleaned names of its ingredients, in order, skipping any that are empty.

```janet
(ingredients " Mango, banana ,,KIWI")
# => @["mango" "banana" "kiwi"]
```

## 3. Price a smoothie

Define the function `blend-price` that takes an order and a struct mapping each ingredient name to its price, and returns the total price of the order's ingredients.

```janet
(blend-price "mango, kiwi" {"mango" 3 "kiwi" 2 "banana" 1})
# => 5
```

## 4. Count the free smoothies

Regulars collect a stamp for each smoothie, and every ten stamps earn a free one.
Define the function `free-smoothies` that takes a table of customers — each name maps to a struct with a `:stamps` count — and a name, and returns how many free smoothies that customer has earned.
It returns `nil` if the customer is unknown or has no `:stamps` entry.

```janet
(free-smoothies @{"Lou" {:stamps 23}} "Lou")
# => 2
(free-smoothies @{"Lou" {:stamps 23}} "Ana")
# => nil
```

## 5. Print the receipt line

Define the function `receipt` that takes an order and the price struct, and returns a line listing the cleaned ingredients joined by `" + "`, then `" = "` and the total price.

```janet
(receipt " Mango,KIWI" {"mango" 3 "kiwi" 2})
# => "mango + kiwi = 5"
```
