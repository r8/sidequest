// Koka's character tests are ASCII-only and it has no Unicode tables, so these ranges cover the
// common cases: the punctuation, symbol, space and combining-mark blocks, and the decimal digits of
// the major scripts, are not letters; any other non-ASCII character is.
val non-letters = [
  (0x80, 0xA9), (0xAB, 0xB4), (0xB6, 0xB9), (0xBB, 0xBF), (0xD7, 0xD7), (0xF7, 0xF7),
  (0x300, 0x36F),                              // combining marks
  (0x660, 0x669), (0x6F0, 0x6F9), (0x966, 0x96F), (0x9E6, 0x9EF), (0xE50, 0xE59),   // digits
  (0x2000, 0x2BFF), (0x2E00, 0x2E7F),          // spaces, punctuation, symbols, arrows, …
  (0x3000, 0x3004), (0x3007, 0x303F),          // CJK spaces and punctuation
  (0xFEFF, 0xFEFF), (0xFF01, 0xFF20), (0xFF3B, 0xFF40), (0xFF5B, 0xFF65),   // fullwidth forms
  (0x1F000, 0x1FAFF),                          // emoji and pictographs
]

fun is-letter(c : char) : bool
  if c.is-ascii then c.is-alpha
  else !non-letters.any(fn((lo, hi)) c.int >= lo && c.int <= hi)

// Lower-cases the capitals of ASCII, Latin-1, Latin Extended-A, Greek and Cyrillic.
fun to-lower(c : char) : char
  val n = c.int
  val offset =
    if (n >= 0x41 && n <= 0x5A) || (n >= 0xC0 && n <= 0xDE && n != 0xD7) then 0x20
    elif n >= 0x100 && n <= 0x17F && n != 0x130 && n != 0x131 && n != 0x138 && n != 0x149 && n != 0x17F then
      (if n == 0x178 then 0xFF - 0x178 elif (n >= 0x139 && n <= 0x148) || n >= 0x179 then (n % 2) else 1 - (n % 2))
    elif n == 0x386 then 38
    elif n >= 0x388 && n <= 0x38A then 37
    elif n == 0x38C then 64
    elif n == 0x38E || n == 0x38F then 63
    elif (n >= 0x391 && n <= 0x3A1) || (n >= 0x3A3 && n <= 0x3AB) || (n >= 0x410 && n <= 0x42F) then 0x20
    elif n >= 0x400 && n <= 0x40F then 0x50
    else 0
  (n + offset).char

// Adds `n` to the count of `c` in `counts`, which is sorted by letter.
fun add(counts : list<(char, int)>, c : char, n : int) : list<(char, int)>
  match counts
    Cons((d, m), rest) | d < c -> Cons((d, m), add(rest, c, n))
    Cons((d, m), rest) | d == c -> Cons((d, m + n), rest)
    _ -> Cons((c, n), counts)

// The letter counts of one text.
fun count-letters(text : string) : list<(char, int)>
  text.list.filter(is-letter).foldl([], fn(acc, c) add(acc, c.to-lower, 1))

// calculate-frequencies(texts) -> how often each letter occurs across all of `texts`, ignoring case,
// as a list of (lowercase letter, count) sorted by letter.
// (Koka's standard library has no threads to count in parallel with; counting each text
// separately and merging the counts keeps the spirit of the exercise.)
pub fun calculate-frequencies(texts : list<string>) : list<(char, int)>
  texts.map(count-letters).foldl([], fn(total, counts) counts.foldl(total, fn(acc, (c, n)) add(acc, c, n)))
