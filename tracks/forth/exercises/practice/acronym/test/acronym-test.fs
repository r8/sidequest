require ../lib/test.fs
require ../acronym.fs

test" basic"  s" Portable Network Graphics" abbreviate s" PNG" assert-str= ;test
test" lowercase words"  s" Ruby on Rails" abbreviate s" ROR" assert-str= ;test
test" punctuation"  s" First In, First Out" abbreviate s" FIFO" assert-str= ;test
test" all caps word"  s" GNU Image Manipulation Program" abbreviate s" GIMP" assert-str= ;test
test" punctuation without whitespace"
  s" Complementary metal-oxide semiconductor" abbreviate s" CMOS" assert-str= ;test
test" very long abbreviation"
  s" Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me" abbreviate
  s" ROTFLSHTMDCOALM" assert-str= ;test
test" consecutive delimiters"
  s" Something - I made up from thin air" abbreviate s" SIMUFTA" assert-str= ;test
test" apostrophes"  s" Halley's Comet" abbreviate s" HC" assert-str= ;test
test" underscore emphasis"  s" The Road _Not_ Taken" abbreviate s" TRNT" assert-str= ;test

\ Not in the canonical data: more words than any fixed-size buffer a solution might reach for.
create many-words 1999 chars allot  many-words 1999 bl fill
: fill-words ( -- ) 1999 0 do  [char] a many-words i chars + c!  2 +loop ;  fill-words
create many-initials 1000 chars allot  many-initials 1000 char A fill
test" a phrase of many words"  many-words 1999 abbreviate many-initials 1000 assert-str= ;test

end-tests
