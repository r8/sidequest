\ diamond takes an uppercase letter, [char] C diamond, and returns the diamond as one string:
\ rows separated by newlines, every row padded with spaces to the full width. The string lives
\ in a buffer the solution owns and stays valid until the next call.

create out 51 52 * chars allot  variable out#   \ up to 51 rows of 51 characters and a newline
: c>out ( c -- ) out out# @ chars + c!  1 out# +! ;

\ Row r of a diamond n letters past A: letter r sits r columns either side of the middle, n.
: row ( n r -- )
  over 2* 1+ 0 do
    over i - abs over = if dup [char] A + else bl then c>out
  loop 2drop  10 c>out ;

\ Rows 0 … n … 0, as k runs from -n to n.
: diamond ( char -- c-addr u )
  [char] A -  0 out# !
  dup 1+ over negate do  dup dup i abs - row  loop drop
  out out# @ 1- ;
