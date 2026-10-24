# Instructions

Every winter the birding club counts the water birds on the lake. Volunteers walk the shore, and every time one
of them sees a bird, they call it in. Nadia, who coordinates the count, is writing the program that keeps the
tally. The volunteers' walks are actions that use two effects, declared for you in the stub:

```koka
pub effect fun spot(bird : string) : ()

pub effect fun ticket() : int
```

`spot` reports one bird seen, by species, such as `"mallard"`. `ticket` hands out the number for a new
volunteer's badge.

## 1. Number the volunteers

Define the `numbered` function: it takes the first ticket number and an action, and runs the action with every
`ticket` returning the next number, starting at the first one.

```koka
numbered(100) { [ticket(), ticket(), ticket()] }
// => [100, 101, 102]
```

## 2. Count the sightings

Define the `count-spots` function: it takes an action and runs it, returning its result paired with the number
of birds it spotted.

```koka
count-spots { spot("mallard"); spot("coot"); "north shore" }
// => ("north shore", 2)
```

## 3. Keep the log

Define the `spotted` function: it takes an action and runs it, returning its result paired with the list of the
birds it spotted, in the order they were spotted.

```koka
spotted { spot("mallard"); spot("coot"); spot("mallard"); 3 }
// => (3, ["mallard", "coot", "mallard"])
```

## 4. Count the species

For the club's report only the number of different species matters. Define the `species` function: it takes an
action and runs it, and returns how many different species it spotted, ignoring the action's result.

```koka
species { spot("mallard"); spot("coot"); spot("mallard"); "done" }
// => 2
```
