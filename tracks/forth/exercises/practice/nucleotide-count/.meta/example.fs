\ Leaves the number of each nucleotide on the stack, in the order A C G T:
\   s" GATTACA" count-nucleotides  ( -- 3 1 1 2 )
\ Throws -24 (invalid numeric argument) when the strand holds anything but A, C, G and T.

: nucleotides ( -- c-addr u ) s" ACGT" ;

\ The position of a nucleotide in ACGT.
: index ( char -- n )
  >r nucleotides 2dup r> scan nip  dup 0= if -24 throw then  - nip ;

create counts 4 cells allot

: count-nucleotides ( c-addr u -- a c g t )
  counts 4 cells erase
  bounds ?do  1  i c@ index cells counts +  +!  loop
  counts 4 cells bounds do i @ cell +loop ;
