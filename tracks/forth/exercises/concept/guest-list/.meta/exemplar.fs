\ Each word that returns memory allocates it, and the caller frees it:
\   s" Ada" copy-name  ( c-addr u )  ...  drop free throw
\   8 guest-slots      ( addr )      ...  free throw

\ The string being built: where it starts, and where the next characters go.
variable start  variable cursor
: new-string ( u -- ) chars allocate throw  dup start !  cursor ! ;
: put ( c-addr u -- ) tuck cursor @ swap chars move  chars cursor +! ;
: made ( -- c-addr u ) start @  cursor @ over - ;

\ A copy of the name in newly allocated memory.
: copy-name ( c-addr u -- c-addr2 u )
  dup new-string  put  made ;

\ "first last" in newly allocated memory.
: full-name ( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 )
  2 pick over + 1+ new-string  2swap put  s"  " put  put  made ;

\ n newly allocated cells, all 0.
: guest-slots ( n -- addr )
  cells dup allocate throw  tuck swap erase ;

\ The n1 cells at addr resized to n2, the first kept, any new ones 0; addr is not valid afterwards.
: resize-slots ( addr n1 n2 -- addr2 )
  rot over cells resize throw  -rot   \ addr2 n1 n2
  over - 0 max cells  swap cells      \ addr2 new-bytes old-bytes
  2 pick + swap erase ;
