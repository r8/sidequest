(import test :as t)
(import ../greet :as sol)

# A comment with a paren ( and a "string" that must not confuse extraction.
(t/deftest "no name"
  (print "noisy\toutput")
  (print "second line")
  (t/assert-equal "Hello, you!" (sol/greet)))

(t/deftest "name with \"quotes\""
  (t/assert-equal "Hello, \"Bob\"!" (sol/greet `"Bob"`)))

(t/run)
