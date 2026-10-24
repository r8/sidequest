t ← •Import "../lib/test.bqn"
g ← •Import "../bob.bqn"

tab ← @+9
lf ← @+10
cr ← @+13

t.Run ⟨
  "asking a question"‿{𝕊: "Sure." t.Expect g.Response "Does this cryogenic chamber make me look fat?"}
  "shouting"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "WATCH OUT!"}
  "forceful question"‿{𝕊: "Calm down, I know what I'm doing!" t.Expect g.Response "WHAT'S GOING ON?"}
  "silence"‿{𝕊: "Fine. Be that way!" t.Expect g.Response ""}
  "stating something"‿{𝕊: "Whatever." t.Expect g.Response "Tom-ay-to, tom-aaaah-to."}
  "asking a numeric question"‿{𝕊: "Sure." t.Expect g.Response "You are, what, like 15?"}
  "asking gibberish"‿{𝕊: "Sure." t.Expect g.Response "fffbbcbeab?"}
  "question with no letters"‿{𝕊: "Sure." t.Expect g.Response "4?"}
  "non-letters with question"‿{𝕊: "Sure." t.Expect g.Response ":) ?"}
  "prattling on"‿{𝕊: "Sure." t.Expect g.Response "Wait! Hang on. Are you going to be OK?"}
  "ending with whitespace"‿{𝕊: "Sure." t.Expect g.Response "Okay if like my  spacebar  quite a bit?   "}
  "multiple line question"‿{𝕊: "Sure." t.Expect g.Response lf∾"Does this cryogenic chamber make"∾lf∾" me look fat?"}
  "shouting gibberish"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "FCECDFCAAB"}
  "shouting a statement containing a question mark"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "DO LIONS EAT PEOPLE? AHHHHH."}
  "shouting numbers"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "1, 2, 3 GO!"}
  "shouting with special characters"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"}
  "shouting with no exclamation mark"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "I HATE THE DENTIST"}
  "prolonged silence"‿{𝕊: "Fine. Be that way!" t.Expect g.Response "          "}
  "alternate silence"‿{𝕊: "Fine. Be that way!" t.Expect g.Response 10⥊tab}
  "other whitespace"‿{𝕊: "Fine. Be that way!" t.Expect g.Response lf‿cr‿' '‿tab}
  "talking forcefully"‿{𝕊: "Whatever." t.Expect g.Response "Hi there!"}
  "using acronyms in regular speech"‿{𝕊: "Whatever." t.Expect g.Response "It's OK if you don't want to go work for NASA."}
  "no letters"‿{𝕊: "Whatever." t.Expect g.Response "1, 2, 3"}
  "statement containing question mark"‿{𝕊: "Whatever." t.Expect g.Response "Ending with ? means a question."}
  "starting with whitespace"‿{𝕊: "Whatever." t.Expect g.Response "         hmmmmmmm..."}
  "non-question ending with whitespace"‿{𝕊: "Whatever." t.Expect g.Response "This is a statement ending with whitespace      "}
  # Not in the canonical data: whitespace beyond tab, newline and space, and letters beyond ASCII.
  "vertical tab and form feed are silence"‿{𝕊: "Fine. Be that way!" t.Expect g.Response (@+11)‿(@+12)}
  "shouting in Cyrillic"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "ПРИВЕТ!"}
  "shouting with umlauts"‿{𝕊: "Whoa, chill out!" t.Expect g.Response "ÄÖÜ"}
  "a lowercase umlaut is not shouting"‿{𝕊: "Whatever." t.Expect g.Response "ÜMLäÜTS!"}
  # Not in the canonical data: Unicode whitespace, such as a no-break space, is silence too.
  "no-break and ideographic spaces are silence"‿{𝕊: "Fine. Be that way!" t.Expect g.Response (@+160)‿(@+12288)}
⟩
