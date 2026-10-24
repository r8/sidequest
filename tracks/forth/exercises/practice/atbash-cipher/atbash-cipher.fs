\ encode and decode leave their result in a buffer the solution owns, valid until the next
\ call to either word. Letters are mirrored (a <-> z) and lowercased, digits pass through,
\ everything else is dropped. encode groups its output in blocks of five separated by spaces:
\   s" yes" encode  gives "bvh"     s" vcvix rhn" decode  gives "exercism"
: encode ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;

: decode ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
