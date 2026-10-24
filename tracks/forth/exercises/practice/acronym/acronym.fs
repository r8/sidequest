\ abbreviate leaves the uppercase acronym in a buffer it owns, valid until the next call.
\ A word starts at a letter that doesn't follow another letter or an apostrophe, so hyphens
\ and underscores separate words but "Halley's" is one word.
: abbreviate ( c-addr u -- c-addr2 u2 )
  true abort" implement me" ;
