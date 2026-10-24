// The allergens, in the order of their scores.
pub type allergen
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats

pub fun allergen/show(a : allergen) : string
  match a
    Eggs -> "Eggs"
    Peanuts -> "Peanuts"
    Shellfish -> "Shellfish"
    Strawberries -> "Strawberries"
    Tomatoes -> "Tomatoes"
    Chocolate -> "Chocolate"
    Pollen -> "Pollen"
    Cats -> "Cats"

pub fun allergen/(==)(a : allergen, b : allergen) : bool
  a.show == b.show

val all-allergens = [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]

fun value(a : allergen) : int
  match a
    Eggs -> 1
    Peanuts -> 2
    Shellfish -> 4
    Strawberries -> 8
    Tomatoes -> 16
    Chocolate -> 32
    Pollen -> 64
    Cats -> 128

// allergic-to(allergen, score) -> whether the allergy `score` includes `allergen`
pub fun allergic-to(allergen : allergen, score : int) : bool
  (score / allergen.value) % 2 == 1

// allergies(score) -> the allergens the allergy `score` includes, in the order of the type
pub fun allergies(score : int) : list<allergen>
  all-allergens.filter(fn(a) allergic-to(a, score))
