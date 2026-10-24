(defn read-here
  "(read-here shelf title f) -> what (f title) returns; the book is :reading meanwhile and :in afterwards"
  [shelf title f]
  (put shelf title :reading)
  (defer (put shelf title :in)
    (f title)))

(defn lend
  "(lend shelf title f) -> what (f title) returns; the book is :out, or back :in if f fails"
  [shelf title f]
  (put shelf title :out)
  (edefer (put shelf title :in)
    (f title)))

(defn reading-room
  "(reading-room log) -> table with :log and a :close method that logs \"room closed\""
  [log]
  @{:log log
    :close (fn [self] (array/push (self :log) "room closed"))})

(defn study
  "(study log f) -> what (f room) returns; the room is closed afterwards"
  [log f]
  (with [room (reading-room log)]
    (f room)))

(defn with-archive-key
  "(with-archive-key ring f) -> what (f key) returns; the key is back on the ring afterwards"
  [ring f]
  (with [key (array/pop ring) (fn [key] (array/push ring key))]
    (f key)))
