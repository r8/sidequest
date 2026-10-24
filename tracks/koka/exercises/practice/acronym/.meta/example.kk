// The lower-case partner of a capital in ASCII, Latin-1, Latin Extended-A, Greek or Cyrillic, else `c`
// (std's `to-lower` only changes ASCII letters).
fun lower(c : char) : char
  val n = c.int
  val offset =
    if (n >= 0x41 && n <= 0x5A) || (n >= 0xC0 && n <= 0xDE && n != 0xD7) then 0x20
    elif n >= 0x100 && n <= 0x17F && n != 0x130 && n != 0x131 && n != 0x138 && n != 0x149 && n != 0x17F then
      (if n == 0x178 then 0xFF - 0x178 elif (n >= 0x139 && n <= 0x148) || n >= 0x179 then n % 2 else 1 - n % 2)
    elif n == 0x386 then 38
    elif n >= 0x388 && n <= 0x38A then 37
    elif n == 0x38C then 64
    elif n == 0x38E || n == 0x38F then 63
    elif (n >= 0x391 && n <= 0x3A1) || (n >= 0x3A3 && n <= 0x3AB) || (n >= 0x410 && n <= 0x42F) then 0x20
    elif n >= 0x400 && n <= 0x40F then 0x50
    else 0
  (n + offset).char

// The capital partner of a lower-case letter in ASCII, Latin-1, Latin Extended-A, Greek or Cyrillic,
// else `c` (std's `to-upper` only changes ASCII letters).
fun upper(c : char) : char
  val n = c.int
  val offset =
    if (n >= 0x61 && n <= 0x7A) || (n >= 0xE0 && n <= 0xFE && n != 0xF7) then 0x20
    elif n == 0xFF then 0xFF - 0x178
    elif n >= 0x100 && n <= 0x17F && n != 0x130 && n != 0x131 && n != 0x138 && n != 0x149 && n != 0x17F then
      (if (n >= 0x139 && n <= 0x148) || n >= 0x179 then 1 - n % 2 else n % 2)
    elif n == 0x3AC then 38
    elif n >= 0x3AD && n <= 0x3AF then 37
    elif n == 0x3CC then 64
    elif n == 0x3CD || n == 0x3CE then 63
    elif n == 0x3C2 then 31
    elif (n >= 0x3B1 && n <= 0x3C1) || (n >= 0x3C3 && n <= 0x3CB) || (n >= 0x430 && n <= 0x44F) then 0x20
    elif n >= 0x450 && n <= 0x45F then 0x50
    else 0
  (n - offset).char

// abbreviate(phrase) -> the uppercase acronym of `phrase`: the first letter of each word, where words are
// separated by whitespace and hyphens, and other punctuation is ignored
pub fun abbreviate(phrase : string) : exn string
  val spaced = phrase.list.map(fn(c) if c == '-' || c.is-white then ' ' else c).string
  spaced.split(" ")
    .filter-map(fn(word) word.list.filter(fn(c) c.is-alpha || c.lower != c || c.upper != c).head)
    .map(upper)
    .string
