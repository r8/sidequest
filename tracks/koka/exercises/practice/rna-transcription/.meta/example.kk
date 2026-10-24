fun complement(nucleotide : char) : char
  match nucleotide
    'G' -> 'C'
    'C' -> 'G'
    'T' -> 'A'
    _   -> 'U'

// to-rna(dna) -> the RNA complement of the DNA strand `dna`
pub fun to-rna(dna : string) : exn string
  dna.list.map(complement).string
