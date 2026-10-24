# Instructions

Every Saturday, Bea sells vegetables from a stall at the farmers' market. Her prices change during the day: early
customers get the full price, regulars get a discount, and the last hour is a clearance. Instead of rewriting her
price list each time, she wants pricing _rules_ she can swap in and out. All prices are in cents.

## 1. Apply a rule to the price list

Define the `apply_rule` method, which takes the list of prices and a rule (a closure that turns a price into a new
price) and returns a new list with the rule applied to every price:

```inko
apply_rule([100, 250], fn (price) { price + 50 })
# => [150, 300]
```

## 2. Count the prices that match

Define the `count_where` method, which takes the list of prices and a test (a closure that returns whether a price
counts) and returns how many prices pass the test:

```inko
count_where([100, 250, 400], fn (price) { price > 200 })
# => 2
```

## 3. Make a discount rule

Define the `discount` method, which takes a percentage and returns a rule that takes that percentage off a price.
Divide with whole numbers, so any fraction of a cent is dropped from the discount:

```inko
discount(10).call(250)
# => 225
```

## 4. Make a price tag printer

Define the `price_tag` method, which takes a currency symbol and returns a closure that turns a price in cents into
a tag such as `'€2.05'`: the symbol, the whole units, a point, and the cents as two digits:

```inko
price_tag('€').call(205)
# => '€2.05'
```

## 5. Combine two rules

During the clearance hour, Bea applies one rule after another. Define the `combine` method, which takes two rules
and returns one rule that applies the first, then the second to the result:

```inko
combine(discount(50), fn (price) { price - 10 }).call(200)
# => 90
```
