(import test :as t)
(import ../bob :as sol)

(t/deftest "asking a question"
  (t/assert-equal "Sure." (sol/response "Does this cryogenic chamber make me look fat?")))

(t/deftest "shouting"
  (t/assert-equal "Whoa, chill out!" (sol/response "WATCH OUT!")))

(t/deftest "forceful question"
  (t/assert-equal "Calm down, I know what I'm doing!" (sol/response "WHAT'S GOING ON?")))

(t/deftest "silence"
  (t/assert-equal "Fine. Be that way!" (sol/response "")))

(t/deftest "stating something"
  (t/assert-equal "Whatever." (sol/response "Tom-ay-to, tom-aaaah-to.")))

(t/deftest "asking a numeric question"
  (t/assert-equal "Sure." (sol/response "You are, what, like 15?")))

(t/deftest "asking gibberish"
  (t/assert-equal "Sure." (sol/response "fffbbcbeab?")))

(t/deftest "question with no letters"
  (t/assert-equal "Sure." (sol/response "4?")))

(t/deftest "non-letters with question"
  (t/assert-equal "Sure." (sol/response ":) ?")))

(t/deftest "prattling on"
  (t/assert-equal "Sure." (sol/response "Wait! Hang on. Are you going to be OK?")))

(t/deftest "ending with whitespace"
  (t/assert-equal "Sure." (sol/response "Okay if like my  spacebar  quite a bit?   ")))

(t/deftest "multiple line question"
  (t/assert-equal "Sure." (sol/response "\nDoes this cryogenic chamber make\n me look fat?")))

(t/deftest "shouting gibberish"
  (t/assert-equal "Whoa, chill out!" (sol/response "FCECDFCAAB")))

(t/deftest "shouting a statement containing a question mark"
  (t/assert-equal "Whoa, chill out!" (sol/response "DO LIONS EAT PEOPLE? AHHHHH.")))

(t/deftest "shouting numbers"
  (t/assert-equal "Whoa, chill out!" (sol/response "1, 2, 3 GO!")))

(t/deftest "shouting with special characters"
  (t/assert-equal "Whoa, chill out!" (sol/response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")))

(t/deftest "shouting with no exclamation mark"
  (t/assert-equal "Whoa, chill out!" (sol/response "I HATE THE DENTIST")))

(t/deftest "prolonged silence"
  (t/assert-equal "Fine. Be that way!" (sol/response "          ")))

(t/deftest "alternate silence"
  (t/assert-equal "Fine. Be that way!" (sol/response "\t\t\t\t\t\t\t\t\t\t")))

(t/deftest "other whitespace"
  (t/assert-equal "Fine. Be that way!" (sol/response "\n\r \t")))

(t/deftest "talking forcefully"
  (t/assert-equal "Whatever." (sol/response "Hi there!")))

(t/deftest "using acronyms in regular speech"
  (t/assert-equal "Whatever." (sol/response "It's OK if you don't want to go work for NASA.")))

(t/deftest "no letters"
  (t/assert-equal "Whatever." (sol/response "1, 2, 3")))

(t/deftest "statement containing question mark"
  (t/assert-equal "Whatever." (sol/response "Ending with ? means a question.")))

(t/deftest "starting with whitespace"
  (t/assert-equal "Whatever." (sol/response "         hmmmmmmm...")))

(t/deftest "non-question ending with whitespace"
  (t/assert-equal "Whatever." (sol/response "This is a statement ending with whitespace      ")))

(t/run)
