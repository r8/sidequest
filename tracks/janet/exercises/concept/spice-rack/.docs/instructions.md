# Instructions

Tomás cooks for a small restaurant and keeps his spices in a rack of glass jars, each labelled with the spice and how many grams are left.
The labels smudge, the grams are always out of date, and he never knows what to order.
He asks you to keep the rack in a table instead: each key is a spice, such as `:cumin`, and each value is the grams left in its jar.

## 1. Tell where a spice comes from

Tomás buys a few spices from one trusted grower each, and the stub defines that list as the struct `origins`.
Define the function `origin` that takes a spice and returns where it comes from, or `"unknown"` when it is not in `origins`.

```janet
(origin :saffron)
# => "Iran"

(origin :salt)
# => "unknown"
```

## 2. Check how much is left

Define the function `grams-of` that takes the rack and a spice and returns the grams left of it, or `0` when the rack has no jar of it.

```janet
(grams-of @{:cumin 80 :clove 15} :cumin)
# => 80

(grams-of @{:cumin 80 :clove 15} :mace)
# => 0
```

## 3. Restock a spice

Define the function `restock` that takes the rack, a spice and a number of grams, adds the grams to that spice's jar — starting a new jar when there is none — and returns the rack.

```janet
(restock @{:cumin 80} :cumin 50)
# => @{:cumin 130}

(restock @{:cumin 80} :clove 25)
# => @{:cumin 80 :clove 25}
```

## 4. Use a spice

Define the function `use-spice` that takes the rack, a spice and a number of grams, takes the grams out of that spice's jar and returns the rack.
When a jar ends up with no spice left (zero grams or less), Tomás throws the jar away: remove the spice from the rack.

```janet
(use-spice @{:cumin 80 :clove 15} :cumin 30)
# => @{:cumin 50 :clove 15}

(use-spice @{:cumin 80 :clove 15} :clove 15)
# => @{:cumin 80}
```

## 5. List what to order

Define the function `low-stock` that takes the rack and a limit in grams and returns a new table of the spices that have fewer grams than the limit, with their grams.
The rack itself must not change.

```janet
(low-stock @{:cumin 80 :clove 15 :sumac 30} 50)
# => @{:clove 15 :sumac 30}
```
