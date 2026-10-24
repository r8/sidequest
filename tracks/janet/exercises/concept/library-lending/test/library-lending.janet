(import test :as t)
(import ../library-lending :as sol)

(t/deftest "1. reading returns what the reader returns"
  (def shelf @{"Emma" :in})
  (t/assert-equal "enjoyed Emma" (sol/read-here shelf "Emma" (fn [title] (string "enjoyed " title)))))

(t/deftest "1. the book is being read meanwhile"
  (def shelf @{"Emma" :in})
  (t/assert-equal :reading (sol/read-here shelf "Emma" (fn [title] (shelf title)))))

(t/deftest "1. the book is back afterwards"
  (def shelf @{"Emma" :in "Persuasion" :out})
  (sol/read-here shelf "Emma" (fn [title] nil))
  (t/assert-equal {"Emma" :in "Persuasion" :out} shelf))

(t/deftest "1. a dropped book is still put back"
  (def shelf @{"Emma" :in})
  (t/assert-error "dropped it" (sol/read-here shelf "Emma" (fn [title] (error "dropped it"))))
  (t/assert-equal {"Emma" :in} shelf))

(t/deftest "2. lending returns the card"
  (def shelf @{"Emma" :in})
  (t/assert-equal {:title "Emma" :due "May 3"} (sol/lend shelf "Emma" (fn [title] {:title title :due "May 3"}))))

(t/deftest "2. a lent book is out"
  (def shelf @{"Emma" :in "Persuasion" :in})
  (sol/lend shelf "Persuasion" (fn [title] :card))
  (t/assert-equal {"Emma" :in "Persuasion" :out} shelf))

(t/deftest "2. the book is out while the card is filled in"
  (def shelf @{"Emma" :in})
  (t/assert-equal :out (sol/lend shelf "Emma" (fn [title] (shelf title)))))

(t/deftest "2. a failed card puts the book back and passes the error on"
  (def shelf @{"Emma" :in})
  (t/assert-error "no library card" (sol/lend shelf "Emma" (fn [title] (error "no library card"))))
  (t/assert-equal {"Emma" :in} shelf))

(t/deftest "3. the room keeps its log"
  (def log @[])
  (t/assert-true (= log ((sol/reading-room log) :log))))

(t/deftest "3. closing the room logs it"
  (def log @["opened"])
  (def room (sol/reading-room log))
  (:close room)
  (t/assert-equal ["opened" "room closed"] log))

(t/deftest "3. a room is a table"
  (t/assert-true (table? (sol/reading-room @[]))))

(t/deftest "4. studying returns the result"
  (t/assert-equal :done (sol/study @[] (fn [room] :done))))

(t/deftest "4. the room is closed after studying"
  (def log @[])
  (sol/study log (fn [room] (array/push (room :log) "studied maps")))
  (t/assert-equal ["studied maps" "room closed"] log))

(t/deftest "4. the room is closed even when studying fails"
  (def log @[])
  (t/assert-error "fell asleep" (sol/study log (fn [room] (error "fell asleep"))))
  (t/assert-equal ["room closed"] log))

(t/deftest "5. the last key on the ring is used"
  (def ring @["brass key" "iron key"])
  (t/assert-equal "opened with the iron key" (sol/with-archive-key ring (fn [key] (string "opened with the " key)))))

(t/deftest "5. the key is off the ring meanwhile"
  (def ring @["brass key" "iron key"])
  (t/assert-equal ["brass key"] (sol/with-archive-key ring (fn [key] (array/slice ring)))))

(t/deftest "5. the key is back afterwards"
  (def ring @["brass key" "iron key"])
  (sol/with-archive-key ring (fn [key] nil))
  (t/assert-equal ["brass key" "iron key"] ring))

(t/deftest "5. the key comes back even when the archive is flooded"
  (def ring @["iron key"])
  (t/assert-error "flooded" (sol/with-archive-key ring (fn [key] (error "flooded"))))
  (t/assert-equal ["iron key"] ring))

(t/run)
