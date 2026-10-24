# Instructions

Ines sells vegetable seeds at the weekend market and is putting her catalogue online.
Each kind of seed is a struct with its variety name, its crop and the days from sowing to harvest:

```janet
(def catalog
  [{:name "Cherry Belle" :crop :radish :days 25}
   {:name "Nantes" :crop :carrot :days 70}
   {:name "Little Gem" :crop :lettuce :days 50}
   {:name "French Breakfast" :crop :radish :days 28}])
```

Customers ask the same questions every weekend, so she wants functions that answer them.
None of them may change the catalogue.

## 1. List the varieties

Define the function `seed-names` that takes a catalogue and returns an array of the variety names, in catalogue order.

```janet
(seed-names catalog)
# => @["Cherry Belle" "Nantes" "Little Gem" "French Breakfast"]
```

## 2. Find the quick growers

Define the function `quick-seeds` that takes a catalogue and a number of days and returns an array of the seeds that are ready to harvest within that many days, in catalogue order.

```janet
(quick-seeds catalog 30)
# => @[{:name "Cherry Belle" :crop :radish :days 25}
#      {:name "French Breakfast" :crop :radish :days 28}]
```

## 3. Count the varieties of a crop

Define the function `count-crop` that takes a catalogue and a crop and returns how many varieties of that crop the catalogue has.

```janet
(count-crop catalog :radish)
# => 2
```

## 4. Find the longest wait

Define the function `longest-wait` that takes a catalogue and returns the most days any of its seeds takes to be ready, or `0` for an empty catalogue.

```janet
(longest-wait catalog)
# => 70
```

## 5. Check a catalogue for impatient gardeners

Define the function `all-quick?` that takes a catalogue and a number of days and returns `true` when every seed in it is ready within that many days, and `false` otherwise.

```janet
(all-quick? catalog 70)
# => true

(all-quick? catalog 60)
# => false
```
