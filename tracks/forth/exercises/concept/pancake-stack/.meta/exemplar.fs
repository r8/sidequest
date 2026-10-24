\ Three pancakes per guest, but never fewer than six.
: pancakes-for ( guests -- pancakes )
  3 * 6 max ;

\ The height of a stack in mm: 8 mm per pancake plus 5 mm of butter.
: stack-height ( pancakes -- mm )
  8 * 5 + ;

\ The number of plates of four that can be filled.
: full-plates ( pancakes -- plates )
  4 / ;

\ The pancakes left after filling the plates.
: spare-pancakes ( pancakes -- spare )
  4 mod ;

\ Rounds of six on the griddle, counting a partly full one.
: griddle-rounds ( pancakes -- rounds )
  5 + 6 / ;
