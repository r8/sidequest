\ score takes the five dice and a category, one of the constants below, and leaves the score:
\   3 3 5 6 6 choice score  ( -- 23 )
1 constant ones
2 constant twos
3 constant threes
4 constant fours
5 constant fives
6 constant sixes
7 constant full-house
8 constant four-of-a-kind
9 constant little-straight
10 constant big-straight
11 constant choice
12 constant yacht


create counts 7 cells allot  \ how many dice show each face, 1..6

: #face ( face -- n ) cells counts + @ ;
: tally ( d1 d2 d3 d4 d5 -- ) counts 7 cells erase  5 0 do  1 swap cells counts + +!  loop ;
: total ( -- n ) 0  7 1 do i #face i * + loop ;

\ The face shown at least n times, or 0.
: face-with ( n -- face ) 0  7 1 do over i #face <= if drop i leave then loop nip ;
\ Whether some face shows exactly n times.
: exactly? ( n -- flag ) false  7 1 do over i #face = or loop nip ;
\ Whether the faces from first to last each show once.
: run? ( first last -- flag ) true -rot 1+ swap do i #face 1 = and loop ;

: full-house-score ( -- n ) 3 exactly? 2 exactly? and if total else 0 then ;
: four-of-a-kind-score ( -- n ) 4 face-with 4 * ;
: straight-score ( first last -- n ) run? 30 and ;
: yacht-score ( -- n ) 5 face-with 0<> 50 and ;

: score ( d1 d2 d3 d4 d5 category -- n )
  >r tally r>
  case
    full-house of full-house-score endof
    four-of-a-kind of four-of-a-kind-score endof
    little-straight of 1 5 straight-score endof
    big-straight of 2 6 straight-score endof
    choice of total endof
    yacht of yacht-score endof
    dup dup #face *  swap  \ ones..sixes: the face times its count
  endcase ;
