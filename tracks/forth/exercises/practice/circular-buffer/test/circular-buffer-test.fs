require ../lib/test.fs
require ../circular-buffer.fs

\ Each test keeps its buffer on the return stack and frees it at the end.

test" reading empty buffer should fail"
  1 circular-buffer >r
  r@ ['] read-buffer buffer-empty assert-throws
  r> free throw ;test

test" can read an item just written"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ read-buffer 1 assert=
  r> free throw ;test

test" each item may only be read once"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ read-buffer 1 assert=
  r@ ['] read-buffer buffer-empty assert-throws
  r> free throw ;test

test" items are read in the order they are written"
  2 circular-buffer >r
  1 r@ write-buffer
  2 r@ write-buffer
  r@ read-buffer 1 assert=
  r@ read-buffer 2 assert=
  r> free throw ;test

: write-2 ( buf -- ) 2 swap write-buffer ;
test" full buffer can't be written to"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ ['] write-2 buffer-full assert-throws
  r> free throw ;test

test" a read frees up capacity for another write"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ read-buffer 1 assert=
  2 r@ write-buffer
  r@ read-buffer 2 assert=
  r> free throw ;test

test" read position is maintained even across multiple writes"
  3 circular-buffer >r
  1 r@ write-buffer
  2 r@ write-buffer
  r@ read-buffer 1 assert=
  3 r@ write-buffer
  r@ read-buffer 2 assert=
  r@ read-buffer 3 assert=
  r> free throw ;test

test" items cleared out of buffer can't be read"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ clear-buffer
  r@ ['] read-buffer buffer-empty assert-throws
  r> free throw ;test

test" clear frees up capacity for another write"
  1 circular-buffer >r
  1 r@ write-buffer
  r@ clear-buffer
  2 r@ write-buffer
  r@ read-buffer 2 assert=
  r> free throw ;test

test" clear does nothing on empty buffer"
  1 circular-buffer >r
  r@ clear-buffer
  1 r@ write-buffer
  r@ read-buffer 1 assert=
  r> free throw ;test

test" overwrite acts like write on non-full buffer"
  2 circular-buffer >r
  1 r@ write-buffer
  2 r@ overwrite-buffer
  r@ read-buffer 1 assert=
  r@ read-buffer 2 assert=
  r> free throw ;test

test" overwrite replaces the oldest item on full buffer"
  2 circular-buffer >r
  1 r@ write-buffer
  2 r@ write-buffer
  3 r@ overwrite-buffer
  r@ read-buffer 2 assert=
  r@ read-buffer 3 assert=
  r> free throw ;test

test" overwrite replaces the oldest item remaining in buffer following a read"
  3 circular-buffer >r
  1 r@ write-buffer
  2 r@ write-buffer
  3 r@ write-buffer
  r@ read-buffer 1 assert=
  4 r@ write-buffer
  5 r@ overwrite-buffer
  r@ read-buffer 3 assert=
  r@ read-buffer 4 assert=
  r@ read-buffer 5 assert=
  r> free throw ;test

test" initial clear does not affect wrapping around"
  2 circular-buffer >r
  r@ clear-buffer
  1 r@ write-buffer
  2 r@ write-buffer
  3 r@ overwrite-buffer
  4 r@ overwrite-buffer
  r@ read-buffer 3 assert=
  r@ read-buffer 4 assert=
  r@ ['] read-buffer buffer-empty assert-throws
  r> free throw ;test

end-tests
