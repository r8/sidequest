# Instructions

The till at Dottie's corner shop prints its receipts through a little Forth program, and its formatting words have been lost.
All amounts are kept as whole numbers of cents, and every word leaves its text as `( c-addr u )`, valid until the next number is formatted.

## 1. Print a price

Define `price ( cents -- c-addr u )`, the price in dollars and cents with two digits after the point.
`cents` is never negative.

```forth
1250 price type   \ prints 12.50
5 price type      \ prints 0.05
```

## 2. Print a signed amount

Refunds are negative.
Define `amount ( cents -- c-addr u )`, like `price` but with a `-` in front of a negative amount.

```forth
-305 amount type   \ prints -3.05
```

## 3. Print a ticket number

Every receipt has a ticket number of exactly six digits.
Define `ticket-number ( n -- c-addr u )`, the number padded on the left with zeros to six digits.
`n` is from 0 to 999999.

```forth
42 ticket-number type   \ prints 000042
```

## 4. Print a product code

The shop's product codes are printed in hexadecimal.
Define `hex-code ( n -- c-addr u )`, the non-negative number `n` in hexadecimal, with upper-case letters and no leading zeros.
The number base must be the same after `hex-code` as before it.

```forth
48879 hex-code type   \ prints BEEF
```

## 5. Print the drawer code

The cash drawer is opened by eight on-off switches, printed as eight binary digits.
Define `binary-byte ( n -- c-addr u )`, `n` (from 0 to 255) as exactly eight binary digits.
The number base must be the same afterwards as before.

```forth
5 binary-byte type   \ prints 00000101
```
