(import test :as t)
(import ../word-count :as sol)

(t/deftest "count one word"
  (t/assert-equal {"word" 1} (sol/count-words "word")))

(t/deftest "count one of each word"
  (t/assert-equal {"one" 1 "of" 1 "each" 1} (sol/count-words "one of each")))

(t/deftest "multiple occurrences of a word"
  (t/assert-equal {"one" 1 "fish" 4 "two" 1 "red" 1 "blue" 1} (sol/count-words "one fish two fish red fish blue fish")))

(t/deftest "handles cramped lists"
  (t/assert-equal {"one" 1 "two" 1 "three" 1} (sol/count-words "one,two,three")))

(t/deftest "handles expanded lists"
  (t/assert-equal {"one" 1 "two" 1 "three" 1} (sol/count-words "one,\ntwo,\nthree")))

(t/deftest "ignore punctuation"
  (t/assert-equal {"car" 1 "carpet" 1 "as" 1 "java" 1 "javascript" 1} (sol/count-words "car: carpet as java: javascript!!&@$%^&")))

(t/deftest "include numbers"
  (t/assert-equal {"1" 1 "2" 1 "testing" 2} (sol/count-words "testing, 1, 2 testing")))

(t/deftest "normalize case"
  (t/assert-equal {"go" 3 "stop" 2} (sol/count-words "go Go GO Stop stop")))

(t/deftest "with apostrophes"
  (t/assert-equal {"first" 1 "don't" 2 "laugh" 1 "then" 1 "cry" 1 "you're" 1 "getting" 1 "it" 1} (sol/count-words "'First: don't laugh. Then: don't cry. You're getting it.'")))

(t/deftest "with quotations"
  (t/assert-equal {"joe" 1 "can't" 1 "tell" 1 "between" 1 "large" 2 "and" 1} (sol/count-words "Joe can't tell between 'large' and large.")))

(t/deftest "substrings from the beginning"
  (t/assert-equal {"joe" 1 "can't" 1 "tell" 1 "between" 1 "app" 1 "apple" 1 "and" 1 "a" 1} (sol/count-words "Joe can't tell between app, apple and a.")))

(t/deftest "multiple spaces not detected as a word"
  (t/assert-equal {"multiple" 1 "whitespaces" 1} (sol/count-words " multiple   whitespaces")))

(t/deftest "alternating word separators not detected as a word"
  (t/assert-equal {"one" 1 "two" 1 "three" 1} (sol/count-words ",\n,one,\n ,two \n 'three'")))

(t/deftest "quotation for word with apostrophe"
  (t/assert-equal {"can" 1 "can't" 2} (sol/count-words "can, can't, 'can't'")))

(t/run)
