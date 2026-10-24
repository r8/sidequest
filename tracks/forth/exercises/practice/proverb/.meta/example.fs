\ The pieces come in as one string of words separated by single spaces, "nail shoe horse".
\ The proverb comes back as one string, its lines separated by newlines, in a buffer the solution
\ owns; it stays valid until the next call. No pieces make an empty proverb.

\ The buffer is allocated memory, resized for each recital. Each of the k words adds at most 30
\ characters besides the words, which appear at most twice, and k <= (u+1)/2: 17u + 15 is enough.
variable out  1 allocate throw out !  variable out#
: room ( u -- ) 17 * 15 + chars  out @ swap resize throw  out ! ;
: >out ( c-addr u -- ) tuck out @ out# @ chars + swap chars move out# +! ;

: first-word ( c-addr u -- c-addr u' ) 2dup bl scan nip - ;
: other-words ( c-addr u -- c-addr' u' ) bl scan dup if 1 /string then ;

: for-want ( c-addr1 u1 c-addr2 u2 -- )
  2swap s" For want of a " >out >out  s"  the " >out >out  s\"  was lost.\n" >out ;
: and-all ( c-addr u -- ) s" And all for the want of a " >out >out s" ." >out ;

\ One line per neighbouring pair of words.
: pairs ( c-addr u -- )
  begin 2dup other-words dup while
    2swap first-word 2over first-word for-want
  repeat 2drop 2drop ;

: recite ( c-addr u -- c-addr' u' )
  0 out# !  dup room
  dup if 2dup pairs first-word and-all else 2drop then
  out @ out# @ ;
