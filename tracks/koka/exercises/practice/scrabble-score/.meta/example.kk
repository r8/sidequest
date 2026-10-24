val letter-values = [
  ("aeioulnrst", 1), ("dg", 2), ("bcmp", 3), ("fhvwy", 4), ("k", 5), ("jx", 8), ("qz", 10),
]

fun letter-score(c : char) : int
  letter-values.lookup(fn(letters) letters.list.contains(c)).default(0)

// score(word) -> the Scrabble score of `word`, the sum of its letters' values, ignoring case
pub fun score(word : string) : int
  word.to-lower.list.map(letter-score).sum
