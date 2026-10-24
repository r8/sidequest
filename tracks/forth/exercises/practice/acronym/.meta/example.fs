\ abbreviate leaves the uppercase acronym in a buffer it owns, valid until the next call.
\ A word starts at a letter that doesn't follow another letter or an apostrophe, so hyphens
\ and underscores separate words but "Halley's" is one word.
\ The buffer is allocated memory, resized for each phrase: there are no more letters in the
\ acronym than characters in the phrase.
variable acronym  1 allocate throw acronym !  variable #acronym
: room ( u -- ) chars 1 max  acronym @ swap resize throw  acronym ! ;

: c>acronym ( c -- ) acronym @ #acronym @ chars + c!  1 #acronym +! ;

: letter? ( c -- flag ) toupper [char] A [char] Z 1+ within ;
: in-word? ( c -- flag ) dup letter? swap [char] ' = or ;
: word-start? ( previous c -- flag ) letter? swap in-word? 0= and ;

: abbreviate ( c-addr u -- c-addr2 u2 )
  0 #acronym !  dup room
  bl -rot bounds ?do  ( previous )
    i c@ tuck word-start? if dup toupper c>acronym then
  loop
  drop acronym @ #acronym @ ;
