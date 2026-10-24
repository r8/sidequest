// Lower-cases ASCII, Latin-1, Greek and Cyrillic capitals; std's `to-lower` only handles ASCII.
fun fold-case(c : char) : char
  val n = c.int
  val upper = (n >= 0x41 && n <= 0x5A) || (n >= 0xC0 && n <= 0xDE && n != 0xD7)
           || (n >= 0x391 && n <= 0x3A9) || (n >= 0x410 && n <= 0x42F)
  if upper then (n + 0x20).char else c

fun lower(word : string) : list<char>
  word.list.map(fold-case)

fun insert(x : char, xs : list<char>) : list<char>
  match xs
    Cons(y, ys) | y < x -> Cons(y, insert(x, ys))
    _ -> Cons(x, xs)

fun sorted(cs : list<char>) : list<char>
  cs.foldr([], insert)

// find-anagrams(subject, candidates) -> the candidates that are anagrams of `subject`, in their
// original order; letter case is ignored, and a word is not an anagram of itself
// (note: std's `to-lower` and `to-upper` only change ASCII letters)
pub fun find-anagrams(subject : string, candidates : list<string>) : list<string>
  val word = subject.lower
  val key = word.sorted
  candidates.filter fn(candidate)
    val other = candidate.lower
    other != word && other.sorted == key
