# Hints

## General

- [Formatted numeric output](https://gforth.org/manual/Formatted-numeric-output.html) in the Gforth manual describes `<#`, `#`, `#s`, `hold`, `sign` and `#>`.
- [Number conversion](https://gforth.org/manual/Number-Conversion.html) covers `base`, `hex` and `decimal`.

## 1. Print a price

- The picture is built from the right: two single digits, then the point, then whatever is left.

## 2. Print a signed amount

- Convert the absolute value, and keep the original number underneath to decide the sign at the end.

## 3. Print a ticket number

- `#` always adds a digit, even a zero.

## 4. Print a product code

- Save the old base on the return stack, change it, build the picture, then restore it.

## 5. Print the drawer code

- This is Task 3's padding in a different base; a counted loop can add the eight digits.
