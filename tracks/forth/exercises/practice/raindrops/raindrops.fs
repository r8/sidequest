\ convert leaves the raindrop sounds for n, or n's digits when it has none of the factors
\ 3, 5, 7, in a buffer it owns, valid until the next call:  15 convert  gives "PlingPlang".
\ Pictured numeric output (<# #s #>) turns a number into its digits.
: convert ( n -- c-addr u )
  true abort" implement me" ;
