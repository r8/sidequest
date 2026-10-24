\ Three pancakes per guest, but never fewer than six.
: pancakes-for ( guests -- pancakes )
  true abort" implement me" ;

\ The height of a stack in mm: 8 mm per pancake plus 5 mm of butter.
: stack-height ( pancakes -- mm )
  true abort" implement me" ;

\ The number of plates of four that can be filled.
: full-plates ( pancakes -- plates )
  true abort" implement me" ;

\ The pancakes left after filling the plates.
: spare-pancakes ( pancakes -- spare )
  true abort" implement me" ;

\ Rounds of six on the griddle, counting a partly full one.
: griddle-rounds ( pancakes -- rounds )
  true abort" implement me" ;
