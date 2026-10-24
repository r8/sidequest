\ Stitches in a shawl whose rows have 1, 2, 3, … stitches.
: shawl-stitches ( rows -- total )
  0 swap 1+ 1 ?do i + loop ;

\ Stitches in a sleeve whose first row has start stitches, each row two more.
: sleeve-stitches ( rows start -- total )
  0 rot 0 ?do  over i 2* + +  loop nip ;

\ Stitches in rows of start, start-step, … while a row has any.
: decrease-stitches ( start step -- total )
  negate 0 rot 1 swap do  i +  over +loop nip ;

\ Complete sleeve rows from a ball of yarn good for yarn stitches.
: rows-from-ball ( yarn start -- rows )
  100 0 do
    2dup < if 2drop i unloop exit then
    tuck - swap 2 +
  loop 2drop 100 ;

\ Dark squares in a chequered blanket whose corner is dark.
: checker-squares ( width height -- dark )
  0 swap 0 ?do
    over 0 ?do  i j + 2 mod 0= if 1+ then  loop
  loop nip ;
