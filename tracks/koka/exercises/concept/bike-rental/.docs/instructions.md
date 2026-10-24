# Instructions

Rosa rents out bicycles from a shed by the lake. For years she kept track of them in a notebook; now she wants a
small program that knows, for each bike, its number, its model, who is riding it and how far it has gone. The
`bike` struct is already defined in `bike-rental.kk` — a bike with an empty `rider` is in the shed.

## 1. Add a bike to the fleet

Define `new-bike`: it takes a bike's number and model and returns a bike with no rider that has not been ridden
at all.

```koka
new-bike(7, "Gazelle")
// => Bike(number = 7, model = "Gazelle", rider = "", km = 0)
```

## 2. See whether a bike is free

Define `is-available`: it takes a bike and returns whether it is in the shed, which is when nobody is riding it.

```koka
new-bike(7, "Gazelle").is-available
// => True
```

## 3. Rent a bike out

Define `rent`: it takes a bike and the name of a rider, and returns the bike as it is while that rider has it.

```koka
new-bike(7, "Gazelle").rent("Tomás").rider
// => "Tomás"
```

## 4. Take a bike back

Define `return-bike`: it takes a bike and the kilometres it was just ridden, and returns it back in the shed with
those kilometres added to its total.

```koka
new-bike(7, "Gazelle").rent("Tomás").return-bike(12).km
// => 12
```

## 5. Print a tag

Define `tag`: it takes a bike and returns the line Rosa prints on its tag — the number, the model and the
kilometres — and, if someone is riding it, who.

```koka
Bike(7, "Gazelle", "", 120).tag
// => "#7 Gazelle, 120 km"
Bike(3, "Batavus", "Ines", 45).tag
// => "#3 Batavus, 45 km, out with Ines"
```
