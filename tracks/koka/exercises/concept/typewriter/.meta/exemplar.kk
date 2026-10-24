// is-vowel(c) -> whether `c` is a vowel, in either case
pub fun is-vowel(c : char) : bool
  "aeiouAEIOU".list.contains(c)

// capital(c) -> the upper-case form of the lower-case letter `c`, or `c` itself
pub fun capital(c : char) : char
  if c.is-lower then (c.int - 'a'.int + 'A'.int).char else c

// count-digits(text) -> how many characters of `text` are digits
pub fun count-digits(text : string) : int
  text.count(is-digit)

// The letter after `c` in the alphabet that starts at `first`, wrapping round.
fun next-in(c : char, first : char) : char
  ((c.int - first.int + 1) % 26 + first.int).char

// intended(c) -> the letter after the letter `c` in its alphabet, wrapping round; other characters unchanged
pub fun intended(c : char) : char
  if c.is-lower then next-in(c, 'a')
  elif c.is-upper then next-in(c, 'A')
  else c

// repair(text) -> `text` with every character replaced by the one intended
pub fun repair(text : string) : string
  text.map(intended)
