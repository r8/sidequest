\ The four buttons, each ( volume -- volume' ) for a volume from 0 to 10.
: louder ( volume -- volume' ) 1+ 10 min ;
: quieter ( volume -- volume' ) 1- 0 max ;
: mute ( volume -- 0 ) drop 0 ;
: loudest ( volume -- 10 ) drop 10 ;

\ Runs xt on x, then on the result.
: twice ( x xt -- x' )
  tuck execute swap execute ;

create buttons  ' louder ,  ' quieter ,  ' mute ,  ' loudest ,

\ The xt of button n: 0 louder, 1 quieter, 2 mute, 3 loudest.
: button ( n -- xt )
  cells buttons + @ ;

\ The volume after pressing button n.
: press ( volume n -- volume' )
  button execute ;

\ The volume after pressing each of the n buttons at addr in order.
: press-all ( volume addr n -- volume' )
  cells bounds ?do  i @ press  cell +loop ;

\ Replaces each of the n cells at addr with the result of running xt on it.
: apply-to-all ( addr n xt -- )
  -rot cells bounds ?do  i @ over execute i !  cell +loop  drop ;
