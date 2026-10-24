\ convert leaves the raindrop sounds for n, or n's digits when it has none of the factors
\ 3, 5, 7, in a buffer it owns, valid until the next call:  15 convert  gives "PlingPlang".
\ Pictured numeric output (<# #s #>) turns a number into its digits.
create drops 32 chars allot

: sound ( n factor c-addr u -- n )
  2>r over swap mod if 2r> 2drop else 2r> drops +place then ;

: digits ( u -- c-addr u ) 0 <# #s #> ;

: convert ( n -- c-addr u )
  0 drops c!
  3 s" Pling" sound  5 s" Plang" sound  7 s" Plong" sound
  drops c@ if drop else digits drops place then
  drops count ;
