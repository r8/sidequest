// is-pangram(sentence) -> whether `sentence` uses every letter of the alphabet at least once,
// ignoring case
pub fun is-pangram(sentence : string) : bool
  val letters = sentence.to-lower.list
  list('a', 'z').all(fn(c) letters.contains(c))
