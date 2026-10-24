# Instructions

The corner shop's old till died, and the new one prints nothing at all. Mrs. Haddad has found a tiny thermal
printer, twenty characters wide, and asks you to make it print receipts. Prices are kept in whole cents, so
nothing gets lost in rounding; the receipt shows them with two decimals.

## 1. Show a quantity

Write the function `Quantity`. Its left argument is how many of an item were bought and its right argument the
item's name; it returns the text `"<count> x <name>"`.

```bqn
3 Quantity "Apples"
# ⇒ "3 x Apples"
```

## 2. Show a price

Write the function `Cents`. It takes a price in cents (zero or more) and returns it as text with two decimals.

```bqn
Cents 1205
# ⇒ "12.05"
Cents 5
# ⇒ "0.05"
```

## 3. Align text to the right

Write the function `PadLeft`. Its left argument is a width and its right argument a text no longer than that;
it returns the text with spaces in front, so that it is exactly as wide as the width.

```bqn
6 PadLeft "4.50"
# ⇒ "  4.50"
```

## 4. Print a receipt line

Write the function `Line`. Its left argument is an item's name (at most 12 characters) and its right argument
its price in cents; it returns the 20-character line the printer prints: the name on the left and the price,
with two decimals, on the right.

```bqn
"Apples" Line 450
# ⇒ "Apples          4.50"
```

## 5. Read a price from the shelf label

The shelf labels are typed up as text such as `"12.05"`. Write the function `ParsePrice`. It takes such a text
and returns the price in whole cents.

```bqn
ParsePrice "12.05"
# ⇒ 1205
```
