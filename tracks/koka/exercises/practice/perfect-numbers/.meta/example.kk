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

// The sum of the divisors of `n` below `n`, pairing each divisor d up to sqrt(n) with n / d.
fun aliquot-sum(n : int) : div int
  fun go(d : int, acc : int) : div int
    if d * d > n then acc
    elif n % d != 0 then go(d + 1, acc)
    elif d * d == n then go(d + 1, acc + d)
    else go(d + 1, acc + d + n / d)
  if n == 1 then 0 else go(2, 1)

// classify(n) -> whether `n` is perfect, abundant or deficient;
// throws "Classification is only possible for positive integers." when `n` is not positive
pub fun classify(n : int) : <exn, div> classification
  if n <= 0 then throw("Classification is only possible for positive integers.")
  val s = n.aliquot-sum
  if s == n then Perfect
  elif s > n then Abundant
  else Deficient
