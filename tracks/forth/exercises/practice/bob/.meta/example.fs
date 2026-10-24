\ response leaves one of Bob's five replies, a string the solution owns:
\   "Sure."  "Whoa, chill out!"  "Calm down, I know what I'm doing!"
\   "Fine. Be that way!"  "Whatever."
\ Whitespace is space, tab, newline and carriage return; multi-line input is one string.
: blank? ( c -- flag ) bl 1+ < ;
: last-char ( c-addr u -- c ) + 1- c@ ;
: -trailing-blanks ( c-addr u -- c-addr u' )
  begin dup while 2dup last-char blank? while 1- repeat then ;

\ Does xt ( c -- flag ) hold for any character of the string?
: any? ( c-addr u xt -- flag )
  -rot bounds ?do  i c@ over execute if drop true unloop exit then  loop
  drop false ;

: upper? ( c -- flag ) [char] A [char] Z 1+ within ;
: lower? ( c -- flag ) [char] a [char] z 1+ within ;

\ Both take a string without trailing whitespace.
: yelling? ( c-addr u -- flag ) 2dup ['] upper? any? -rot ['] lower? any? 0= and ;
: question? ( c-addr u -- flag ) last-char [char] ? = ;

\ 0 statement, 1 yelling, 2 question, 3 yelled question
: tone ( c-addr u -- n ) 2dup yelling? 1 and -rot question? 2 and or ;

: response ( c-addr u -- c-addr2 u2 )
  -trailing-blanks dup 0= if 2drop s" Fine. Be that way!" exit then
  tone case
    0 of s" Whatever." endof
    1 of s" Whoa, chill out!" endof
    2 of s" Sure." endof
    3 of s" Calm down, I know what I'm doing!" endof
  endcase ;
