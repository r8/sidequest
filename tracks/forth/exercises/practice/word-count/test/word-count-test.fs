require ../lib/test.fs
require ../word-count.fs

test" count one word"  s" word" count-words  s" word" occurrences 1 assert=  #words 1 assert= ;test
test" count one of each word"  s" one of each" count-words
  s" one" occurrences 1 assert=  s" of" occurrences 1 assert=  s" each" occurrences 1 assert=
  #words 3 assert= ;test
test" multiple occurrences of a word"  s" one fish two fish red fish blue fish" count-words
  s" one" occurrences 1 assert=  s" fish" occurrences 4 assert=  s" two" occurrences 1 assert=
  s" red" occurrences 1 assert=  s" blue" occurrences 1 assert=  #words 5 assert= ;test
test" handles cramped lists"  s" one,two,three" count-words
  s" one" occurrences 1 assert=  s" two" occurrences 1 assert=  s" three" occurrences 1 assert=
  #words 3 assert= ;test
test" handles expanded lists"  s\" one,\ntwo,\nthree" count-words
  s" one" occurrences 1 assert=  s" two" occurrences 1 assert=  s" three" occurrences 1 assert=
  #words 3 assert= ;test
test" ignore punctuation"  s" car: carpet as java: javascript!!&@$%^&" count-words
  s" car" occurrences 1 assert=  s" carpet" occurrences 1 assert=  s" as" occurrences 1 assert=
  s" java" occurrences 1 assert=  s" javascript" occurrences 1 assert=  #words 5 assert= ;test
test" include numbers"  s" testing, 1, 2 testing" count-words
  s" testing" occurrences 2 assert=  s" 1" occurrences 1 assert=  s" 2" occurrences 1 assert=
  #words 3 assert= ;test
test" normalize case"  s" go Go GO Stop stop" count-words
  s" go" occurrences 3 assert=  s" stop" occurrences 2 assert=  #words 2 assert= ;test
test" with apostrophes"  s" 'First: don't laugh. Then: don't cry. You're getting it.'" count-words
  s" first" occurrences 1 assert=  s" don't" occurrences 2 assert=  s" laugh" occurrences 1 assert=
  s" then" occurrences 1 assert=  s" cry" occurrences 1 assert=  s" you're" occurrences 1 assert=
  s" getting" occurrences 1 assert=  s" it" occurrences 1 assert=  #words 8 assert= ;test
test" with quotations"  s" Joe can't tell between 'large' and large." count-words
  s" joe" occurrences 1 assert=  s" can't" occurrences 1 assert=  s" tell" occurrences 1 assert=
  s" between" occurrences 1 assert=  s" large" occurrences 2 assert=  s" and" occurrences 1 assert=
  #words 6 assert= ;test
test" substrings from the beginning"  s" Joe can't tell between app, apple and a." count-words
  s" joe" occurrences 1 assert=  s" can't" occurrences 1 assert=  s" tell" occurrences 1 assert=
  s" between" occurrences 1 assert=  s" app" occurrences 1 assert=  s" apple" occurrences 1 assert=
  s" and" occurrences 1 assert=  s" a" occurrences 1 assert=  #words 8 assert= ;test
test" multiple spaces not detected as a word"  s"  multiple   whitespaces" count-words
  s" multiple" occurrences 1 assert=  s" whitespaces" occurrences 1 assert=  #words 2 assert= ;test
test" alternating word separators not detected as a word"  s\" ,\n,one,\n ,two \n 'three'" count-words
  s" one" occurrences 1 assert=  s" two" occurrences 1 assert=  s" three" occurrences 1 assert=
  #words 3 assert= ;test
test" quotation for word with apostrophe"  s" can, can't, 'can't'" count-words
  s" can" occurrences 1 assert=  s" can't" occurrences 2 assert=  #words 2 assert= ;test

\ Not in the canonical data: more distinct words, a longer word and a longer sentence than any
\ fixed-size table a solution might reach for.
create many-words 400 chars allot  many-words 400 bl fill
: fill-many-words ( -- )
  100 0 do  [char] w  i 10 / [char] a +  i 10 mod [char] a +
    many-words i 4 * 2 + chars + c!  many-words i 4 * 1+ chars + c!  many-words i 4 * chars + c!
  loop ;
fill-many-words
test" many distinct words"  many-words 400 count-words
  s" wjj" occurrences 1 assert=  #words 100 assert= ;test
test" a long word"  s" pneumonoultramicroscopicsilicovolcanoconiosis pneumonoultramicroscopic" count-words
  s" pneumonoultramicroscopicsilicovolcanoconiosis" occurrences 1 assert=  #words 2 assert= ;test
create long-sentence 2000 chars allot  long-sentence 2000 char a fill
s" a b" long-sentence 1997 chars + swap chars move
test" a long sentence"  long-sentence 2000 count-words  s" b" occurrences 1 assert=  #words 2 assert= ;test

end-tests
