(import test :as t)
(import ../roman-numerals :as sol)

(t/deftest "1 is I"
  (t/assert-equal "I" (sol/roman 1)))

(t/deftest "2 is II"
  (t/assert-equal "II" (sol/roman 2)))

(t/deftest "3 is III"
  (t/assert-equal "III" (sol/roman 3)))

(t/deftest "4 is IV"
  (t/assert-equal "IV" (sol/roman 4)))

(t/deftest "5 is V"
  (t/assert-equal "V" (sol/roman 5)))

(t/deftest "6 is VI"
  (t/assert-equal "VI" (sol/roman 6)))

(t/deftest "9 is IX"
  (t/assert-equal "IX" (sol/roman 9)))

(t/deftest "16 is XVI"
  (t/assert-equal "XVI" (sol/roman 16)))

(t/deftest "27 is XXVII"
  (t/assert-equal "XXVII" (sol/roman 27)))

(t/deftest "48 is XLVIII"
  (t/assert-equal "XLVIII" (sol/roman 48)))

(t/deftest "49 is XLIX"
  (t/assert-equal "XLIX" (sol/roman 49)))

(t/deftest "59 is LIX"
  (t/assert-equal "LIX" (sol/roman 59)))

(t/deftest "66 is LXVI"
  (t/assert-equal "LXVI" (sol/roman 66)))

(t/deftest "93 is XCIII"
  (t/assert-equal "XCIII" (sol/roman 93)))

(t/deftest "141 is CXLI"
  (t/assert-equal "CXLI" (sol/roman 141)))

(t/deftest "163 is CLXIII"
  (t/assert-equal "CLXIII" (sol/roman 163)))

(t/deftest "166 is CLXVI"
  (t/assert-equal "CLXVI" (sol/roman 166)))

(t/deftest "402 is CDII"
  (t/assert-equal "CDII" (sol/roman 402)))

(t/deftest "575 is DLXXV"
  (t/assert-equal "DLXXV" (sol/roman 575)))

(t/deftest "666 is DCLXVI"
  (t/assert-equal "DCLXVI" (sol/roman 666)))

(t/deftest "911 is CMXI"
  (t/assert-equal "CMXI" (sol/roman 911)))

(t/deftest "1024 is MXXIV"
  (t/assert-equal "MXXIV" (sol/roman 1024)))

(t/deftest "1666 is MDCLXVI"
  (t/assert-equal "MDCLXVI" (sol/roman 1666)))

(t/deftest "3000 is MMM"
  (t/assert-equal "MMM" (sol/roman 3000)))

(t/deftest "3001 is MMMI"
  (t/assert-equal "MMMI" (sol/roman 3001)))

(t/deftest "3888 is MMMDCCCLXXXVIII"
  (t/assert-equal "MMMDCCCLXXXVIII" (sol/roman 3888)))

(t/deftest "3999 is MMMCMXCIX"
  (t/assert-equal "MMMCMXCIX" (sol/roman 3999)))

(t/run)
