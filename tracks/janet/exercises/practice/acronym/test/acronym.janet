(import test :as t)
(import ../acronym :as sol)

(t/deftest "basic"
  (t/assert-equal "PNG" (sol/abbreviate "Portable Network Graphics")))

(t/deftest "lowercase words"
  (t/assert-equal "ROR" (sol/abbreviate "Ruby on Rails")))

(t/deftest "punctuation"
  (t/assert-equal "FIFO" (sol/abbreviate "First In, First Out")))

(t/deftest "all caps word"
  (t/assert-equal "GIMP" (sol/abbreviate "GNU Image Manipulation Program")))

(t/deftest "punctuation without whitespace"
  (t/assert-equal "CMOS" (sol/abbreviate "Complementary metal-oxide semiconductor")))

(t/deftest "very long abbreviation"
  (t/assert-equal "ROTFLSHTMDCOALM" (sol/abbreviate "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")))

(t/deftest "consecutive delimiters"
  (t/assert-equal "SIMUFTA" (sol/abbreviate "Something - I made up from thin air")))

(t/deftest "apostrophes"
  (t/assert-equal "HC" (sol/abbreviate "Halley's Comet")))

(t/deftest "underscore emphasis"
  (t/assert-equal "TRNT" (sol/abbreviate "The Road _Not_ Taken")))

(t/run)
