(def- codons
  {"AUG" "Methionine"
   "UUU" "Phenylalanine" "UUC" "Phenylalanine"
   "UUA" "Leucine" "UUG" "Leucine"
   "UCU" "Serine" "UCC" "Serine" "UCA" "Serine" "UCG" "Serine"
   "UAU" "Tyrosine" "UAC" "Tyrosine"
   "UGU" "Cysteine" "UGC" "Cysteine"
   "UGG" "Tryptophan"
   "UAA" :stop "UAG" :stop "UGA" :stop})

(defn proteins
  "(proteins strand) -> the protein names coded by the RNA strand, up to the first STOP codon"
  [strand]
  # Codons are looked at one by one, so anything after a STOP is never checked.
  (seq [codon :in (partition 3 strand)
        :let [protein (or (codons codon) (error "Invalid codon"))]
        :until (= protein :stop)]
    protein))
