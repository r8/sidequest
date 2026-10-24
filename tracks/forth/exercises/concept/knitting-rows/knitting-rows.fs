\ Stitches in a shawl whose rows have 1, 2, 3, … stitches.
: shawl-stitches ( rows -- total )
  true abort" implement me" ;

\ Stitches in a sleeve whose first row has start stitches, each row two more.
: sleeve-stitches ( rows start -- total )
  true abort" implement me" ;

\ Stitches in rows of start, start-step, … while a row has any.
: decrease-stitches ( start step -- total )
  true abort" implement me" ;

\ Complete sleeve rows from a ball of yarn good for yarn stitches.
: rows-from-ball ( yarn start -- rows )
  true abort" implement me" ;

\ Dark squares in a chequered blanket whose corner is dark.
: checker-squares ( width height -- dark )
  true abort" implement me" ;
