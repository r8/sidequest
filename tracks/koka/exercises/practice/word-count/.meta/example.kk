fun is-word-char(c : char) : bool
  c.is-alpha-num || c == '\''

fun strip-quotes(cs : list<char>) : list<char>
  cs.drop-while(fn(c) c == '\'').reverse.drop-while(fn(c) c == '\'').reverse

fun words(sentence : string) : list<string>
  sentence.to-lower.map(fn(c) if c.is-word-char then c else ' ')
          .split(" ")
          .map(fn(w) w.list.strip-quotes.string)
          .filter(is-notempty)

fun insert(w : string, ws : list<string>) : list<string>
  match ws
    Cons(v, vs) | v < w -> Cons(v, insert(w, vs))
    _ -> Cons(w, ws)

// Counts the runs of equal words in a sorted list.
fun tally(sorted : list<string>) : list<(string, int)>
  sorted.foldl([], fn(acc, w)
    match acc
      Cons((v, n), rest) | v == w -> Cons((w, n + 1), rest)
      _ -> Cons((w, 1), acc)
  ).reverse

// count-words(sentence) -> how often each word occurs in `sentence`, as (word, count) pairs sorted
// by word; words are lower-cased runs of letters, digits and inner apostrophes
pub fun count-words(sentence : string) : list<(string, int)>
  sentence.words.foldr([], insert).tally
