# Hints

## General

- The threading macros are listed in the core API: [`->`](https://janet-lang.org/api/index.html#->), [`->>`](https://janet-lang.org/api/index.html#->>), [`-?>`](https://janet-lang.org/api/index.html#-?>) and [`as->`](https://janet-lang.org/api/index.html#as->).
- The [string functions](https://janet-lang.org/api/string.html) take the string first, the sequence functions take the collection last.

## 1. Clean up an ingredient name

- `string/trim` and `string/ascii-lower` take the string as their only argument.

## 2. List the ingredients of an order

- `string/split` takes the separator first and the string last.
- After splitting, clean every piece, then keep only the non-empty ones; `empty?` tells you whether a string has no characters.

## 3. Price a smoothie

- Reuse `ingredients`, look every name up in the price struct, and add the prices up with `sum`.

## 4. Count the free smoothies

- Each lookup can produce `nil`; one of the arrows stops at the first `nil`.
- Whole free smoothies: integer division with `div`.

## 5. Print the receipt line

- `string/join` takes the collection first and the separator second.
- `string` concatenates its arguments; you can thread a value into its first position.
