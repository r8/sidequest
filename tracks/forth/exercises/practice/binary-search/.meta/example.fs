\ Search the sorted array of n cells at addr for value; return its 0-based index.
\ Throw -24 (invalid numeric argument) when the value is not in the array.

: midpoint ( lo hi -- mid ) over - 2/ + ;
: probe ( addr mid -- x ) cells + @ ;

\ The search range is [lo, hi); value stays on the return stack.
: binary-search ( addr n value -- index )
  >r 0 swap
  begin 2dup < while                   ( addr lo hi )
    2dup midpoint  3 pick over probe   ( addr lo hi mid x )
    dup r@ = if drop nip nip nip rdrop exit then
    r@ < if rot drop 1+ swap else nip then
  repeat
  rdrop -24 throw ;
