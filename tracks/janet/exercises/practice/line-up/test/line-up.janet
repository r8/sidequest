(import test :as t)
(import ../line-up :as sol)

(t/deftest "format smallest non-exceptional ordinal numeral 4"
  (t/assert-equal "Gianna, you are the 4th customer we serve today. Thank you!" (sol/format "Gianna" 4)))

(t/deftest "format greatest single digit non-exceptional ordinal numeral 9"
  (t/assert-equal "Maarten, you are the 9th customer we serve today. Thank you!" (sol/format "Maarten" 9)))

(t/deftest "format non-exceptional ordinal numeral 5"
  (t/assert-equal "Petronila, you are the 5th customer we serve today. Thank you!" (sol/format "Petronila" 5)))

(t/deftest "format non-exceptional ordinal numeral 6"
  (t/assert-equal "Attakullakulla, you are the 6th customer we serve today. Thank you!" (sol/format "Attakullakulla" 6)))

(t/deftest "format non-exceptional ordinal numeral 7"
  (t/assert-equal "Kate, you are the 7th customer we serve today. Thank you!" (sol/format "Kate" 7)))

(t/deftest "format non-exceptional ordinal numeral 8"
  (t/assert-equal "Maximiliano, you are the 8th customer we serve today. Thank you!" (sol/format "Maximiliano" 8)))

(t/deftest "format exceptional ordinal numeral 1"
  (t/assert-equal "Mary, you are the 1st customer we serve today. Thank you!" (sol/format "Mary" 1)))

(t/deftest "format exceptional ordinal numeral 2"
  (t/assert-equal "Haruto, you are the 2nd customer we serve today. Thank you!" (sol/format "Haruto" 2)))

(t/deftest "format exceptional ordinal numeral 3"
  (t/assert-equal "Henriette, you are the 3rd customer we serve today. Thank you!" (sol/format "Henriette" 3)))

(t/deftest "format smallest two digit non-exceptional ordinal numeral 10"
  (t/assert-equal "Alvarez, you are the 10th customer we serve today. Thank you!" (sol/format "Alvarez" 10)))

(t/deftest "format non-exceptional ordinal numeral 11"
  (t/assert-equal "Jacqueline, you are the 11th customer we serve today. Thank you!" (sol/format "Jacqueline" 11)))

(t/deftest "format non-exceptional ordinal numeral 12"
  (t/assert-equal "Juan, you are the 12th customer we serve today. Thank you!" (sol/format "Juan" 12)))

(t/deftest "format non-exceptional ordinal numeral 13"
  (t/assert-equal "Patricia, you are the 13th customer we serve today. Thank you!" (sol/format "Patricia" 13)))

(t/deftest "format exceptional ordinal numeral 21"
  (t/assert-equal "Washi, you are the 21st customer we serve today. Thank you!" (sol/format "Washi" 21)))

(t/deftest "format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11"
  (t/assert-equal "Ingrid, you are the 22nd customer we serve today. Thank you!" (sol/format "Ingrid" 22)))

(t/deftest "format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11"
  (t/assert-equal "Mario, you are the 33rd customer we serve today. Thank you!" (sol/format "Mario" 33)))

(t/deftest "format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13"
  (t/assert-equal "Quentin, you are the 52nd customer we serve today. Thank you!" (sol/format "Quentin" 52)))

(t/deftest "format exceptional ordinal numeral 62"
  (t/assert-equal "Nayra, you are the 62nd customer we serve today. Thank you!" (sol/format "Nayra" 62)))

(t/deftest "format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12"
  (t/assert-equal "Ugo, you are the 72nd customer we serve today. Thank you!" (sol/format "Ugo" 72)))

(t/deftest "format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13"
  (t/assert-equal "Boris, you are the 91st customer we serve today. Thank you!" (sol/format "Boris" 91)))

(t/deftest "format exceptional ordinal numeral 100"
  (t/assert-equal "John, you are the 100th customer we serve today. Thank you!" (sol/format "John" 100)))

(t/deftest "format exceptional ordinal numeral 101"
  (t/assert-equal "Zeinab, you are the 101st customer we serve today. Thank you!" (sol/format "Zeinab" 101)))

(t/deftest "format non-exceptional ordinal numeral 112"
  (t/assert-equal "Knud, you are the 112th customer we serve today. Thank you!" (sol/format "Knud" 112)))

(t/deftest "format exceptional ordinal numeral 123"
  (t/assert-equal "Yma, you are the 123rd customer we serve today. Thank you!" (sol/format "Yma" 123)))

(t/deftest "format large number 972 ending in nd even though it is a multiple of 12"
  (t/assert-equal "Elias, you are the 972nd customer we serve today. Thank you!" (sol/format "Elias" 972)))

(t/run)
