(defn read-here
  "(read-here shelf title f) -> what (f title) returns; the book is :reading meanwhile and :in afterwards"
  [shelf title f]
  (error "implement me"))

(defn lend
  "(lend shelf title f) -> what (f title) returns; the book is :out, or back :in if f fails"
  [shelf title f]
  (error "implement me"))

(defn reading-room
  "(reading-room log) -> table with :log and a :close method that logs \"room closed\""
  [log]
  (error "implement me"))

(defn study
  "(study log f) -> what (f room) returns; the room is closed afterwards"
  [log f]
  (error "implement me"))

(defn with-archive-key
  "(with-archive-key ring f) -> what (f key) returns; the key is back on the ring afterwards"
  [ring f]
  (error "implement me"))
