# Hints

## General

- The Janet documentation's [functions](https://janet-lang.org/docs/functions.html) page covers `fn`, optional, variadic and named parameters.
- `(doc default)` at the REPL describes the `default` macro.

## 1. Price a drink

- Make the size an `&opt` parameter and give it a default.
- `case` maps each size keyword to its price.

## 2. Add the extras

- A parameter after `&` collects the remaining arguments.
- You only need to know how many extras there are.
- You can reuse `price`.

## 3. Print the order slip

- Parameters after `&named` are passed as `:name value` pairs.
- `string` turns a keyword into its name.
- Building the milk part as either `"oat "` or `""` keeps the rest simple.

## 4. Charge the customer

- A promotion is a function, so it can be called like any other.
- An optional parameter that was left out is `nil`, which is falsey.
