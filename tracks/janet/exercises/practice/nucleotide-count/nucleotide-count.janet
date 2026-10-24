# The counts are a struct keyed by nucleotide keyword: {:A 0 :C 0 :G 0 :T 0}.

(defn nucleotide-counts
  "(nucleotide-counts strand) -> a struct from :A, :C, :G and :T to its count; errors on any other letter"
  [strand]
  (error "implement me"))
