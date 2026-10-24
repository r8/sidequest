# Instructions

Ines has wired her vegetable garden to a sprinkler controller with one valve per bed. The controller runs
programs she writes in Koka, and she wants a few building blocks so the programs read like her watering notes:
"for every bed, soak twice".

A garden is a list of bed names. Beds that are switched off for the season have names starting with `#`, such
as `"#strawberries"`, and are never watered.

## 1. Soak twice

Define the `twice` function: it takes an action and runs it two times, one after the other.

```koka
with twice
println("click")
// prints "click" twice
```

## 2. Visit every bed that is switched on

Define the `each-bed` function: it takes the garden and an action that takes a bed name, and runs the action
for every bed in order, skipping the beds that are switched off.

```koka
with bed <- each-bed(["carrots", "#strawberries", "kale"])
println(bed)
// prints "carrots", then "kale"
```

## 3. Plan the rounds

Ines waters in rounds: in each round every bed that is switched on gets the water once. Define the `round-plan`
function: it takes the garden and the number of rounds, and returns the plan as a list of entries
`"round <n>: <bed>"`, in the order the controller runs them.

```koka
round-plan(["carrots", "#strawberries", "kale"], 2)
// => ["round 1: carrots", "round 1: kale", "round 2: carrots", "round 2: kale"]
```

## 4. Plan a double soak

On hot days every bed that is switched on gets two soaks in a row before the controller moves on. Define the
`double-soak` function: it takes the garden and returns the beds in the order they are watered, a bed appearing
once per soak.

```koka
double-soak(["carrots", "#strawberries", "kale"])
// => ["carrots", "carrots", "kale", "kale"]
```
