// each thing in the rhyme, and what it did to the thing before it
val pieces = [("house that Jack built", ""), ("malt", "lay in"), ("rat", "ate"), ("cat", "killed"),
              ("dog", "worried"), ("cow with the crumpled horn", "tossed"),
              ("maiden all forlorn", "milked"), ("man all tattered and torn", "kissed"),
              ("priest all shaven and shorn", "married"), ("rooster that crowed in the morn", "woke"),
              ("farmer sowing his corn", "kept"), ("horse and the hound and the horn", "belonged to")]

fun verse(n : int) : string
  val parts = pieces.take(n).reverse.map fn(piece)
    val (thing, deed) = piece
    if deed.is-empty then "the " ++ thing else "the " ++ thing ++ " that " ++ deed
  "This is " ++ parts.join(" ") ++ "."

// recite(start-verse, end-verse) -> the verses from `start-verse` to `end-verse`, one string each
pub fun recite(start-verse : int, end-verse : int) : list<string>
  list(start-verse, end-verse).map(verse)
