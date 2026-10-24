\ proteins translates an RNA strand codon by codon, up to the first STOP codon, and returns the
\ protein names as one string separated by single spaces: s" AUGUUUUGG" proteins gives
\ "Methionine Phenylalanine Tryptophan". The string lives in a buffer the solution owns and stays
\ valid until the next call.
\ Throw -24 (invalid numeric argument) for an invalid codon, including a trailing partial one
\ that translation reaches.

\ The buffer is allocated memory, resized for each strand: every three characters of the strand
\ add at most 14 to the string (a space and Phenylalanine), so five times its length is enough.
variable out  1 allocate throw out !  variable out#
: room ( u -- ) 5 * chars 1 max  out @ swap resize throw  out ! ;
: >out ( c-addr u -- ) tuck out @ out# @ chars + swap chars move out# +! ;

\ The codon table: entries of three codon characters followed by a counted protein name.
: str, ( c-addr u -- ) here over chars allot swap move ;
: codon ( "codon" "protein" -- ) parse-name str,  parse-name dup c, str, ;

create codons
  codon AUG Methionine
  codon UUU Phenylalanine  codon UUC Phenylalanine
  codon UUA Leucine        codon UUG Leucine
  codon UCU Serine  codon UCC Serine  codon UCA Serine  codon UCG Serine
  codon UAU Tyrosine       codon UAC Tyrosine
  codon UGU Cysteine       codon UGC Cysteine
  codon UGG Tryptophan
  codon UAA STOP  codon UAG STOP  codon UGA STOP
here constant codons-end

: protein ( entry -- c-addr u ) 3 chars + count ;
: next-entry ( entry -- entry' ) protein chars + ;

\ The protein for the codon at c-addr.
: codon>protein ( c-addr -- c-addr' u )
  codons begin dup codons-end < while
    2dup 3 tuck compare 0= if nip protein exit then
    next-entry
  repeat -24 throw ;

: stop? ( c-addr u -- flag ) s" STOP" compare 0= ;
: +protein ( c-addr u -- ) out# @ if s"  " >out then >out ;

: translate-codons ( c-addr u -- )
  begin dup while
    dup 3 < if -24 throw then
    over codon>protein 2dup stop? if 2drop 2drop exit then
    +protein  3 /string
  repeat 2drop ;

: proteins ( c-addr u -- c-addr' u' ) 0 out# !  dup room  translate-codons out @ out# @ ;
