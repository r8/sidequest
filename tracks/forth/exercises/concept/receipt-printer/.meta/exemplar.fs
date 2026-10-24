\ Every word leaves its text in the system's picture buffer, valid until the next number is formatted.

\ Cents as dollars and cents: 1250 gives 12.50.
: price ( cents -- c-addr u )
  0 <# # # [char] . hold #s #> ;

\ Like price, with a - in front of a negative amount.
: amount ( cents -- c-addr u )
  dup abs 0 <# # # [char] . hold #s rot sign #> ;

\ The number padded with zeros to six digits.
: ticket-number ( n -- c-addr u )
  0 <# # # # # # # #> ;

\ The number in hexadecimal; the base is unchanged afterwards.
: hex-code ( n -- c-addr u )
  base @ >r  hex  0 <# #s #>  r> base ! ;

\ The number as eight binary digits; the base is unchanged afterwards.
: binary-byte ( n -- c-addr u )
  base @ >r  2 base !  0 <# 8 0 do # loop #>  r> base ! ;
