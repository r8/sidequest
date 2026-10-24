\ The days in a month of a year that is not a leap year.
: days-in-month ( month -- days )
  case
     2 of 28 endof
     4 of 30 endof
     6 of 30 endof
     9 of 30 endof
    11 of 30 endof
    31 swap
  endcase ;

\ The rain in mm for a gauge code, or -1 for a faulty one.
: rain-mm ( code -- mm )
  case
    0 of  0 endof
    1 of  1 endof
    2 of  4 endof
    3 of 16 endof
    -1 swap
  endcase ;

\ The month after the given one.
: next-month ( month -- month' )
  case
    12 of 1 endof
    dup 1+ swap
  endcase ;

\ The days in a month, with 29 in February of a leap year.
: month-length ( leap? month -- days )
  case
    2 of if 29 else 28 then endof
    nip dup days-in-month swap
  endcase ;
