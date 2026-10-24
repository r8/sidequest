(import test :as t)
(import ../pig-latin :as sol)

(t/deftest "word beginning with a"
  (t/assert-equal "appleay" (sol/translate "apple")))

(t/deftest "word beginning with e"
  (t/assert-equal "earay" (sol/translate "ear")))

(t/deftest "word beginning with i"
  (t/assert-equal "iglooay" (sol/translate "igloo")))

(t/deftest "word beginning with o"
  (t/assert-equal "objectay" (sol/translate "object")))

(t/deftest "word beginning with u"
  (t/assert-equal "underay" (sol/translate "under")))

(t/deftest "word beginning with a vowel and followed by a qu"
  (t/assert-equal "equalay" (sol/translate "equal")))

(t/deftest "word beginning with p"
  (t/assert-equal "igpay" (sol/translate "pig")))

(t/deftest "word beginning with k"
  (t/assert-equal "oalakay" (sol/translate "koala")))

(t/deftest "word beginning with x"
  (t/assert-equal "enonxay" (sol/translate "xenon")))

(t/deftest "word beginning with q without a following u"
  (t/assert-equal "atqay" (sol/translate "qat")))

(t/deftest "word beginning with consonant and vowel containing qu"
  (t/assert-equal "iquidlay" (sol/translate "liquid")))

(t/deftest "word beginning with ch"
  (t/assert-equal "airchay" (sol/translate "chair")))

(t/deftest "word beginning with qu"
  (t/assert-equal "eenquay" (sol/translate "queen")))

(t/deftest "word beginning with qu and a preceding consonant"
  (t/assert-equal "aresquay" (sol/translate "square")))

(t/deftest "word beginning with th"
  (t/assert-equal "erapythay" (sol/translate "therapy")))

(t/deftest "word beginning with thr"
  (t/assert-equal "ushthray" (sol/translate "thrush")))

(t/deftest "word beginning with sch"
  (t/assert-equal "oolschay" (sol/translate "school")))

(t/deftest "word beginning with yt"
  (t/assert-equal "yttriaay" (sol/translate "yttria")))

(t/deftest "word beginning with xr"
  (t/assert-equal "xrayay" (sol/translate "xray")))

(t/deftest "y is treated like a consonant at the beginning of a word"
  (t/assert-equal "ellowyay" (sol/translate "yellow")))

(t/deftest "y is treated like a vowel at the end of a consonant cluster"
  (t/assert-equal "ythmrhay" (sol/translate "rhythm")))

(t/deftest "y as second letter in two letter word"
  (t/assert-equal "ymay" (sol/translate "my")))

(t/deftest "a whole phrase"
  (t/assert-equal "ickquay astfay unray" (sol/translate "quick fast run")))

# Not in the canonical data: words are separated by any whitespace, which the translation keeps.
(t/deftest "spacing between words is kept"
  (t/assert-equal "ymay  ogday\tickquay" (sol/translate "my  dog\tquick")))

(t/run)
