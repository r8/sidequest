// Every ordering of `xs`.
fun permutations(xs : list<int>) : div list<list<int>>
  match xs
    Nil -> [[]]
    _ -> xs.flatmap(fn(x) permutations(xs.filter(fn(y) y != x)).map(fn(p) Cons(x, p)))

fun at(xs : list<int>, i : int) : int
  xs[i].default(-1)

fun next-to(a : int, b : int) : bool
  (a - b).abs == 1

val nationalities = ["Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"]

// Each solution maps every value of an attribute to its house number, 0 to 4, in this order:
//   colours: red, green, ivory, yellow, blue
//   nationalities: Englishman, Spaniard, Ukrainian, Norwegian, Japanese
//   drinks: coffee, tea, milk, orange juice, water
//   pets: dog, snails, fox, horse, zebra
//   hobbies: dancing, painting, reading, football, chess
// The result is (nationality of the water drinker, nationality of the zebra owner).
fun solution() : div (string, string)
  val perms = permutations(list(0, 4))
  val answers =
    perms.filter(fn(colour) colour.at(1) == colour.at(2) + 1).flatmap fn(colour)
      perms.filter(fn(nation) nation.at(0) == colour.at(0) && nation.at(3) == 0 && next-to(nation.at(3), colour.at(4))).flatmap fn(nation)
        perms.filter(fn(drink) drink.at(0) == colour.at(1) && drink.at(1) == nation.at(2) && drink.at(2) == 2).flatmap fn(drink)
          perms.filter(fn(hobby) hobby.at(1) == colour.at(3) && hobby.at(3) == drink.at(3) && hobby.at(4) == nation.at(4)).flatmap fn(hobby)
            perms.filter(fn(pet) pet.at(0) == nation.at(1) && pet.at(1) == hobby.at(0) && next-to(hobby.at(2), pet.at(2)) && next-to(hobby.at(1), pet.at(3))).map fn(pet)
              val owner = fn(house) nationalities[nation.index-of(fn(h) h == house)].default("")
              (owner(drink.at(4)), owner(pet.at(4)))
  answers.head(("", ""))

// drinks-water() -> the nationality of the resident who drinks water, such as "Englishman"
pub fun drinks-water() : div string
  solution().fst

// owns-zebra() -> the nationality of the resident who owns the zebra
pub fun owns-zebra() : div string
  solution().snd
