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

: score ( d1 d2 d3 d4 d5 category -- n )
  true abort" implement me" ;
