# The counts are a struct keyed by nucleotide keyword: {:A 0 :C 0 :G 0 :T 0}.

(def- nucleotides
  (peg/compile ~(* (any (/ (<- (set "ACGT")) ,keyword)) -1)))

(defn nucleotide-counts
  "(nucleotide-counts strand) -> a struct from :A, :C, :G and :T to its count; errors on any other letter"
  [strand]
  (def found (or (peg/match nucleotides strand)
                 (error "Invalid nucleotide in strand")))
  (table/to-struct (merge {:A 0 :C 0 :G 0 :T 0} (frequencies found))))
