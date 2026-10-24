// calculate-frequencies(texts) -> how often each letter occurs across all of `texts`, ignoring case,
// as a list of (lowercase letter, count) sorted by letter.
// (Koka's standard library has no threads to count in parallel with; counting each text
// separately and merging the counts keeps the spirit of the exercise.)
pub fun calculate-frequencies(texts : list<string>) : exn list<(char, int)>
  throw("implement me", ExnTodo)
