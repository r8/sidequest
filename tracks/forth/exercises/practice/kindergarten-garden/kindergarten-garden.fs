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

: plants ( c-addr1 u1 c-addr2 u2 -- p1 p2 p3 p4 )
  true abort" implement me" ;
