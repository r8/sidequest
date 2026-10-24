\ meetup returns the day of the month of the meetup: 2013 5 teenth monday meetup gives 13.
\ Weeks are the constants first second third fourth last teenth (the days 13 to 19);
\ weekdays are monday … sunday.
1 constant first
2 constant second
3 constant third
4 constant fourth
5 constant last
6 constant teenth

1 constant monday
2 constant tuesday
3 constant wednesday
4 constant thursday
5 constant friday
6 constant saturday
7 constant sunday

: leap-year? ( year -- flag )
  dup 4 mod 0= over 100 mod 0<> and swap 400 mod 0= or ;
\ 31 and 30 alternate, with the run of 31s restarting in August.
: days-in-month ( year month -- n )
  dup 2 = if drop leap-year? if 29 else 28 then exit then
  nip dup 8 / + 1 and 30 + ;

\ Days since 0000-03-01, a Wednesday, with the year starting in March (years >= 0).
: march-based ( y m -- y' m' ) dup 3 < if swap 1- swap 9 + else 3 - then ;
: day-number ( y m d -- n )
  >r march-based  153 * 2 + 5 /  r> + 1-
  over 365 * +  over 4 / +  over 100 / -  swap 400 / + ;
: weekday ( y m d -- weekday ) day-number 2 + 7 mod 1+ ;

\ The first day of the seven the meetup falls in.
: week-start ( year month week -- day )
  dup last = if drop days-in-month 6 - exit then
  nip nip dup teenth = if drop 13 else 1- 7 * 1+ then ;

: meetup ( year month week weekday -- day )
  >r >r 2dup r> week-start  ( year month start )
  dup >r weekday r>         ( start-weekday start )
  swap r> swap - 7 + 7 mod + ;
