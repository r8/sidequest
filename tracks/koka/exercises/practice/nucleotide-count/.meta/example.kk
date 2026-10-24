val nucleotides = ['A', 'C', 'G', 'T']

// nucleotide-counts(strand) -> how often each nucleotide occurs in `strand`, as a list of
// (nucleotide, count) pairs for 'A', 'C', 'G' and 'T', in that order, including zero counts;
// throws "Invalid nucleotide in strand" if `strand` holds anything else
pub fun nucleotide-counts(strand : string) : exn list<(char, int)>
  val cs = strand.list
  if cs.any(fn(c) !nucleotides.contains(c)) then throw("Invalid nucleotide in strand")
  nucleotides.map(fn(n) (n, cs.filter(fn(c) c == n).length))
