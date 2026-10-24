\ find-anagrams takes the subject word and the candidates, one string of words separated by single
\ spaces, and returns the candidates that are anagrams of the subject in the same form, in their
\ original order and spelling:
\   s" solemn" s" lemons cherry melons" find-anagrams  ( -- c-addr u )  \ "lemons melons"
\ Letters compare case-insensitively, and a word is not an anagram of itself. No matches gives an
\ empty string. The result lives in a buffer of the solution, valid until the next call.
: find-anagrams ( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 )
  true abort" implement me" ;
