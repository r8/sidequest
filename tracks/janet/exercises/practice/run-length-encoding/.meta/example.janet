(defn encode
  "(encode text) -> text with each run of two or more equal characters replaced by its length and the character"
  [text]
  (string (peg/replace-all ~(* (<- 1 :c) (some (backmatch :c)))
                           (fn [run &] (string (length run) (string/slice run 0 1)))
                           text)))

(defn decode
  "(decode text) -> the run-length encoded text expanded back"
  [text]
  (string (peg/replace-all ~(* (number :d+) (<- 1))
                           (fn [_ n c] (string/repeat c n))
                           text)))
