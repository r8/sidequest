\ The days in a month of a year that is not a leap year.
: days-in-month ( month -- days )
  true abort" implement me" ;

\ The rain in mm for a gauge code, or -1 for a faulty one.
: rain-mm ( code -- mm )
  true abort" implement me" ;

\ The month after the given one.
: next-month ( month -- month' )
  true abort" implement me" ;

\ The days in a month, with 29 in February of a leap year.
: month-length ( leap? month -- days )
  true abort" implement me" ;
