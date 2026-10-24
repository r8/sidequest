// distance(strand1, strand2) -> the number of positions where the strands differ;
// throws "strands must be of equal length" otherwise
pub fun distance(strand1 : string, strand2 : string) : exn int
  if strand1.count != strand2.count then throw("strands must be of equal length")
  zip(strand1.list, strand2.list).filter(fn(p) p.fst != p.snd).length
