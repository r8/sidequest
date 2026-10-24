# Instructions

Odile is the yard master at a small freight depot where trains are put together car by car.
Each train is kept as an array of its cars, from the engine at index 0 to the last car at the end, and every car is a string such as `"engine"`, `"coal"` or `"mail"`.
She asks you for a handful of functions to shunt the cars around.

## 1. Couple a car

Define the function `couple-car` that takes a train and a car, adds the car to the end of the train, and returns the train.

```janet
(couple-car @["engine" "coal"] "mail")
# => @["engine" "coal" "mail"]
```

## 2. Uncouple the last car

Define the function `uncouple-last` that takes a train, removes its last car, and returns that car.
For a train without any cars, it returns `nil`.

```janet
(uncouple-last @["engine" "coal" "mail"])
# => "mail"
```

## 3. Look up a car

Define the function `car-at` that takes a train and a position (0 is the engine) and returns the car at that position, or `nil` if the train is not that long.

```janet
(car-at @["engine" "coal" "mail"] 1)
# => "coal"
```

## 4. Insert a car

Sometimes a car has to go in the middle of a train.
Define the function `insert-car` that takes a train, a position and a car, inserts the car at that position — moving the cars from there on one place back — and returns the train.

```janet
(insert-car @["engine" "mail"] 1 "coal")
# => @["engine" "coal" "mail"]
```

## 5. Write the manifest

When a train leaves the depot, its list of cars goes on the manifest, which must not change even when the cars are shunted around later.
Define the function `manifest` that takes a train and returns its cars as a tuple.

```janet
(manifest @["engine" "coal" "mail"])
# => ["engine" "coal" "mail"]
```
