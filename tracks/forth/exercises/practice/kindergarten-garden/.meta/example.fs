\ plants takes the garden diagram, two rows of plant letters separated by a newline, and a student's
\ name, and leaves that student's four plants on the stack: the two in the first row, then the two
\ in the second row, left to right.
\   s\" VVCG\nVVRC" s" Bob" plants  ( -- clover grass radishes clover )
\ The students, in alphabetical order, each own two cups per row: Alice, Bob, Charlie, David, Eve,
\ Fred, Ginny, Harriet, Ileana, Joseph, Kincaid and Larry. The plants are these constants:
0 constant grass     \ G
1 constant clover    \ C
2 constant radishes  \ R
3 constant violets   \ V

: plant ( char -- p )
  case
    [char] G of grass endof
    [char] C of clover endof
    [char] R of radishes endof
    [char] V of violets endof
    -24 throw
  endcase ;

\ The students are alphabetical, so the first letter of the name gives the column pair.
: column ( c-addr u -- n ) drop c@ [char] A - 2* ;

\ The width of a row: the diagram's length up to the newline.
: row-length ( c-addr u -- c-addr n ) 2dup 10 scan nip - ;

: cups ( c-addr -- p1 p2 ) dup c@ plant  swap char+ c@ plant ;

: plants ( c-addr1 u1 c-addr2 u2 -- p1 p2 p3 p4 )
  column >r  row-length 1+ chars over +  ( row1 row2 )
  swap r@ chars + cups  rot r> chars + cups ;
