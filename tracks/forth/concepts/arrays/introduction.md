# Introduction

An array is cells laid down next to each other, handed around as `( addr n )`: the address of the first element and the number of elements.

```forth
create primes 2 , 3 , 5 , 7 , 11 ,   \ initialised
create scores 10 cells allot         \ reserved, not cleared
primes 2 cells + @ .                 \ element 2: prints 5
```

Loop by index with `0 ?do … over i cells + … loop`, or by address with `cells bounds ?do … i @ … cell +loop`, where `i` is the element's address.
`!` and `+!` change elements in place, and `unloop exit` leaves a search early.
Nothing checks indices: staying inside the array is up to you.
