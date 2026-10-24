# Instructions

Pigment & Co. mixes paint to order. Customers bring a recipe, a list of colours to mix in turn, and the shop's
mixing machine does the rest. The stub defines a `Colour` value type (red, green and blue amounts from 0 to 255) and
a `Recipe` type; write their methods.

## 1. Mix two colours

Define the `mix` method of `Colour`, which returns the colour halfway between two colours: for each of red, green
and blue, the average of the two, rounded down. Both colours stay as they were:

```inko
Colour.new(255, 0, 0).mix(Colour.new(255, 255, 255))
# => Colour.new(255, 127, 127)
```

## 2. Lighten a colour

Define the `lighter` method of `Colour`, which returns the colour with an amount added to each of red, green and
blue, never going above 255. It's an `fn move` method, so it can change the fields of its own copy and return it:

```inko
Colour.new(250, 100, 0).lighter(10)
# => Colour.new(255, 110, 10)
```

## 3. Print the hex code

Define the `hex` method of `Colour`, which returns the colour as a `#` followed by red, green and blue as two
lowercase hexadecimal digits each:

```inko
Colour.new(255, 128, 0).hex
# => '#ff8000'
```

## 4. Mix a recipe

Define the `paint` method of `Recipe`, which mixes the colours of the recipe in order: the first with the second,
the result with the third, and so on. A recipe without colours gives black, `Colour.new(0, 0, 0)`:

```inko
Recipe.new('Dusk', [red, white, blue]).paint
# => Colour.new(127, 63, 191)
```

## 5. Copy a recipe

Implement `clone` for `Recipe`, which returns a copy that can be changed without changing the original:

```inko
let copied = recipe.clone
```

## 6. Make a variant

Define the `variant` method of `Recipe`, which returns a new recipe with a new name and one more colour mixed in last,
leaving the original recipe as it was:

```inko
Recipe.new('Rose', [red, white]).variant('Dusk', blue).colours
# => [red, white, blue]
```
