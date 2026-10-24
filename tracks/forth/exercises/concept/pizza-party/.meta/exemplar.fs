\ The area of a round pizza.
: pizza-area ( F: diameter -- area )
  2e f/ fdup f* pi f* ;

\ The area of one of slices equal slices.
: slice-area ( slices -- ) ( F: diameter -- area )
  pizza-area s>f f/ ;

: price-per-area ( F: diameter price -- price/area )
  fswap pizza-area f/ ;

\ True when the first pizza costs strictly less per unit of area.
: better-deal? ( -- flag ) ( F: diameter1 price1 diameter2 price2 -- )
  price-per-area frot frot price-per-area fswap f< ;

\ Whole pizzas to order for players who each eat appetite pizzas.
: pizzas-needed ( players -- pizzas ) ( F: appetite -- )
  s>f f* fnegate floor fnegate f>s ;

\ A 15% tip, rounded to the nearest whole euro.
: tip ( F: bill -- tip )
  0.15e f* fround ;
