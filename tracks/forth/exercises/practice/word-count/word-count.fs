\ count-words counts the words of a sentence; occurrences then looks a word up and #words gives the
\ number of distinct words, so the counts form a map from word to count:
\   s" one fish two fish" count-words  s" fish" occurrences  ( -- 2 )  #words  ( -- 3 )
\ A word is a run of letters, digits and apostrophes, without apostrophes at either end ("can't" is
\ one word, "'large'" is "large"). Words are case-insensitive: keys are lowercase, and occurrences
\ takes a lowercase word, giving 0 for one the sentence did not contain. The counts stay until the
\ next count-words.
: count-words ( c-addr u -- )
  true abort" implement me" ;

: occurrences ( c-addr u -- n )
  true abort" implement me" ;

: #words ( -- n )
  true abort" implement me" ;
