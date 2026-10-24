(import test :as t)
(import ../circular-buffer :as sol)

(t/deftest "reading empty buffer should fail"
  (def buffer (sol/make-buffer 1))
  (t/assert-error "buffer is empty" (sol/read buffer)))

(t/deftest "can read an item just written"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (t/assert-equal 1 (sol/read buffer)))

(t/deftest "each item may only be read once"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (t/assert-equal 1 (sol/read buffer))
  (t/assert-error "buffer is empty" (sol/read buffer)))

(t/deftest "items are read in the order they are written"
  (def buffer (sol/make-buffer 2))
  (sol/write buffer 1)
  (sol/write buffer 2)
  (t/assert-equal 1 (sol/read buffer))
  (t/assert-equal 2 (sol/read buffer)))

(t/deftest "full buffer can't be written to"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (t/assert-error "buffer is full" (sol/write buffer 2)))

(t/deftest "a read frees up capacity for another write"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (t/assert-equal 1 (sol/read buffer))
  (sol/write buffer 2)
  (t/assert-equal 2 (sol/read buffer)))

(t/deftest "read position is maintained even across multiple writes"
  (def buffer (sol/make-buffer 3))
  (sol/write buffer 1)
  (sol/write buffer 2)
  (t/assert-equal 1 (sol/read buffer))
  (sol/write buffer 3)
  (t/assert-equal 2 (sol/read buffer))
  (t/assert-equal 3 (sol/read buffer)))

(t/deftest "items cleared out of buffer can't be read"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (sol/clear buffer)
  (t/assert-error "buffer is empty" (sol/read buffer)))

(t/deftest "clear frees up capacity for another write"
  (def buffer (sol/make-buffer 1))
  (sol/write buffer 1)
  (sol/clear buffer)
  (sol/write buffer 2)
  (t/assert-equal 2 (sol/read buffer)))

(t/deftest "clear does nothing on empty buffer"
  (def buffer (sol/make-buffer 1))
  (sol/clear buffer)
  (sol/write buffer 1)
  (t/assert-equal 1 (sol/read buffer)))

(t/deftest "overwrite acts like write on non-full buffer"
  (def buffer (sol/make-buffer 2))
  (sol/write buffer 1)
  (sol/overwrite buffer 2)
  (t/assert-equal 1 (sol/read buffer))
  (t/assert-equal 2 (sol/read buffer)))

(t/deftest "overwrite replaces the oldest item on full buffer"
  (def buffer (sol/make-buffer 2))
  (sol/write buffer 1)
  (sol/write buffer 2)
  (sol/overwrite buffer 3)
  (t/assert-equal 2 (sol/read buffer))
  (t/assert-equal 3 (sol/read buffer)))

(t/deftest "overwrite replaces the oldest item remaining in buffer following a read"
  (def buffer (sol/make-buffer 3))
  (sol/write buffer 1)
  (sol/write buffer 2)
  (sol/write buffer 3)
  (t/assert-equal 1 (sol/read buffer))
  (sol/write buffer 4)
  (sol/overwrite buffer 5)
  (t/assert-equal 3 (sol/read buffer))
  (t/assert-equal 4 (sol/read buffer))
  (t/assert-equal 5 (sol/read buffer)))

(t/deftest "initial clear does not affect wrapping around"
  (def buffer (sol/make-buffer 2))
  (sol/clear buffer)
  (sol/write buffer 1)
  (sol/write buffer 2)
  (sol/overwrite buffer 3)
  (sol/overwrite buffer 4)
  (t/assert-equal 3 (sol/read buffer))
  (t/assert-equal 4 (sol/read buffer))
  (t/assert-error "buffer is empty" (sol/read buffer)))

(t/run)
