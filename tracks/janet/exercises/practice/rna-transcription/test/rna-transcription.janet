(import test :as t)
(import ../rna-transcription :as sol)

(t/deftest "Empty RNA sequence"
  (t/assert-equal "" (sol/to-rna "")))

(t/deftest "RNA complement of cytosine is guanine"
  (t/assert-equal "G" (sol/to-rna "C")))

(t/deftest "RNA complement of guanine is cytosine"
  (t/assert-equal "C" (sol/to-rna "G")))

(t/deftest "RNA complement of thymine is adenine"
  (t/assert-equal "A" (sol/to-rna "T")))

(t/deftest "RNA complement of adenine is uracil"
  (t/assert-equal "U" (sol/to-rna "A")))

(t/deftest "RNA complement"
  (t/assert-equal "UGCACCAGAAUU" (sol/to-rna "ACGTGGTCTTAA")))

(t/run)
