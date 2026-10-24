\ The Scrabble score of a word, ignoring case.
create letter-values  \ A to Z
  1 c, 3 c, 3 c, 2 c, 1 c, 4 c, 2 c, 4 c, 1 c, 8 c, 5 c, 1 c, 3 c,
  1 c, 1 c, 3 c, 10 c, 1 c, 1 c, 1 c, 1 c, 4 c, 4 c, 8 c, 4 c, 10 c,

: letter-score ( c -- n )
  toupper [char] A -  dup 0 26 within if letter-values + c@ else drop 0 then ;

: score ( c-addr u -- n ) 0 -rot bounds ?do i c@ letter-score + loop ;
