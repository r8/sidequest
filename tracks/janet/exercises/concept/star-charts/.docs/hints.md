# Hints

## General

- [Destructuring](https://janet-lang.org/docs/destructuring.html) in the Janet documentation shows every pattern used here.
- A pattern can go anywhere a name is bound: `def`, `let`, a function's parameters, `each`.

## 1. Measure the distance between two points

- The parameter list can take both tuples apart: `[[x1 y1] [x2 y2]]`.
- The distance is the square root (`math/sqrt`) of the sum of the squared differences.

## 2. Label a star

- A struct pattern only needs the keys you use.

## 3. Introduce the evening

- `& others` in a tuple pattern collects everything after the first element.

## 4. Move a star on the chart

- A pattern can take the position apart inside the struct pattern.
- Build the result as a new struct literal.

## 5. Flip the chart for the southern sky

- `map` with an `fn` whose parameter is a pattern.
