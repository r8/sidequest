(def- complements
  {(chr "G") "C" (chr "C") "G" (chr "T") "A" (chr "A") "U"})

(defn to-rna
  "(to-rna dna) -> the RNA complement of the DNA strand"
  [dna]
  (string ;(map complements dna)))
