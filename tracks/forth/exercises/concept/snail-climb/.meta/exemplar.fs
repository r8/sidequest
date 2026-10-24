\ The number of decimal digits in n, which is 0 or more.
: digit-count ( n -- digits )
  0 swap begin  swap 1+ swap  10 /  dup 0= until  drop ;

\ Hours of halving until the trail is shorter than limit.
: dry-hours ( trail limit -- hours )
  0 -rot begin  2dup >=  while  swap 2/ swap  rot 1+ -rot  repeat  2drop ;

\ The day a snail climbing up a day and slipping 1 a night reaches the top.
: climb-days ( depth up -- days )
  0 begin            \ to-go up days
    1+ -rot tuck -   \ days up to-go'
    dup 0>
  while
    1+ swap rot      \ to-go up days
  repeat 2drop ;

\ The first square-numbered day after day.
: next-feast-day ( day -- day' )
  1 begin  2dup dup * >=  while  1+  repeat  nip dup * ;
