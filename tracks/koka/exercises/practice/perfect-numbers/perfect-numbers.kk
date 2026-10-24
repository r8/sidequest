// Nicomachus' classification of a positive integer by its aliquot sum.
pub type classification
  Perfect
  Abundant
  Deficient

pub fun show(c : classification) : string
  match c
    Perfect -> "Perfect"
    Abundant -> "Abundant"
    Deficient -> "Deficient"

pub fun (==)(c : classification, d : classification) : bool
  c.show == d.show

// classify(n) -> whether `n` is perfect, abundant or deficient;
// throws "Classification is only possible for positive integers." when `n` is not positive
pub fun classify(n : int) : exn classification
  throw("implement me", ExnTodo)
