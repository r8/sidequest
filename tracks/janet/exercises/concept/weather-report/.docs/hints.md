# Hints

## General

- The Janet documentation's [strings, keywords and symbols](https://janet-lang.org/docs/strings.html) page describes keywords.
- The [core API](https://janet-lang.org/api/index.html) documents `keyword` and `string`.

## 1. Classify the temperature

- A chain of thresholds tested in order is what `cond` is for.
- The results are keyword literals.

## 2. Give advice

- Comparing one value against several fixed keywords is what `case` is for.

## 3. Read the logbook

- Clean up the text first: remove the spaces around it and make it lower case.
- Then turn the result into a keyword.

## 4. Spot wet weather

- Combine three comparisons with `or`.

## 5. Write the report

- `string` accepts keywords and leaves out their colon.
- You can reuse `classify`.
