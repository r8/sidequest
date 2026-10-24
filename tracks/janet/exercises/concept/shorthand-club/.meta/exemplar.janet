(defmacro twice
  "(twice form) -> runs form two times; the value of the second run"
  [form]
  ~(do ,form ,form))

(defmacro when-positive
  "(when-positive n & body) -> runs body when n > 0; nil otherwise"
  [n & body]
  ~(if (> ,n 0) (do ,;body)))

(defmacro show
  "(show form) -> [form value]; the form as code and its value"
  [form]
  ~[',form ,form])

(defmacro defshort
  "(defshort short expr) -> defines short as the value of expr"
  [short expr]
  ~(def ,short ,expr))

(defmacro square
  "(square expr) -> the square of expr, evaluated once"
  [expr]
  (def value (gensym))
  ~(do (def ,value ,expr) (* ,value ,value)))
