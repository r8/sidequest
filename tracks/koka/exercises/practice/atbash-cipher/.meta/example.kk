// The letters and digits of `phrase`, lowercased, with each letter mirrored in the alphabet.
fun transcode(phrase : string) : list<char>
  phrase.to-lower.list.filter(is-alpha-num).map(fn(c)
    if c.is-lower then ('z'.int - (c.int - 'a'.int)).char else c
  )

// encode(phrase) -> the Atbash cipher of the letters and digits of `phrase`, lowercase,
// in groups of 5 separated by spaces
pub fun encode(phrase : string) : exn string
  phrase.transcode.map-indexed(fn(i, c) if i > 0 && i % 5 == 0 then [' ', c] else [c]).concat.string

// decode(phrase) -> the plain text of the Atbash cipher `phrase`, lowercase, without spaces
pub fun decode(phrase : string) : exn string
  phrase.transcode.string
