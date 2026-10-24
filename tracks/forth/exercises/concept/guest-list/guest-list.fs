\ Each word that returns memory allocates it, and the caller frees it:
\   s" Ada" copy-name  ( c-addr u )  ...  drop free throw
\   8 guest-slots      ( addr )      ...  free throw

\ A copy of the name in newly allocated memory.
: copy-name ( c-addr u -- c-addr2 u )
  true abort" implement me" ;

\ "first last" in newly allocated memory.
: full-name ( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 )
  true abort" implement me" ;

\ n newly allocated cells, all 0.
: guest-slots ( n -- addr )
  true abort" implement me" ;

\ The n1 cells at addr resized to n2, the first kept, any new ones 0; addr is not valid afterwards.
: resize-slots ( addr n1 n2 -- addr2 )
  true abort" implement me" ;
