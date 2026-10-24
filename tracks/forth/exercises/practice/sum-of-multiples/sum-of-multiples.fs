\ Sum every number below limit that is a multiple of at least one of the factors, given as an
\ array of n cells. A factor of 0 has no multiples to add:
\   create factors 3 , 5 ,
\   factors 2 10 sum-of-multiples  ( -- 23 )
: sum-of-multiples ( addr n limit -- sum )
  true abort" implement me" ;
