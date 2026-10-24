# Instructions

Juniper has just opened a coffee cart by the river.
She sells one menu of drinks in three sizes, takes every order on a tablet, and wants the tablet to work out prices and print order slips for her.

## 1. Price a drink

A small drink costs 3, a medium 4 and a large 5.
Most customers do not say which size they want, and then they get a medium.
Define the function `price` that takes an optional size (`:small`, `:medium` or `:large`) and returns the price.

```janet
(price :large)
# => 5
(price)
# => 4
```

## 2. Add the extras

Customers can add extras to a drink — a shot of syrup, extra foam, a dusting of cinnamon — and every extra costs 0.5.
Define the function `price-with-extras` that takes the size followed by any number of extras (as strings) and returns the price of the drink with them.

```janet
(price-with-extras :small "vanilla" "cinnamon")
# => 4
```

## 3. Print the order slip

The slip on each cup names the size, the milk if the customer asked for one, and the drink: `"large oat latte"`, `"medium mocha"`.
Define the function `describe-order` that takes the drink and the named arguments `:size` (a keyword, `:medium` when it is left out) and `:milk` (a string, no milk when it is left out), and returns the slip.

```janet
(describe-order "latte" :milk "oat" :size :large)
# => "large oat latte"
(describe-order "mocha")
# => "medium mocha"
```

## 4. Charge the customer

On some days Juniper runs a promotion, and a promotion is a function that takes an amount and returns the amount to charge instead.
Define the function `charge` that takes an amount and an optional promotion, and returns the amount with the promotion applied, or the amount itself when there is no promotion.

```janet
(charge 8 (fn [amount] (- amount 1)))
# => 7
(charge 8)
# => 8
```
