val wriggle = "wriggled and jiggled and tickled inside her"

// each animal, and the remark on swallowing it
val animals = [("fly", ""), ("spider", "It " ++ wriggle ++ "."), ("bird", "How absurd to swallow a bird!"),
               ("cat", "Imagine that, to swallow a cat!"), ("dog", "What a hog, to swallow a dog!"),
               ("goat", "Just opened her throat and swallowed a goat!"),
               ("cow", "I don't know how she swallowed a cow!"), ("horse", "She's dead, of course!")]

fun catching(hunter : string, prey : string) : string
  val detail = if prey == "spider" then " that " ++ wriggle else ""
  "She swallowed the " ++ hunter ++ " to catch the " ++ prey ++ detail ++ "."

fun verse(n : int) : list<string>
  val eaten = animals.take(n).reverse
  match eaten
    Nil -> Nil
    Cons((animal, remark), earlier) ->
      val opening = "I know an old lady who swallowed a " ++ animal ++ "."
      val ending = "I don't know why she swallowed the fly. Perhaps she'll die."
      if n == animals.length then [opening, remark]
      else
        val chain = zipwith(eaten, earlier, fn(hunter, prey) catching(hunter.fst, prey.fst))
        [opening] ++ (if remark.is-empty then [] else [remark]) ++ chain ++ [ending]

// recite(start-verse, end-verse) -> the lines of the verses from `start-verse` to `end-verse`,
// with an empty line between verses
pub fun recite(start-verse : int, end-verse : int) : list<string>
  list(start-verse, end-verse).map(verse).intersperse([""]).concat
