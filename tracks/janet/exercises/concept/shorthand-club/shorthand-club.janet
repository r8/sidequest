(defmacro twice
  "(twice form) -> runs form two times; the value of the second run"
  [form]
  (error "implement me"))

(defmacro when-positive
  "(when-positive n & body) -> runs body when n > 0; nil otherwise"
  [n & body]
  (error "implement me"))

(defmacro show
  "(show form) -> [form value]; the form as code and its value"
  [form]
  (error "implement me"))

(defmacro defshort
  "(defshort short expr) -> defines short as the value of expr"
  [short expr]
  (error "implement me"))

(defmacro square
  "(square expr) -> the square of expr, evaluated once"
  [expr]
  (error "implement me"))
