// proteins(strand) -> the names of the amino acids that the RNA `strand` codes for, in order,
// stopping at the first STOP codon; throws "Invalid codon" on a codon that is not recognized
pub fun proteins(strand : string) : exn list<string>
  throw("implement me", ExnTodo)
