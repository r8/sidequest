\ response leaves one of Bob's five replies, a string the solution owns:
\   "Sure."  "Whoa, chill out!"  "Calm down, I know what I'm doing!"
\   "Fine. Be that way!"  "Whatever."
\ Whitespace is space, tab, newline and carriage return; multi-line input is one string.
: response ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
