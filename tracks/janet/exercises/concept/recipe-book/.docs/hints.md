# Hints

## General

- [Modules](https://janet-lang.org/docs/modules.html) in the Janet documentation covers `import`, `use`, prefixes and private bindings.
- [`import`](https://janet-lang.org/api/index.html#import) in the core API lists all of its options.

## 1. Convert to grams

- A struct from unit keywords to factors makes the conversion one lookup and one multiplication.
- `def-` defines a binding the importing file cannot see.

## 2. Format a weight

- Dividing by 1000 with `/` gives `1.5` for 1500 and `1` for 1000, and `string` turns both into text.

## 3. Weigh the ingredients

- The path of a module next to the current file starts with `./`, and leaves off `.janet`.
- After `(import ./units)`, the module's functions are called `units/to-grams` and `units/format-grams`; `:as` picks another prefix.
- A small private helper that converts one line of a recipe is useful in this task and the next two.

## 4. Write the shopping list

- Scale the weight in grams, then format it.

## 5. Weigh the whole recipe

- Add up the lines' weights in grams first, and format only the total.
