# Instructions

You have a summer job at the city archive. Thirty-year-old council files are being released to the public, but
before a file goes out, some of it has to be blacked out, some of it tidied up, and its secrecy level lowered.
The archivist hands you a stack of files and a pot of black ink; you decide a few BQN functions would be less
messy.

## 1. Black out marked characters

Write the function `BlackOut`. Its left argument is a mask, a list of `1`s and `0`s as long as the text; its
right argument is the text. It returns the text with every marked character replaced by `'█'`.

```bqn
0‿0‿1‿1‿0 BlackOut "ab12c"
# ⇒ "ab██c"
```

## 2. Hide the phone numbers

Write the function `HideDigits`. It takes a text and returns it with every digit `'0'` to `'9'` replaced by
`'#'`.

```bqn
HideDigits "Call 555-0199 now"
# ⇒ "Call ###-#### now"
```

## 3. Capitalise names

The scanner lost the capital letters. Write the function `Capitalise`. Its left argument is a list of indices
and its right argument a text; it returns the text with the lowercase letters at those indices turned into
capitals (subtract 32 from each).

```bqn
0‿6 Capitalise "alice brown"
# ⇒ "Alice Brown"
```

## 4. Lower the secrecy level

A file is a list whose first element is its secrecy level and whose other elements are its pages. Write the
function `Declassify`. It takes a file and returns it with the level lowered by one, but never below `0`.

```bqn
Declassify 3‿"Budget"‿"Roads"
# ⇒ 2‿"Budget"‿"Roads"
```

## 5. Round the budget figures

Exact amounts are still secret, only whole hundreds may be published. Write the function `RoundBudget`. It takes
a list of amounts and returns each rounded down to a multiple of 100.

```bqn
RoundBudget 1234‿99‿5000
# ⇒ 1200‿0‿5000
```
