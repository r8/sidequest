(defn spell-name
  "(spell-name words) -> symbol; the words joined with dashes"
  [words]
  (symbol (string/join words "-")))

(defn spell?
  "(spell? x) -> boolean; true for a parenthesised tuple starting with a symbol"
  [x]
  (and (tuple? x)
       (= :parens (tuple/type x))
       (symbol? (first x))))

(defn write-spell
  "(write-spell name power) -> the form (name power)"
  [name power]
  ~(,name ,power))

(defn chain
  "(chain spells) -> the form (do spell…)"
  [spells]
  ~(do ,;spells))

(defn brew
  "(brew operator amounts) -> the value of (operator amount…)"
  [operator amounts]
  (eval ~(,operator ,;amounts)))
