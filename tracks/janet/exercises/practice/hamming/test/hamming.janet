(import test :as t)
(import ../hamming :as sol)

(t/deftest "empty strands"
  (t/assert-equal 0 (sol/distance "" "")))

(t/deftest "single letter identical strands"
  (t/assert-equal 0 (sol/distance "A" "A")))

(t/deftest "single letter different strands"
  (t/assert-equal 1 (sol/distance "G" "T")))

(t/deftest "long identical strands"
  (t/assert-equal 0 (sol/distance "GGACTGAAATCTG" "GGACTGAAATCTG")))

(t/deftest "long different strands"
  (t/assert-equal 9 (sol/distance "GGACGGATTCTG" "AGGACGGATTCT")))

(t/deftest "disallow first strand longer"
  (t/assert-error "strands must be of equal length" (sol/distance "AATG" "AAA")))

(t/deftest "disallow second strand longer"
  (t/assert-error "strands must be of equal length" (sol/distance "ATA" "AGTG")))

(t/deftest "disallow empty first strand"
  (t/assert-error "strands must be of equal length" (sol/distance "" "G")))

(t/deftest "disallow empty second strand"
  (t/assert-error "strands must be of equal length" (sol/distance "G" "")))

(t/run)
