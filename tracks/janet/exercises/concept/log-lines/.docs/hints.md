# Hints

## General

- [Parsing Expression Grammars](https://janet-lang.org/docs/peg.html) in the Janet documentation lists every pattern.
- The [peg module](https://janet-lang.org/api/peg.html) describes `peg/match`, `peg/find`, `peg/replace` and `peg/replace-all`.

## 1. Read the level

- A sequence: the opening bracket, a choice of three words captured, the closing bracket.
- `peg/match` returns an array of captures or `nil`; the `keyword` and `string/ascii-lower` functions finish the job.

## 2. Read the time

- `thru` skips everything up to and including a pattern.
- `(2 :d)` matches exactly two digits; capture both groups.
- `scan-number` turns `"06"` into `6`.

## 3. List the trams

- Use a pattern that either captures a tram number or skips one character, repeated over the whole text.

## 4. Redact badge numbers

- `peg/replace-all` takes the pattern, the replacement and the text, and returns a buffer.

## 5. Find the first error

- `peg/find` returns the position of the first match.
