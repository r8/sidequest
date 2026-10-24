# A buffer is a mutable table made by make-buffer; the other functions change or read it.

(defn make-buffer
  "(make-buffer capacity) -> a new empty buffer that holds up to capacity items"
  [capacity]
  (error "implement me"))

(defn read
  "(read buffer) -> the oldest item, removed from buffer; errors with \"buffer is empty\" if there is none"
  [buffer]
  (error "implement me"))

(defn write
  "(write buffer item) -> buffer, with item added as the newest; errors with \"buffer is full\" if it is full"
  [buffer item]
  (error "implement me"))

(defn overwrite
  "(overwrite buffer item) -> buffer, with item added as the newest, replacing the oldest item if it is full"
  [buffer item]
  (error "implement me"))

(defn clear
  "(clear buffer) -> buffer, now empty"
  [buffer]
  (error "implement me"))
