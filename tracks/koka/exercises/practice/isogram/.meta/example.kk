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

fun all-distinct(cs : list<char>) : bool
  match cs
    Nil -> True
    Cons(c, rest) -> !rest.contains(c) && all-distinct(rest)

// is-isogram(phrase) -> whether no letter occurs more than once in `phrase`, ignoring case;
// spaces and hyphens may repeat
pub fun is-isogram(phrase : string) : bool
  // std's `is-alpha` is ASCII-only, so any other character that isn't white space counts as a letter
  phrase.list.filter(fn(c) c.is-alpha || (!c.is-ascii && !c.is-white)).map(lower).all-distinct
