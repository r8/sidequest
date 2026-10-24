require ../lib/test.fs
require ../bob.fs

test" asking a question"
  s" Does this cryogenic chamber make me look fat?" response s" Sure." assert-str= ;test
test" shouting"  s" WATCH OUT!" response s" Whoa, chill out!" assert-str= ;test
test" forceful question"
  s" WHAT'S GOING ON?" response s" Calm down, I know what I'm doing!" assert-str= ;test
test" silence"  0 0 response s" Fine. Be that way!" assert-str= ;test
test" stating something"  s" Tom-ay-to, tom-aaaah-to." response s" Whatever." assert-str= ;test
test" asking a numeric question"  s" You are, what, like 15?" response s" Sure." assert-str= ;test
test" asking gibberish"  s" fffbbcbeab?" response s" Sure." assert-str= ;test
test" question with no letters"  s" 4?" response s" Sure." assert-str= ;test
test" non-letters with question"  s" :) ?" response s" Sure." assert-str= ;test
test" prattling on"
  s" Wait! Hang on. Are you going to be OK?" response s" Sure." assert-str= ;test
test" ending with whitespace"
  s" Okay if like my  spacebar  quite a bit?   " response s" Sure." assert-str= ;test
test" multiple line question"
  s\" \nDoes this cryogenic chamber make\n me look fat?" response s" Sure." assert-str= ;test
test" shouting gibberish"  s" FCECDFCAAB" response s" Whoa, chill out!" assert-str= ;test
test" shouting a statement containing a question mark"
  s" DO LIONS EAT PEOPLE? AHHHHH." response s" Whoa, chill out!" assert-str= ;test
test" shouting numbers"  s" 1, 2, 3 GO!" response s" Whoa, chill out!" assert-str= ;test
test" shouting with special characters"
  s" ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!" response
  s" Whoa, chill out!" assert-str= ;test
test" shouting with no exclamation mark"
  s" I HATE THE DENTIST" response s" Whoa, chill out!" assert-str= ;test
test" prolonged silence"  s"           " response s" Fine. Be that way!" assert-str= ;test
test" alternate silence"
  s\" \t\t\t\t\t\t\t\t\t\t" response s" Fine. Be that way!" assert-str= ;test
test" other whitespace"  s\" \n\r \t" response s" Fine. Be that way!" assert-str= ;test
test" talking forcefully"  s" Hi there!" response s" Whatever." assert-str= ;test
test" using acronyms in regular speech"
  s" It's OK if you don't want to go work for NASA." response s" Whatever." assert-str= ;test
test" no letters"  s" 1, 2, 3" response s" Whatever." assert-str= ;test
test" statement containing question mark"
  s" Ending with ? means a question." response s" Whatever." assert-str= ;test
test" starting with whitespace"  s"          hmmmmmmm..." response s" Whatever." assert-str= ;test
test" non-question ending with whitespace"
  s" This is a statement ending with whitespace      " response s" Whatever." assert-str= ;test

end-tests
