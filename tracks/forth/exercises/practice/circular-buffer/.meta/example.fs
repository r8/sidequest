\ A circular buffer of cells. circular-buffer allocates one (with allocate) with room for
\ capacity items and returns its address; every operation takes that address last, and free
\ releases it:
\   3 circular-buffer  42 over write-buffer  dup read-buffer .  free throw
\ read-buffer on an empty buffer throws buffer-empty; write-buffer on a full one throws
\ buffer-full. overwrite-buffer on a full buffer replaces the oldest item instead.
\ Throw -24 (invalid numeric argument) for a capacity below 1.

1 constant buffer-empty
2 constant buffer-full

\ Layout: capacity, item count, index of the oldest item, then capacity cells of items.
: capacity ( buf -- n ) @ ;
: #items ( buf -- addr ) cell+ ;
: oldest ( buf -- addr ) 2 cells + ;
: slot ( buf i -- addr ) 3 + cells + ;

: clear-buffer ( buf -- ) 0 over #items !  0 swap oldest ! ;

: circular-buffer ( capacity -- buf )
  dup 1 < if -24 throw then
  dup 3 + cells allocate throw  tuck !  dup clear-buffer ;

: empty? ( buf -- flag ) #items @ 0= ;
: full? ( buf -- flag ) dup #items @ swap capacity = ;
: wrap ( buf i -- i' ) swap capacity mod ;
: free-slot ( buf -- addr ) dup dup oldest @ over #items @ + wrap slot ;

: drop-oldest ( buf -- )
  dup dup oldest @ 1+ wrap over oldest !  -1 swap #items +! ;

: read-buffer ( buf -- x )
  dup empty? if buffer-empty throw then
  dup dup oldest @ slot @  swap drop-oldest ;

: write-buffer ( x buf -- )
  dup full? if buffer-full throw then
  tuck free-slot !  1 swap #items +! ;

: overwrite-buffer ( x buf -- )
  dup full? if dup drop-oldest then write-buffer ;
