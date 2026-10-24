\ The four buttons, each ( volume -- volume' ) for a volume from 0 to 10.
: louder ( volume -- volume' ) 1+ 10 min ;
: quieter ( volume -- volume' ) 1- 0 max ;
: mute ( volume -- 0 ) drop 0 ;
: loudest ( volume -- 10 ) drop 10 ;

\ Runs xt on x, then on the result.
: twice ( x xt -- x' )
  true abort" implement me" ;

\ The xt of button n: 0 louder, 1 quieter, 2 mute, 3 loudest.
: button ( n -- xt )
  true abort" implement me" ;

\ The volume after pressing button n.
: press ( volume n -- volume' )
  true abort" implement me" ;

\ The volume after pressing each of the n buttons at addr in order.
: press-all ( volume addr n -- volume' )
  true abort" implement me" ;

\ Replaces each of the n cells at addr with the result of running xt on it.
: apply-to-all ( addr n xt -- )
  true abort" implement me" ;
