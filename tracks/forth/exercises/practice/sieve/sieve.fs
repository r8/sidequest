\ The primes up to and including limit, found with the Sieve of Eratosthenes (no division),
\ as an array of n cells in a buffer the solution owns, valid until the next call:
\   10 primes  ( -- addr 4 )  \ 2 3 5 7
: primes ( limit -- addr n )
  true abort" implement me" ;
