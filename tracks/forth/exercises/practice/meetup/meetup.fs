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

: meetup ( year month week weekday -- day )
  true abort" implement me" ;
