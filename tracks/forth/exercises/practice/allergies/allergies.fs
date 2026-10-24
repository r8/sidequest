\ An allergy score is the sum of the scores of the allergens:
\   eggs 1, peanuts 2, shellfish 4, strawberries 8, tomatoes 16, chocolate 32, pollen 64, cats 128.
\ Higher bits of the score name no allergen and are ignored.
\
\ allergic-to? takes the allergen's name:  s" eggs" 1 allergic-to?
\ It throws -24 (invalid numeric argument) for a name that isn't one of the eight allergens.
: allergic-to? ( c-addr u score -- flag )
  true abort" implement me" ;

\ The allergens in the score, in the order above, separated by single spaces ("eggs peanuts").
\ The string is in a buffer the solution owns, valid until the next call.
: allergies ( score -- c-addr u )
  true abort" implement me" ;
