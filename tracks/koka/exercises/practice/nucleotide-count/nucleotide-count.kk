// nucleotide-counts(strand) -> how often each nucleotide occurs in `strand`, as a list of
// (nucleotide, count) pairs for 'A', 'C', 'G' and 'T', in that order, including zero counts;
// throws "Invalid nucleotide in strand" if `strand` holds anything else
pub fun nucleotide-counts(strand : string) : exn list<(char, int)>
  throw("implement me", ExnTodo)
