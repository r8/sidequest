fun is-vowel(c : char) : bool
  "aeiou".list.any(fn(v) v == c)

// Splits a word into its leading consonant cluster and the rest. A "qu" belongs to the cluster,
// and a "y" after the first letter starts the rest, like a vowel.
fun split-cluster(cs : list<char>, first : bool) : (list<char>, list<char>)
  match cs
    Cons('q', Cons('u', rest)) -> (['q', 'u'], rest)
    Cons(c, rest) | !c.is-vowel && (first || c != 'y') ->
      val (cluster, others) = split-cluster(rest, False)
      (Cons(c, cluster), others)
    _ -> (Nil, cs)

fun translate-word(word : string) : string
  val cs = word.list
  val starts-like-vowel = match cs
    Cons(c, _) | c.is-vowel -> True
    Cons('x', Cons('r', _)) -> True
    Cons('y', Cons('t', _)) -> True
    _ -> False
  if starts-like-vowel then word ++ "ay"
  else
    val (cluster, rest) = split-cluster(cs, True)
    rest.string ++ cluster.string ++ "ay"

// translate(phrase) -> `phrase` (lowercase words separated by whitespace, which is kept as it is) translated
// word by word into Pig Latin
pub fun translate(phrase : string) : exn string
  phrase.list.runs.map(fn(run) match run
    Cons(c, _) | !c.is-white -> translate-word(run.string)
    _ -> run.string
  ).join

// The runs of whitespace and of other characters in turn.
fun runs(cs : list<char>) : list<list<char>>
  cs.foldr([], fn(c, acc) match acc
    Cons(Cons(d, run), rest) | d.is-white == c.is-white -> Cons(Cons(c, Cons(d, run)), rest)
    _ -> Cons([c], acc)
  )
