# A buffer is a mutable table made by make-buffer; the other functions change or read it.
# The items live in a fixed array of slots; :start is the slot of the oldest, :size the item count.

(defn make-buffer
  "(make-buffer capacity) -> a new empty buffer that holds up to capacity items"
  [capacity]
  @{:slots (array/new-filled capacity) :start 0 :size 0})

(defn- capacity [buffer]
  (length (buffer :slots)))

(defn read
  "(read buffer) -> the oldest item, removed from buffer; errors with \"buffer is empty\" if there is none"
  [buffer]
  (when (zero? (buffer :size)) (error "buffer is empty"))
  (def item (get-in buffer [:slots (buffer :start)]))
  (update buffer :start |(mod (inc $) (capacity buffer)))
  (update buffer :size dec)
  item)

(defn write
  "(write buffer item) -> buffer, with item added as the newest; errors with \"buffer is full\" if it is full"
  [buffer item]
  (when (= (buffer :size) (capacity buffer)) (error "buffer is full"))
  (put-in buffer [:slots (mod (+ (buffer :start) (buffer :size)) (capacity buffer))] item)
  (update buffer :size inc))

(defn overwrite
  "(overwrite buffer item) -> buffer, with item added as the newest, replacing the oldest item if it is full"
  [buffer item]
  (when (= (buffer :size) (capacity buffer)) (read buffer))
  (write buffer item))

(defn clear
  "(clear buffer) -> buffer, now empty"
  [buffer]
  (merge-into buffer {:start 0 :size 0}))
