val sounds = [(3, "Pling"), (5, "Plang"), (7, "Plong")]

// convert(n) -> the raindrop sounds for the factors 3, 5 and 7 of `n`, or `n` itself
pub fun convert(n : int) : string
  val drops = sounds.filter(fn(s) n % s.fst == 0).map(snd).join("")
  if drops.is-empty then n.show else drops
