(import test :as t)
(import ../kindergarten-garden :as sol)

(t/deftest "garden with single student"
  (t/assert-equal [:radishes :clover :grass :grass] (sol/plants "RC\nGG" "Alice")))

(t/deftest "different garden with single student"
  (t/assert-equal [:violets :clover :radishes :clover] (sol/plants "VC\nRC" "Alice")))

(t/deftest "garden with two students"
  (t/assert-equal [:clover :grass :radishes :clover] (sol/plants "VVCG\nVVRC" "Bob")))

(t/deftest "second student's garden"
  (t/assert-equal [:clover :clover :clover :clover] (sol/plants "VVCCGG\nVVCCGG" "Bob")))

(t/deftest "third student's garden"
  (t/assert-equal [:grass :grass :grass :grass] (sol/plants "VVCCGG\nVVCCGG" "Charlie")))

(t/deftest "for Alice, first student's garden"
  (t/assert-equal [:violets :radishes :violets :radishes] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Alice")))

(t/deftest "for Bob, second student's garden"
  (t/assert-equal [:clover :grass :clover :clover] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Bob")))

(t/deftest "for Charlie"
  (t/assert-equal [:violets :violets :clover :grass] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Charlie")))

(t/deftest "for David"
  (t/assert-equal [:radishes :violets :clover :radishes] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "David")))

(t/deftest "for Eve"
  (t/assert-equal [:clover :grass :radishes :grass] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Eve")))

(t/deftest "for Fred"
  (t/assert-equal [:grass :clover :violets :clover] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Fred")))

(t/deftest "for Ginny"
  (t/assert-equal [:clover :grass :grass :clover] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ginny")))

(t/deftest "for Harriet"
  (t/assert-equal [:violets :radishes :radishes :violets] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Harriet")))

(t/deftest "for Ileana"
  (t/assert-equal [:grass :clover :violets :clover] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ileana")))

(t/deftest "for Joseph"
  (t/assert-equal [:violets :clover :violets :grass] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Joseph")))

(t/deftest "for Kincaid, second to last student's garden"
  (t/assert-equal [:grass :clover :clover :grass] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Kincaid")))

(t/deftest "for Larry, last student's garden"
  (t/assert-equal [:grass :violets :clover :violets] (sol/plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Larry")))

(t/run)
