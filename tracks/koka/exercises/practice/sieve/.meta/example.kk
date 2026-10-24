// Takes the smallest remaining candidate as the next prime and crosses out its multiples.
fun sift(candidates : list<int>) : div list<int>
  match candidates
    Nil -> Nil
    Cons(p, rest) -> Cons(p, sift(rest.filter(fn(n) n % p != 0)))

// primes(limit) -> the primes from 2 up to and including `limit`, in increasing order,
// found with the Sieve of Eratosthenes
pub fun primes(limit : int) : div list<int>
  sift(list(2, limit))
