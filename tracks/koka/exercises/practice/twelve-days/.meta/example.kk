val ordinals = ["first", "second", "third", "fourth", "fifth", "sixth",
                "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"]

val gifts = [("a", "Partridge in a Pear Tree"), ("two", "Turtle Doves"), ("three", "French Hens"),
             ("four", "Calling Birds"), ("five", "Gold Rings"), ("six", "Geese-a-Laying"),
             ("seven", "Swans-a-Swimming"), ("eight", "Maids-a-Milking"), ("nine", "Ladies Dancing"),
             ("ten", "Lords-a-Leaping"), ("eleven", "Pipers Piping"), ("twelve", "Drummers Drumming")]

fun gift-list(day : int) : string
  match gifts.take(day).map(fn(g) g.fst ++ " " ++ g.snd).reverse
    Cons(only, Nil) -> only
    given -> given.init.join(", ") ++ ", and " ++ given.last.default("")

fun verse(day : int) : string
  "On the " ++ ordinals[day - 1].default("") ++ " day of Christmas my true love gave to me: " ++ gift-list(day) ++ "."

// recite(start-verse, end-verse) -> the verses from `start-verse` to `end-verse`, one string each
pub fun recite(start-verse : int, end-verse : int) : list<string>
  list(start-verse, end-verse).map(verse)
