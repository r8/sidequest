\ roman returns the Roman numeral for n (1 to 3999) in a buffer the solution owns; it stays
\ valid until the next call.

create numeral 16 chars allot   \ a counted string; 3888 is the longest, MMMDCCCLXXXVIII

create amounts 1000 , 900 , 500 , 400 , 100 , 90 , 50 , 40 , 10 , 9 , 5 , 4 , 1 ,
13 constant #amounts
: amount ( i -- n ) cells amounts + @ ;
\ The symbols for each amount, two characters wide.
: symbol ( i -- c-addr u ) 2* chars s" M CMD CDC XCL XLX IXV IVI " drop + 2 -trailing ;

: roman ( n -- c-addr u )
  0 numeral c!
  #amounts 0 do
    begin dup i amount >= while  i symbol numeral +place  i amount -  repeat
  loop drop  numeral count ;
