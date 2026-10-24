\ A moment is six numbers on the stack: year month day hour minute second, as in
\ 2015 1 24 22 0 0 for 2015-01-24T22:00:00. add leaves the moment one gigasecond
\ (10^9 seconds) later, in the same shape.

1000000000 constant gigasecond
86400 constant seconds/day

\ Dates count days from 0000-03-01, with the year starting in March so that the leap
\ day comes last (Howard Hinnant's days_from_civil and civil_from_days, for years >= 0).
: march-based ( y m -- y' m' ) dup 3 < if swap 1- swap 9 + else 3 - then ;
: leap-days ( y -- n ) dup 4 / over 100 / - swap 400 / + ;
: day-number ( y m d -- n )
  >r march-based  153 * 2 + 5 /  r> + 1-
  over 365 * + swap leap-days + ;

: year-of-era ( doe -- yoe ) dup dup 1460 / - over 36524 / + swap 146096 / - 365 / ;
: day-of-year ( doe yoe -- doy ) dup 365 * swap leap-days + - ;
: month-day ( doy -- m d )
  dup 5 * 2 + 153 /  tuck 153 * 2 + 5 / - 1+
  swap dup 10 < if 3 + else 9 - then swap ;
: date ( n -- y m d )
  146097 /mod 400 *              ( day-of-era year )
  over year-of-era tuck + >r     ( day-of-era year-of-era )
  day-of-year month-day  r> 2 pick 3 < - -rot ;

: seconds ( h min s -- n ) rot 60 * rot + 60 * + ;
: time ( n -- h min s ) 3600 /mod swap 60 /mod swap ;

: moment>seconds ( y m d h min s -- n ) seconds >r day-number seconds/day * r> + ;
: seconds>moment ( n -- y m d h min s ) seconds/day /mod date 3 roll time ;

: add ( y m d h min s -- y' m' d' h' min' s' )
  moment>seconds gigasecond + seconds>moment ;
