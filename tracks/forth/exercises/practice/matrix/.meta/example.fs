\ The matrix is a string ( c-addr u ) of rows separated by newlines, the numbers in a row by
\ spaces:  s\" 1 2\n3 4"  is a 2-by-2 matrix. row and column take a 1-based index and return that
\ row or column as an array of cells, in a buffer the solution owns, valid until the next call.
\ Throw -24 (invalid numeric argument) when the index is out of range.

\ The parsed matrix, row after row, and a picked column, in allocated memory resized for each
\ string: a number takes a digit and a separator, so u characters hold at most (u+1)/2 numbers.
variable numbers  1 allocate throw numbers !
variable #numbers  variable #rows
variable picked  1 allocate throw picked !
: renew ( var n -- ) cells 1 max  over @ swap resize throw  swap ! ;

: #columns ( -- n ) #numbers @ #rows @ / ;

: number, ( n -- ) numbers @ #numbers @ cells + !  1 #numbers +! ;

: decimal-digit? ( char -- flag ) [char] 0 [char] 9 1+ within ;

: parse-number ( c-addr u -- c-addr' u' n ) 0 0 2swap >number 2swap drop ;

: read-matrix ( c-addr u -- )
  0 #numbers !  1 #rows !  numbers over 1+ 2/ renew  picked over 1+ 2/ renew
  begin dup while
    over c@ dup decimal-digit? if
      drop parse-number number,
    else
      10 = if 1 #rows +! then  1 /string
    then
  repeat 2drop ;

: ?index ( i limit -- i ) over 1 rot 1+ within 0= if -24 throw then ;

: row ( c-addr u i -- addr n )
  >r read-matrix  r> #rows @ ?index
  1- #columns * cells numbers @ +  #columns ;

\ Copies every #columns-th number, starting at the column's top, into picked.
: column ( c-addr u i -- addr n )
  >r read-matrix  r> #columns ?index
  1- cells numbers @ +  #rows @ 0 ?do
    dup @ picked @ i cells + !  #columns cells +
  loop drop  picked @ #rows @ ;
