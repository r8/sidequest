(import test :as t)
(import ../nucleotide-count :as sol)

(t/deftest "empty strand"
  (t/assert-equal {:A 0 :C 0 :G 0 :T 0} (sol/nucleotide-counts "")))

(t/deftest "can count one nucleotide in single-character input"
  (t/assert-equal {:A 0 :C 0 :G 1 :T 0} (sol/nucleotide-counts "G")))

(t/deftest "strand with repeated nucleotide"
  (t/assert-equal {:A 0 :C 0 :G 7 :T 0} (sol/nucleotide-counts "GGGGGGG")))

(t/deftest "strand with multiple nucleotides"
  (t/assert-equal {:A 20 :C 12 :G 17 :T 21} (sol/nucleotide-counts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")))

(t/deftest "strand with invalid nucleotides"
  (t/assert-error "Invalid nucleotide in strand" (sol/nucleotide-counts "AGXXACT")))

(t/run)
