\ gforth has no threads, so this is plain letter frequency over a list of texts.
\ count-letters takes n strings, each as ( c-addr u ), followed by their number n:
\   s" ggh" s" hhi" 2 count-letters  [char] h frequency  ( -- 3 )
\ Letters a-z count case-insensitively; everything else is ignored. The counts stay until the next
\ count-letters. frequency takes a lowercase letter and gives 0 for a letter that never appeared;
\ #letters is the number of distinct letters seen.

create counts 26 cells allot

\ Letters are folded to upper case (gforth 0.7.3 has toupper but no tolower).
: counter ( char -- addr ) [char] A - cells counts + ;
: letter? ( char -- flag ) [char] A [char] Z 1+ within ;
: tally ( char -- ) toupper dup letter? if counter 1 swap +! else drop then ;
: tally-text ( c-addr u -- ) bounds ?do i c@ tally loop ;

: count-letters ( c-addr1 u1 ... c-addrn un n -- )
  counts 26 cells erase  0 ?do tally-text loop ;

: frequency ( char -- n ) toupper dup letter? if counter @ else drop 0 then ;

: #letters ( -- n ) 0  26 0 do counts i cells + @ 0<> - loop ;
