fun shift(c : char, base : char, n : int) : char
  (base.int + (c.int - base.int + n) % 26).char

// rotate(text, shift-key) -> `text` with every letter shifted `shift-key` places along the alphabet,
// wrapping around and keeping its case; other characters are unchanged
pub fun rotate(text : string, shift-key : int) : exn string
  text.list.map(fn(c)
    if c.is-lower then c.shift('a', shift-key)
    elif c.is-upper then c.shift('A', shift-key)
    else c
  ).string
