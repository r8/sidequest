# Hints

## General

- [Atop and Over](https://mlochbaum.github.io/BQN/doc/compose.html) describe `∘` and `○`.
- [Before and After](https://mlochbaum.github.io/BQN/doc/hook.html) describe `⊸` and `⟜`, including binding a
  value.
- [Self and Swap](https://mlochbaum.github.io/BQN/doc/swap.html) describe `˜`.

## 1. Convert Celsius to Fahrenheit

- Bind each number to its function with `⊸` or `⟜`, then join the two steps with `∘`.
- The step that happens first goes on the right.

## 2. Convert Fahrenheit to Celsius

- Put the number on the side of the function where it belongs: `32 - f` and `f - 32` are not the same.

## 3. Add up two rides

- Both arguments need the same conversion before they are added.

## 4. Check the luggage allowance

- The limit is on the right, but it is the one you subtract from.

## 5. Measure a hotel room

- Convert the side first, then multiply it by itself.
