# Hints

## General

- [The `std/core/int` documentation](https://koka-lang.github.io/koka/doc/std_core_int.html) lists the
  operations on integers.
- [The `std/num/float64` documentation](https://koka-lang.github.io/koka/doc/std_num_float64.html) lists the
  operations on floats; remember the `import`.

## 1. Count the trays

- Integer division rounds down. Adding something to the number of rolls before dividing can make it round up.

## 2. Count the empty places

- The trays from task 1 hold a known number of places in total.

## 3. Weigh the flour

- An `int` cannot be multiplied by a `float64` directly: convert it first.

## 4. Work out the daily average

- Both numbers are integers; convert both before dividing, or the fraction is lost.

## 5. Price an order

- Round up first, then turn the result into an `int`: `.int` alone rounds to the nearest whole number.
