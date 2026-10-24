\ The area of a square stage.
: stage-area ( side -- area )
  dup * ;

\ Balls in both hands, and how many more the left hand holds.
: hands ( left right -- total difference )
  2dup + -rot - ;

\ The square of the distance between two grid points.
: squared-distance ( x1 y1 x2 y2 -- d² )
  rot - stage-area  -rot - stage-area  + ;

\ The highest of three heights minus the lowest.
: spread ( h1 h2 h3 -- spread )
  2dup max -rot min      \ h1 hi23 lo23
  rot tuck min -rot max  \ lo hi
  swap - ;

\ The height between the other two.
: middle-throw ( h1 h2 h3 -- median )
  -rot 2dup min -rot max  \ h3 lo12 hi12
  rot min max ;
