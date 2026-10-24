\ The area of a round pizza.
: pizza-area ( F: diameter -- area )
  true abort" implement me" ;

\ The area of one of slices equal slices.
: slice-area ( slices -- ) ( F: diameter -- area )
  true abort" implement me" ;

\ True when the first pizza costs strictly less per unit of area.
: better-deal? ( -- flag ) ( F: diameter1 price1 diameter2 price2 -- )
  true abort" implement me" ;

\ Whole pizzas to order for players who each eat appetite pizzas.
: pizzas-needed ( players -- pizzas ) ( F: appetite -- )
  true abort" implement me" ;

\ A 15% tip, rounded to the nearest whole euro.
: tip ( F: bill -- tip )
  true abort" implement me" ;
