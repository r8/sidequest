// The amino acid that `codon` codes for, or Nothing for a STOP codon.
fun amino-acid(codon : string) : exn maybe<string>
  match codon
    "AUG" -> Just("Methionine")
    "UUU" -> Just("Phenylalanine")
    "UUC" -> Just("Phenylalanine")
    "UUA" -> Just("Leucine")
    "UUG" -> Just("Leucine")
    "UCU" -> Just("Serine")
    "UCC" -> Just("Serine")
    "UCA" -> Just("Serine")
    "UCG" -> Just("Serine")
    "UAU" -> Just("Tyrosine")
    "UAC" -> Just("Tyrosine")
    "UGU" -> Just("Cysteine")
    "UGC" -> Just("Cysteine")
    "UGG" -> Just("Tryptophan")
    "UAA" -> Nothing
    "UAG" -> Nothing
    "UGA" -> Nothing
    _     -> throw("Invalid codon")

fun translate(bases : list<char>) : exn list<string>
  match bases
    Nil -> Nil
    Cons(a, Cons(b, Cons(c, rest))) ->
      match amino-acid([a, b, c].string)
        Nothing -> Nil
        Just(name) -> Cons(name, translate(rest))
    _ -> throw("Invalid codon")

// proteins(strand) -> the names of the amino acids that the RNA `strand` codes for, in order,
// stopping at the first STOP codon; throws "Invalid codon" on a codon that is not recognized
pub fun proteins(strand : string) : exn list<string>
  translate(strand.list)
