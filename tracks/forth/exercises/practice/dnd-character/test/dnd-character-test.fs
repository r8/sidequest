require ../lib/test.fs
require ../dnd-character.fs

test" ability modifier > ability modifier for score 3 is -4"  3 modifier -4 assert= ;test
test" ability modifier > ability modifier for score 4 is -3"  4 modifier -3 assert= ;test
test" ability modifier > ability modifier for score 5 is -3"  5 modifier -3 assert= ;test
test" ability modifier > ability modifier for score 6 is -2"  6 modifier -2 assert= ;test
test" ability modifier > ability modifier for score 7 is -2"  7 modifier -2 assert= ;test
test" ability modifier > ability modifier for score 8 is -1"  8 modifier -1 assert= ;test
test" ability modifier > ability modifier for score 9 is -1"  9 modifier -1 assert= ;test
test" ability modifier > ability modifier for score 10 is 0"  10 modifier 0 assert= ;test
test" ability modifier > ability modifier for score 11 is 0"  11 modifier 0 assert= ;test
test" ability modifier > ability modifier for score 12 is +1"  12 modifier 1 assert= ;test
test" ability modifier > ability modifier for score 13 is +1"  13 modifier 1 assert= ;test
test" ability modifier > ability modifier for score 14 is +2"  14 modifier 2 assert= ;test
test" ability modifier > ability modifier for score 15 is +2"  15 modifier 2 assert= ;test
test" ability modifier > ability modifier for score 16 is +3"  16 modifier 3 assert= ;test
test" ability modifier > ability modifier for score 17 is +3"  17 modifier 3 assert= ;test
test" ability modifier > ability modifier for score 18 is +4"  18 modifier 4 assert= ;test
test" random ability is within range"
  true  1000 0 do ability 3 19 within and loop assert-true ;test

create hero /character allot
: valid-ability? ( n -- flag ) 3 19 within ;
: valid-hero? ( -- flag )
  hero strength valid-ability?  hero dexterity valid-ability? and  hero constitution valid-ability? and
  hero intelligence valid-ability? and  hero wisdom valid-ability? and  hero charisma valid-ability? and
  hero hitpoints  hero constitution modifier 10 +  = and ;
test" random character is valid"
  true  1000 0 do hero roll-character  valid-hero? and loop assert-true ;test

test" each ability is only calculated once"
  hero roll-character
  hero strength hero strength assert=  hero dexterity hero dexterity assert=
  hero constitution hero constitution assert=  hero intelligence hero intelligence assert=
  hero wisdom hero wisdom assert=  hero charisma hero charisma assert= ;test

end-tests
