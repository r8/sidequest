\ An allergy score is the sum of the scores of the allergens:
\   eggs 1, peanuts 2, shellfish 4, strawberries 8, tomatoes 16, chocolate 32, pollen 64, cats 128.
\ Higher bits of the score name no allergen and are ignored.
\
\ allergic-to? takes the allergen's name:  s" eggs" 1 allergic-to?
\ It throws -24 (invalid numeric argument) for a name that isn't one of the eight allergens.
: allergens ( -- c-addr u )
  s" eggs peanuts shellfish strawberries tomatoes chocolate pollen cats" ;

\ Split off the first space-separated word.
: split ( c-addr u -- rest-addr rest-u word-addr word-u )
  2dup bl scan  2dup 2>r  nip -  2r> dup if 1 /string then  2swap ;

\ The position of the word c-addr u in the space-separated list; -24 throw when it's absent.
: index-of ( c-addr u list-addr list-u -- n )
  0 >r  begin dup while
    split 2>r 2over 2r> compare 0= if 2drop 2drop r> exit then
    r> 1+ >r
  repeat  r> drop -24 throw ;

: allergic-to? ( c-addr u score -- flag )
  >r allergens index-of  1 swap lshift  r> and 0<> ;

\ The allergens in the score, in the order above, separated by single spaces ("eggs peanuts").
\ The string is in a buffer the solution owns, valid until the next call.
create result 80 chars allot

: +result ( c-addr u -- )
  result c@ if s"  " result +place then  result +place ;

: allergies ( score -- c-addr u )
  0 result c!  allergens
  begin dup while
    split 2>r  2 pick 1 and if 2r> +result else 2r> 2drop then
    rot 2/ -rot
  repeat 2drop drop
  result count ;
