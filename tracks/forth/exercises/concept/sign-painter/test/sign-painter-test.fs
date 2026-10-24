require ../lib/test.fs
require ../sign-painter.fs

\ 100 lower-case x's and 80 upper-case X's, for the 80-character limit.
create xs 100 chars allot  xs 100 char x fill
create big-xs 80 chars allot  big-xs 80 char X fill

test" 1. a mixed-case sign"  s" Fresh bread!" shout s" FRESH BREAD!" assert-str= ;test
test" 1. a sign already in capitals"  s" OPEN" shout s" OPEN" assert-str= ;test
test" 1. digits and punctuation are unchanged"  s" 2-for-1 @ 9am" shout s" 2-FOR-1 @ 9AM" assert-str= ;test
test" 1. an empty sign"  s" " shout s" " assert-str= ;test
test" 1. a sign too long for the board"  xs 100 shout big-xs 80 assert-str= ;test

test" 2. a short sign"  s" Open" framed s" * Open *" assert-str= ;test
test" 2. an empty sign"  s" " framed s" *  *" assert-str= ;test
test" 2. a framed loud sign"  s" closed" shout framed s" * CLOSED *" assert-str= ;test
test" 2. a sign too long for the frame"  big-xs 78 framed nip 80 assert= ;test
test" 2. framing a sign leaves the last loud sign as it was"
  s" open" shout  s" closed" framed 2drop  s" OPEN" assert-str= ;test

test" 3. three times"  s" SALE" 3 repeated s" SALE SALE SALE" assert-str= ;test
test" 3. once"  s" SALE" 1 repeated s" SALE" assert-str= ;test
test" 3. no times"  s" SALE" 0 repeated s" " assert-str= ;test
test" 3. too many times for the board"
  s" SALE" 20 repeated  s" SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE SALE " assert-str= ;test

test" 4. a word"  s" SALE" spaced-out s" S A L E" assert-str= ;test
test" 4. a single character"  s" X" spaced-out s" X" assert-str= ;test
test" 4. an empty sign"  s" " spaced-out s" " assert-str= ;test
test" 4. two words"  s" HI YO" spaced-out s" H I   Y O" assert-str= ;test
test" 4. too long for the board"  xs 50 spaced-out nip 80 assert= ;test

end-tests
