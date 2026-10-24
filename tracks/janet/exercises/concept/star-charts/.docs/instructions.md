# Instructions

Kofi runs the stargazing evenings at the observatory, and he is writing a little program to plan them.
Each star in his chart is a struct with its name, its constellation, its magnitude (smaller is brighter) and its position on the chart as an `[x y]` tuple:

```janet
{:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [4 7]}
```

Help him with the functions he needs.
Every one of them can take its arguments apart with destructuring.

## 1. Measure the distance between two points

Define the function `distance` that takes two positions, each an `[x y]` tuple, and returns the straight-line distance between them.

```janet
(distance [1 1] [4 5])
# => 5
```

## 2. Label a star

Define the function `label` that takes a star and returns its name and constellation in the form `"<name> in <constellation>"`.

```janet
(label {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [4 7]})
# => "Vega in Lyra"
```

## 3. Introduce the evening

Kofi's list for the evening is a tuple of stars with the brightest first.
Define the function `headline` that takes such a list, which has at least one star, and returns a struct with the name of the brightest star under `:brightest` and how many other stars there are under `:others`.

```janet
(headline [{:name "Sirius" :constellation "Canis Major" :magnitude -1.46 :position [2 2]}
           {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [4 7]}])
# => {:brightest "Sirius" :others 1}
```

## 4. Move a star on the chart

When the chart is redrawn, stars shift.
Define the function `shift` that takes a star and the change in `x` and `y`, and returns a new star struct with the same name, constellation and magnitude at the shifted position.

```janet
(shift {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [4 7]} 1 -2)
# => {:name "Vega" :constellation "Lyra" :magnitude 0.03 :position [5 5]}
```

## 5. Flip the chart for the southern sky

Define the function `flip` that takes a tuple of positions and returns an array of the positions mirrored top to bottom: each `[x y]` becomes `[x (- y)]`.

```janet
(flip [[4 7] [2 -2]])
# => @[[4 -7] [2 2]]
```
