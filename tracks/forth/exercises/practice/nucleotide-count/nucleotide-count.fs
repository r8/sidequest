\ Leaves the number of each nucleotide on the stack, in the order A C G T:
\   s" GATTACA" count-nucleotides  ( -- 3 1 1 2 )
\ Throws -24 (invalid numeric argument) when the strand holds anything but A, C, G and T.
: count-nucleotides ( c-addr u -- a c g t )
  true abort" implement me" ;
