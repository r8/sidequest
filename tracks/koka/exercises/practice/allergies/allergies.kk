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

// allergic-to(allergen, score) -> whether the allergy `score` includes `allergen`
pub fun allergic-to(allergen : allergen, score : int) : exn bool
  throw("implement me", ExnTodo)

// allergies(score) -> the allergens the allergy `score` includes, in the order of the type
pub fun allergies(score : int) : exn list<allergen>
  throw("implement me", ExnTodo)
