\ A circular buffer of cells. circular-buffer allocates one (with allocate) with room for
\ capacity items and returns its address; every operation takes that address last, and free
\ releases it:
\   3 circular-buffer  42 over write-buffer  dup read-buffer .  free throw
\ read-buffer on an empty buffer throws buffer-empty; write-buffer on a full one throws
\ buffer-full. overwrite-buffer on a full buffer replaces the oldest item instead.
\ Throw -24 (invalid numeric argument) for a capacity below 1.

1 constant buffer-empty
2 constant buffer-full

: circular-buffer ( capacity -- buf )
  true abort" implement me" ;

: read-buffer ( buf -- x )
  true abort" implement me" ;

: write-buffer ( x buf -- )
  true abort" implement me" ;

: overwrite-buffer ( x buf -- )
  true abort" implement me" ;

: clear-buffer ( buf -- )
  true abort" implement me" ;
