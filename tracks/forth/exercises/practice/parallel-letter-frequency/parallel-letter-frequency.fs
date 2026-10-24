\ gforth has no threads, so this is plain letter frequency over a list of texts.
\ count-letters takes n strings, each as ( c-addr u ), followed by their number n:
\   s" ggh" s" hhi" 2 count-letters  [char] h frequency  ( -- 3 )
\ Letters a-z count case-insensitively; everything else is ignored. The counts stay until the next
\ count-letters. frequency takes a lowercase letter and gives 0 for a letter that never appeared;
\ #letters is the number of distinct letters seen.
: count-letters ( c-addr1 u1 ... c-addrn un n -- )
  true abort" implement me" ;

: frequency ( char -- n )
  true abort" implement me" ;

: #letters ( -- n )
  true abort" implement me" ;
