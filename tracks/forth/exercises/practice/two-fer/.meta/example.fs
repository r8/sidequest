\ two-fer leaves its sentence in a buffer it owns, valid until the next call.
\ An empty name (0 0, or s" ") means no name was given:
\   0 0 two-fer          gives "One for you, one for me."
\   s" Alice" two-fer    gives "One for Alice, one for me."
\ The buffer is allocated memory, resized for each name to fit the name and the 21 other characters.
variable sentence  1 allocate throw sentence !  variable #sentence
: room ( u -- ) 21 + chars  sentence @ swap resize throw  sentence ! ;
: >sentence ( c-addr u -- ) tuck sentence @ #sentence @ chars + swap chars move  #sentence +! ;

: name-or-you ( c-addr u -- c-addr u ) dup 0= if 2drop s" you" then ;

: two-fer ( c-addr u -- c-addr2 u2 )
  name-or-you  dup room  0 #sentence !
  s" One for " >sentence  >sentence  s" , one for me." >sentence
  sentence @ #sentence @ ;
